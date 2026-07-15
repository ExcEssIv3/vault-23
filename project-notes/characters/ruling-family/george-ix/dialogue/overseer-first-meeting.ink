// George IX — First Meeting (immediately follows clyde-overseer-arrival.ink)
// One leave_menu, but which options are actually available depends on what
// the player learned from Clyde beforehand (see clyde-vault21.ink):
//   - No knowledge: just "Ok, fine." and the general trust-building offer.
//   - Knows Clyde was sent to find "parts" (but not that they're reactor
//     parts specifically): can bring that up, but the Overseer shuts it down.
//   - Full reactor knowledge (passed the [Perception] check in
//     clyde-vault21.ink's offer_help_menu): can open the Speech/Barter
//     attempts to skip straight to being sent off with George X.
// Open question: how the correct set of options actually gets filtered in
// based on the player's real knowledge state isn't wired up yet — for now
// all three are just present together, annotated with which state unlocks
// each one.

-> overseer_meeting

=== overseer_meeting ===
Overseer: Look, I don't know what Clyde told you, but you can't stay here. You need to leave.
-> leave_menu

=== leave_menu ===
+ [Ok, fine.]
    -> END
+ [Wait! I know there's something wrong, Clyde mentioned he was looking for parts. I can help you.]
    // Available once the player knows Clyde was sent to find "parts," but
    // before confirming (via the Perception check in clyde-vault21.ink's
    // offer_help_menu) that they're specifically reactor parts.
    Overseer: Clyde didn't tell you the problem for a reason.
    // "Maybe there's something else..." isn't an immediate leave_menu option —
    // it only follows a rebuffed "Wait!" attempt, here as the sole next line.
    ++ [Maybe there's something else I can do to earn your trust. I'm sure you guys have some other issues down here that someone with access to the outside can help with.]
        Overseer: If you really want to help, then yes, there are some people you can speak to. Silas, our doctor; Haley, our lead cook; and Phil, in the armory all have things you can help with. But we're watching you, try anything funny and you'll be out of here faster than you can say 'Vault Tec'.
        -> END
+ [Wait! I know you're having problems with your reactor, I can help you.]
    // Available only with full reactor knowledge (the Perception check above
    // has been passed).
    Overseer: How do you know that?
    ++ [Clyde might have mentioned it.]
        // Delivery note: "Really?" lands with sharp negative emphasis —
        // think Jan reacting to hearing what Michael's done in the office.
        Overseer: Really? Well, it doesn't matter, I can't just let any outsider come and tamper with our reactor. How can I trust you?
        -> trust_menu

=== trust_menu ===
+ [\[Speech (pass)\] What could go wrong? Your reactor is already damaged, and it's not going to fix itself.]
    Overseer: Fair enough. But I'm sending you with my son, he's going to make sure you don't try anything funny.
    // Skips the §3.2 trust-building requirement entirely.
    -> END
+ [\[Speech (fail)\] I'm a nice guy, promise! I just want to help.]
    Overseer: Right, you walked all the way here through the dangerous wasteland because you're a 'nice guy'.
    -> trust_menu
+ [\[Barter (pass)\] You can trust me because you're going to pay me. In the wasteland, bottle caps are currency. Give me all the old bottlecaps the vault has, and I'll fix your reactor.]
    Overseer: Bottle caps, huh? Down here they're just waste. Fair enough. But I'm sending you with my son, he's going to make sure you don't try anything funny.
    -> END
+ [\[Barter (fail)\] We can trade or something. I'm sure you guys have a bunch of cool stuff lying around. Let me take what I want and I'll fix your reactor.]
    Overseer: I don't know who you think I am, but I'm not the kind of guy who you want to try and shake down.
    -> trust_menu
+ [Maybe there's something else I can do to earn your trust. I'm sure you guys have some other issues down here that someone with access to the outside can help with.]
    Overseer: If you really want to help, then yes, there are some people you can speak to. Silas, our doctor; Haley, our lead cook; and Phil, in the armory all have things you can help with. But we're watching you, try anything funny and you'll be out of here faster than you can say 'Vault Tec'.
    -> END
