// Minimal playable widget for .ink dialogue trees, using vendored inkjs (assets/vendor/ink-full.js).
// Usage: VaultDialogue.mount(containerEl, "path/to/file.ink", {
//   portraits: {
//     "Speaker Name": { closed: "assets/portraits/x/closed.png", open: "...", blink: "..." }
//   }
// })
// Portraits are optional and keyed by the exact speaker label used before the
// ":" in the .ink source (a character can have more than one label across
// files — e.g. "Overseer" vs "Overseer George IX" — so alias both keys to the
// same frame set). Missing images fail silently (the portrait pane just stays
// hidden) so this is safe to wire up before any art exists.

(function () {
  // Talking-frame swap cadence, and how long to "talk" per character of text
  // (clamped) before settling back to an idle/blink loop — there's no audio
  // track to sync to, so this just approximates reading time.
  var TALK_FRAME_MS = 140;
  var MS_PER_CHAR = 45;
  var MIN_TALK_MS = 600;
  var MAX_TALK_MS = 5000;

  function PortraitAnimator(config, wrapEl, imgEl) {
    this.config = config || {};
    this.wrap = wrapEl;
    this.img = imgEl;
    this.entry = null;
    this.speaker = null;
    this.talkTimer = null;
    this.settleTimer = null;
    this.blinkTimer = null;
    this.frameOpen = false;
  }

  PortraitAnimator.prototype.stop = function () {
    clearInterval(this.talkTimer);
    clearTimeout(this.settleTimer);
    clearTimeout(this.blinkTimer);
    this.talkTimer = null;
    this.settleTimer = null;
    this.blinkTimer = null;
  };

  // Switches the active portrait (if the speaker has one registered) and
  // shows the idle/closed frame. Returns true if a portrait is now showing.
  PortraitAnimator.prototype.setSpeaker = function (speaker) {
    this.stop();
    var entry = speaker ? this.config[speaker] : null;
    if (!entry || !entry.closed) {
      this.wrap.style.display = "none";
      this.entry = null;
      this.speaker = null;
      return false;
    }
    this.speaker = speaker;
    this.entry = entry;
    var wrap = this.wrap;
    this.img.onerror = function () {
      wrap.style.display = "none";
    };
    this.img.src = entry.closed;
    wrap.style.display = "";
    return true;
  };

  // Alternates the mouth-open/closed frames for a duration approximating how
  // long the given line takes to read, then settles into idle blinking.
  PortraitAnimator.prototype.talkFor = function (text) {
    if (!this.entry) return;
    var entry = this.entry;
    var img = this.img;
    var self = this;
    var duration = Math.max(MIN_TALK_MS, Math.min(MAX_TALK_MS, text.length * MS_PER_CHAR));

    if (entry.open) {
      this.frameOpen = false;
      this.talkTimer = setInterval(function () {
        self.frameOpen = !self.frameOpen;
        img.src = self.frameOpen ? entry.open : entry.closed;
      }, TALK_FRAME_MS);
    }

    this.settleTimer = setTimeout(function () {
      clearInterval(self.talkTimer);
      self.talkTimer = null;
      img.src = entry.closed;
      self.idle();
    }, duration);
  };

  PortraitAnimator.prototype.idle = function () {
    if (!this.entry || !this.entry.blink) return;
    var entry = this.entry;
    var img = this.img;
    var self = this;
    (function scheduleBlink() {
      var delay = 2000 + Math.random() * 3000;
      self.blinkTimer = setTimeout(function () {
        img.src = entry.blink;
        setTimeout(function () {
          if (self.entry === entry) img.src = entry.closed;
        }, 120);
        scheduleBlink();
      }, delay);
    })();
  };

  function createPortraitPane() {
    var wrap = document.createElement("div");
    wrap.className = "dlg-portrait";
    wrap.style.display = "none";
    var img = document.createElement("img");
    img.className = "dlg-portrait-img";
    img.alt = "";
    wrap.appendChild(img);
    return { wrap: wrap, img: img };
  }

  // Renders one line of dialogue, returning the parsed speaker label (or null
  // for unattributed/narrator lines) so the caller can drive the portrait.
  function renderLine(container, text) {
    var p = document.createElement("p");
    p.className = "dlg-line";
    var colonIndex = text.indexOf(":");
    var speaker = null;
    if (colonIndex > -1 && colonIndex < 24) {
      speaker = text.slice(0, colonIndex);
      var rest = text.slice(colonIndex + 1).trim();
      p.innerHTML = "<strong>" + speaker + ":</strong> " + rest;
    } else {
      p.textContent = text;
    }
    container.appendChild(p);
    return speaker;
  }

  function clearChoices(container) {
    var existing = container.querySelector(".dlg-choices");
    if (existing) existing.remove();
  }

  function choiceKey(choice) {
    // targetPath is stable per choice slot (e.g. "topic_menu.0.c-0") regardless
    // of how many times the story revisits it, so it works as a visited-tracking id.
    return choice.targetPath ? choice.targetPath.toString() : choice.text;
  }

  function renderChoices(container, story, log, visited, onDone, animator) {
    clearChoices(container);

    if (story.currentChoices.length === 0) {
      var end = document.createElement("p");
      end.className = "dlg-end";
      end.textContent = "\u2014 end of conversation \u2014";
      log.appendChild(end);
      if (onDone) onDone();
      return;
    }

    var choicesEl = document.createElement("div");
    choicesEl.className = "dlg-choices";
    story.currentChoices.forEach(function (choice, index) {
      var btn = document.createElement("button");
      var key = choiceKey(choice);
      btn.className = "dlg-choice" + (visited.has(key) ? " dlg-choice-visited" : "");
      btn.textContent = choice.text;
      btn.addEventListener("click", function () {
        visited.add(key);
        story.ChooseChoiceIndex(index);
        advance(story, log, container, visited, onDone, animator);
      });
      choicesEl.appendChild(btn);
    });
    container.appendChild(choicesEl);
  }

  function renderContinueButton(container, story, log, visited, onDone, animator) {
    clearChoices(container);
    var wrap = document.createElement("div");
    wrap.className = "dlg-choices";
    var btn = document.createElement("button");
    btn.className = "dlg-choice dlg-continue";
    btn.textContent = "▸ Continue";
    btn.addEventListener("click", function () {
      revealNext(story, log, container, visited, onDone, animator);
    });
    wrap.appendChild(btn);
    container.appendChild(wrap);
  }

  // Reveals exactly one visible line (auto-skipping blank/invisible output),
  // clearing whatever was shown before it — only ever one line on screen at
  // a time, whether it's the first line of a new response or another beat of
  // an unbroken cutscene stretch reached via the Continue prompt.
  function revealNext(story, log, choicesContainer, visited, onDone, animator) {
    while (story.canContinue) {
      var text = story.Continue().trim();
      if (text.length > 0) {
        log.innerHTML = "";
        var speaker = renderLine(log, text);
        if (animator) {
          animator.setSpeaker(speaker);
          animator.talkFor(text);
        }
        if (story.canContinue) {
          renderContinueButton(choicesContainer, story, log, visited, onDone, animator);
        } else {
          renderChoices(choicesContainer, story, log, visited, onDone, animator);
        }
        return;
      }
    }
    renderChoices(choicesContainer, story, log, visited, onDone, animator);
  }

  // Fallout-style dialogue box: picking a choice replaces the displayed text
  // rather than appending to a running log (pacing handled by revealNext).
  function advance(story, log, choicesContainer, visited, onDone, animator) {
    revealNext(story, log, choicesContainer, visited, onDone, animator);
  }

  function mount(root, inkUrl, options) {
    options = options || {};
    root.innerHTML = "";
    var loading = document.createElement("p");
    loading.className = "dlg-line dlg-loading";
    loading.textContent = "Loading dialogue\u2026";
    root.appendChild(loading);

    fetch(inkUrl)
      .then(function (res) {
        if (!res.ok) throw new Error("Could not load " + inkUrl);
        return res.text();
      })
      .then(function (source) {
        var compiler = new inkjs.Compiler(source);
        var story = compiler.Compile();
        var visited = new Set();

        root.innerHTML = "";
        var topRow = document.createElement("div");
        topRow.className = "dlg-top-row";
        var portrait = createPortraitPane();
        var animator = new PortraitAnimator(options.portraits, portrait.wrap, portrait.img);
        var log = document.createElement("div");
        log.className = "dlg-log";
        var choicesContainer = document.createElement("div");
        choicesContainer.className = "dlg-choices-wrap";
        var restartWrap = document.createElement("div");
        restartWrap.className = "dlg-restart-wrap";
        var restartBtn = document.createElement("button");
        restartBtn.className = "dlg-restart";
        restartBtn.textContent = "\u21ba Restart conversation";
        restartBtn.addEventListener("click", function () {
          story.ResetState();
          visited.clear();
          log.innerHTML = "";
          advance(story, log, choicesContainer, visited, null, animator);
        });
        restartWrap.appendChild(restartBtn);

        topRow.appendChild(portrait.wrap);
        topRow.appendChild(log);
        root.appendChild(topRow);
        root.appendChild(choicesContainer);
        root.appendChild(restartWrap);

        advance(story, log, choicesContainer, visited, null, animator);
      })
      .catch(function (err) {
        root.innerHTML = "";
        var errEl = document.createElement("p");
        errEl.className = "dlg-line dlg-error";
        errEl.textContent = "Dialogue failed to load: " + err.message;
        root.appendChild(errEl);
      });
  }

  window.VaultDialogue = { mount: mount };
})();
