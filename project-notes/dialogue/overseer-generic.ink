// George IX — Generic Dialogue
// Available any time after the player has met him (not tied to a specific
// story beat like clyde-overseer-arrival.ink or overseer-first-meeting.ink).
// Topic menu, player-repeatable.

Overseer George IX: How can I help you?
-> topic_menu

=== topic_menu ===
+ [Who are you?] -> who_are_you
+ [Why don't you let in any outsiders?] 
    Overseer George IX: Outsiders are a threat to the safety of this vault. I can't risk my family's safety by letting in strangers.
    -> topic_menu
+ [How is life in the vault?] -> life_in_vault
+ [Goodbye.]
    Overseer George IX: Goodbye.
    -> END

=== who_are_you ===
Overseer George IX: I'm George IX, son of George VIII and descendant of George I. I am the Overseer of this vault.
+ [How long have you been Overseer?]
    Overseer George IX: I became Overseer when my father died, 20 years ago.
    -> who_are_you
+ [George the Ninth? Could your mom not come up with a better name?]
    Overseer George IX: The eldest son of my line has always been named George. It's a symbol of the power in our bloodline.
    -> george_lineage_menu
+ [Let's talk about something else.]
    Okay.
    -> topic_menu

=== george_lineage_menu ===
+ [What is your bloodline?]
    We are the descendants of George Kingsley, the first Overseer of this vault.
    -> george_lineage_menu
+ [What do you mean the power in your bloodline?]
    The lineage of this family was born to rule. We were given this vault to protect that lineage, and when the time comes to enter the wasteland and rule.
    -> george_power_menu
+ [The power in your bloodline? What are you, magic?]
    I don't take kindly to an outsider coming in here and questioning me. Watch yourself, or I'll have you thrown out. Or worse.
    ++ [Works for me. (Attack)]
        -> END
    ++ [Let's talk about something else.]
        Okay.
        -> topic_menu
+ [Let's talk about something else.]
    Okay.
    -> topic_menu

=== george_power_menu ===
+ [When is the time to enter the wasteland?]
    Soon. In just a few generations, our time will come.
    -> george_power_menu
+ [What do you mean by "rule"?]
    We will take our rightful place as the rulers of the wasteland and bring order and safety to the world.
    -> george_power_menu
+ [What other families are in this vault?]
    There are no other families in this vault.
    ++ [Who were the original vault dwellers?]
        George Kingsley, his wife, and their two children.
        +++ [That's it?]
            Yes.
            ++++ [So, you're all related?]
                Yes.
                +++++ [Oooookay. Let's talk about something else.]
                    Okay.
                    -> topic_menu

+ [Let's talk about something else.]
    Okay.
    -> topic_menu

=== life_in_vault ===
Overseer George IX: Life in the vault is good. We have everything we need, and we are safe from the dangers of the wasteland.
+ [What do you eat?]
    Overseer George IX: We have a hydroponics lab we use to grow crops, as well as stores of prewar food. We also have a water purification system that provides us with clean drinking water.
    -> life_in_vault
+ [What do you do for fun?]
    Overseer George IX: We have a recreation room with games, and a library full of books. We also sometimes have movie nights in the atrium.
    -> life_in_vault
+ [Let's talk about something else.]
    Okay.
    -> topic_menu