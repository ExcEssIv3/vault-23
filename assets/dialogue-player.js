// Minimal playable widget for .ink dialogue trees, using vendored inkjs (assets/vendor/ink-full.js).
// Usage: VaultDialogue.mount(containerEl, "path/to/file.ink")

(function () {
  function renderLine(container, text) {
    var p = document.createElement("p");
    p.className = "dlg-line";
    var colonIndex = text.indexOf(":");
    if (colonIndex > -1 && colonIndex < 24) {
      var speaker = text.slice(0, colonIndex);
      var rest = text.slice(colonIndex + 1).trim();
      p.innerHTML = "<strong>" + speaker + ":</strong> " + rest;
    } else {
      p.textContent = text;
    }
    container.appendChild(p);
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

  function renderChoices(container, story, log, visited, onDone) {
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
        advance(story, log, container, visited, onDone);
      });
      choicesEl.appendChild(btn);
    });
    container.appendChild(choicesEl);
  }

  // Fallout-style dialogue box: each choice replaces the displayed text rather
  // than appending to a running log. Drains every line up to the next real
  // decision point and shows only that response, plus the choices that follow it.
  function advance(story, log, choicesContainer, visited, onDone) {
    log.innerHTML = "";
    while (story.canContinue) {
      var text = story.Continue().trim();
      if (text.length > 0) renderLine(log, text);
    }
    renderChoices(choicesContainer, story, log, visited, onDone);
  }

  function mount(root, inkUrl) {
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
          advance(story, log, choicesContainer, visited);
        });
        restartWrap.appendChild(restartBtn);

        root.appendChild(log);
        root.appendChild(choicesContainer);
        root.appendChild(restartWrap);

        advance(story, log, choicesContainer, visited);
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
