# Game Design Document

- [Game Design Document](#game-design-document)
  - [Theme is Role Reversed](#theme-is-role-reversed)
  - [Pitch](#pitch)
  - [Todolist](#todolist)
  - [Details](#details)
  - [Random dump of idea](#random-dump-of-idea)

## Theme is Role Reversed

- Gender roles
- Reversed Role (playing game)
- an actor's part in a play, film, etc.
- the function assumed or part played by a person or thing in a particular situation

## Pitch

You are a young medieval merchant starting up in a new city. You took a loan to open your shop and now have to reinburse it.
As most merchants, your resources comes from posting quests at the local adventurer's guild. Study the market, put approriates risk-rewards on your quests and rise up throught the Merchant's Guild !

## Todolist

- Player
  - Player Status System and UI (gold/reputation)
  - Player Inventory System and UI
    - Sell item
- Adventurer's
  - Name
  - Class
  - (unlockable) Power level
  - (unlockable) Traits -> greedy, cowardly, courageous, vertuous, persevering...
  - (unlockable) Preferences -> more likely to take a specific type of quest (combat)
  - (unlockable) Desires -> more likely to take a quest with a specific reward
- Quest
  - Unique Quest Creation
    - Type -> defined by the objectives
    - Objectives
      - Bring X items (u get the items)
      - Kill X monsters (alter prices of certains items)
      - Expore X dungeon (u get random items)
      - many more
    - Expiration Date
    - Reward
  - Unique Quest Resolution
    - Find an adventurer
    - Adventurer tries to do each objectives of the quest, from start to end.
      - If fail, might retry or abandon it. If abandonned, the quest goes back to the list.
      - If success, come back to the guild to celebrate his success.
    - Quest aftermath.
- Loan
  - Loan Countdown System
  - Loan countdown UI
    - At the start of each day
  - Loan reimbursement day UI

## Details

Mostly UI :

- Inventory with your items
- Quest posting :
  - objective(s) which determine risk
  - reward(s)

Regular day :

1) Go to the adventurer's guild (one or no click)

Check for finished quests -> at the start of a day. Trade happen if it's on time.
Sometimes the quests are not finished by anyone for various reasons (time's up and nobody cleared the quest, risk/reward suck, quest is too difficult for the adventurers, bad luck...)

2) Start up new quests :

- Determine the objectives (from a list of item attainable)
- Determine the rewards (from your inventory, could be cash, could be others items)
- Determine when the quest is no longer valid
- You do not have to pay the rewards in advance (? might change)

3) Go home and sell a few items

Core interesting choices are between selling the cools items for maximum cash or giving them away to adventurers for even more cooler items.

Gaining Reputation makes you earn more money and gives you more interesting/complex quest possibility

## Random dump of idea

- ur the princess and you must escape/save the hero (super princess peach)
- using an important and seemingly centric item for another purpose entirely
  - A shield as an offensive weapon or a sword as a defensive one
  - using a bow to hit your opponent on the head (the bow is big)
- ur actually the vilain (remember that one flash game where you play as bowser and placed enemy on mario's path ?? I do)
- You are the quest giver
  - management game : some gauges goes down all the time (safety, resources...) and you must put up quests for adventurer to solve your problems.