// Clyde — Vault 21 Dialogue (Unresolved State)
// Talkable fixture in Vault 21's dining room, no quest marker.
// See ../story-beats.md#31-discovery--vault-21 for the mechanics this dialogue serves
// (Perception check on his slip, Repair/Science/Energy Weapons convince checks,
// the Sarah-leverage option, the kill-for-key alternative).
// See ../characters/misc/clyde.md for his broader characterization.
//
// Tone: upbeat, opens warm. Frustrated by his situation but doesn't accept any of
// the blame for it — and to be fair to him, "find reactor parts" is an impossibly
// vague assignment out in the wasteland regardless of how competent the person sent
// to do it is. Not self-aware about his own cowardice (the Sarah situation);
// defensive rather than pitiable when pressed.
//
// What he actually knows: something's wrong with the reactor, and he was sent to
// get parts to fix it. Nothing about the pregnancies or the radiation program —
// that's genuinely outside what he was told.

Clyde: Hi! I'm Clyde!
-> topic_menu

=== topic_menu ===
+ [Who are you?] -> who_are_you
+ [What are you doing here?] -> what_doing_here
+ [Where'd you get that vault suit?] -> vault_suit
+ [Why are you so pale?] -> why_pale
+ [Goodbye] -> END

=== who_are_you ===
Clyde: I just told you, I'm Clyde.
Player: No, who are you?
Clyde: Oh, I'm nobody.
-> topic_menu

=== what_doing_here ===
TODO: transcribe "What are you doing here?" answer
-> topic_menu

=== vault_suit ===
TODO: transcribe "Where'd you get that vault suit?" answer
-> topic_menu

=== why_pale ===
TODO: transcribe "Why are you so pale?" answer
-> topic_menu
