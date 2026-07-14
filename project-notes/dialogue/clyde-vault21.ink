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
+ [No, who are you?]
    Clyde: Oh, I'm nobody.
    -> topic_menu

=== what_doing_here ===
Clyde: Same thing as you.
+ [I don't know what you're talking about.]
    Clyde: Sarah, obviously. She's the most beautiful girl in the whole world.
    -> sarah_menu

=== sarah_menu ===
+ [Oh, okay then. Good luck.]
    Clyde: Thanks!
    -> topic_menu
+ [Have you talked to her?]
    Clyde: No, I'm waiting for the right moment.
    ++ [When is that?]
        Clyde: Oh, I'll know when I know. Soon. Probably.
        -> sarah_menu
+ [She's way out of your league.]
    Clyde: You just want her to yourself! She's mine, stay away from her.
    -> topic_menu

=== vault_suit ===
Clyde: From my vault.
+ [You're a vault dweller?]
    Clyde: Yep!
    -> vault_dweller_menu

=== vault_dweller_menu ===
+ [What are you doing out here?]
    Clyde: I need some stuff for my vault.
    -> parts_menu
+ [What do you think about the wasteland?]
    Clyde: It's bright! And really hot. And the food sucks. And it smells. And the bugs are really really big. Have you ever seen a bug before? I'd only read about them in books, but they're WAY bigger than I thought.
    -> vault_dweller_menu
+ [How's life in the vault?]
    Clyde: It's nice. A lot better than out here. A bit boring, but I like boring.
    -> vault_dweller_menu
+ [What do you think about the NCR?]
    Clyde: They're nice I guess, but always drunk. I'm not sure how you can be successful when you're always that drunk.
    -> vault_dweller_menu
+ [How'd you get here?]
    Clyde: When I left the vault, I didn't know where to go. But I saw that really tall tower and thought that was a good place to go as any. I walked for a long time, and found my way here.
    -> vault_dweller_menu
+ [What do you think of the casinos?]
    Clyde: The Tops is nice. They talk funny. The Ultra Luxe is really clean, like the vault, but there's something weird about those guys. The masks creep me out. I don't like Gomorrah. It's... scary in there. Too much for me.
    -> vault_dweller_menu

=== parts_menu ===
+ [What stuff?]
    Clyde: I'm not really supposed to tell anyone. I just need to find it.
    -> parts_menu
+ [Are you looking for "stuff" in here?]
    Clyde: Not really. I mean I guess they could be here, but probably not.
    -> parts_menu
+ [How is the search going?]
    Clyde: Bad!
    ++ [What's the problem?]
        Clyde: I can't find the stuff anywhere. I mean, how am I even supposed to know what reactor parts look like? Much less find them! I'll never get this fixed.
        -> offer_help_menu

=== offer_help_menu ===
+ [\[Perception\] Reactor parts? Like a nuclear reactor?]
    Clyde: Um... I wasn't supposed to tell you that...
    -> offer_help_menu
+ [\[Energy Weapons (pass)\] I have a lot of experience with microfusion reactors. I might be able to help with your reactor problem.]
    Clyde: Oh, well, I guess you might be able to help. I'll give you the access code to the vault, and you can fix it.
    -> vault_fix_dialog
+ [\[Energy Weapons (fail)\] I have a lot of experience shooting laser guns. What's better than leaving behind nothing but a pile of ash? I'm sure I can do the same for your reactor.]
    Clyde: Um... I think I'd prefer to find someone with a bit more experience.
    -> offer_help_menu
+ [\[Repair (pass)\] I'm pretty handy, I'm sure I could help you find a fix for whatever issue you're experiencing.]
    Clyde: Oh, well, I guess you might be able to help. I'll give you the access code to the vault, and you can fix it.
    -> vault_fix_dialog
+ [\[Repair (fail)\] I always carry duct tape with me, what other parts could you need? I'm sure I can help you fix whatever issue you're having.]
    Clyde: Um, I'm not sure this is a problem that duct tape can fix. Thanks for offering.
    -> offer_help_menu
+ [\[Science (pass)\] I have a background in applied physics, if the issue you have is a technical one I might be able to help.]
    Clyde: Oh, well, I guess you might be able to help. I'll give you the access code to the vault, and you can fix it.
    -> vault_fix_dialog
+ [\[Science (fail)\] I have some serious science skills. I bet I could science you a fix, no problem.]
    Clyde: Um, that's okay. I'm sure I'll be able to find the parts I need. Thanks anyway.
    -> offer_help_menu

=== vault_fix_dialog ===
+ [Thanks, see you later.]
    -> END
+ [Wait, you aren't coming with me?]
    Clyde: No, I'm gonna stay here. I still need to talk to Sarah.
    -> join_me_menu

=== join_me_menu ===
+ [\[Terrifying Presence\] You'll come with me or I'll chop your arms off and feed them to you.]
    Clyde: Oh, um... alright, let's go.
    -> END
+ [Sorry man, I'm already dating Sarah. She's not gonna go out with you.]
    // Only available if the player has slept with Sarah.
    Clyde: Oh, um... alright, let's go.
    -> END
+ [\[Confirmed Bachelor\] Screw Sarah. Come with me and I'll show you a different type of companionship.]
    Clyde: Oh, cool, I'll hang out with you. Let's go.
    -> END
+ [\[Black Widow\] Sarah isn't going to give you what you need. Come with me and I'll show you what love really feels like.]
    Clyde: Oh! Um... okay! That sounds nice. Let's go.
    -> END

=== why_pale ===
Clyde: Hey, fuck you man. Why are you so ugly?
+ [Sorry, didn't know you were so sensitive about it.]
    Clyde: That's okay.
    -> topic_menu
+ [\[Terrifying Presence\] Talk to me like that again and see what happens.]
    Clyde: Oh... oh. Okay. Sorry, I'm sorry, I shouldn't have said that. You're right. Nevermind.
    -> topic_menu
