# EmberCourtHelper ver 1.0.0

**EmberCourtHelper** is a _World of Warcraft_ addon designed to assist players with maximizing rewards from the Ember Court, the Venthyr Covenant's signature feature.


As a member of the Venthyr Covenant, it is your responsibility to rally the denizens of the Shadowlands under the banner of rebellion against the traitorous Sire Denathrius. What better way is there to make allies than to throw an extravagant party?

The Ember Court is a weekly in-game event that tasks the player with hosting a party for various non-player characters (NPCs). The player can invite up to 4 NPC guests. Each guest has different preferences for what they enjoy at a party.

There are five main attributes of an Ember Court Party:
- **Cleanliness**: Your court can be either **Clean** or **Messy**.
- **Danger**: Your court can be either **Safe** or **Dangerous**.
- **Decadence**: Your court can be either **Humble** or **Decadent**.
- **Excitement**: Your court can be either **Relaxing** or **Exciting**.
- **Formality**: Your court can be either **Casual** or **Formal**.

Out of these five attributes, each NPC guest has up to 3 preferences that lean either way. For example, guest A might prefer a clean, safe, and relaxed party environment, whereas guest B prefers to have a high-energy, deviously decadent baccharal. 

The player gains a higher "happiness" score with each NPC based on how well they cater the party to their tastes. At the end of the party, each NPC gives you rewards based on how closely you conformed the party to their preferences. So you can try to please guest A as much as possible, and get the best rewards they have to offer, but then guest B won't have a good time, and you'll get basically nothing from them. As such, you must decide each week whose happiness you will value more.

With **EmberCourtHelper**, the user can input the specific guests that they would like to host at the Ember Court that week. The addon will then run an algorithm to determine which combination of attributes will maximize the total score possible for that combination of guests. When deciding which way to sway a certain attribute, the algorithm gives priority to guests that do not yet have an established positive relationship with the player. (Each guest NPC has a "reputation" bar - by inviting a guest and making them happy, you increase your standing with them, so then they will have a higher chance of giving you better rewards at future Ember Courts without focusing on their happiness alone.) If the weights toward each side of an attribute is equal - for example, if 2 guests prefer Messy and 2 guests prefer Clean - then the algorithm will make a random selection between Messy or Clean. This is because it won't make a difference which one is chosen; for that specific combination of guests and their reputation standings, the same overall benefit to the player will occur either way.

The addon is lightweight - it uses only 25 kb of in-game memory - and comes with a simple, clean user interface.

![image](https://user-images.githubusercontent.com/70063561/135683658-acce2456-17b8-4598-96c6-b476cefa56fb.png)

**Installation**
To install EmberCourtHelper: 
- Download the repository as a `.zip` file.
- Extract the contents of the `.zip` to the WoW addons folder.
  - For Windows users, the default addon installation folder is `C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns`.
  - If you are on a different operating system or you installed the game files in another location, you can check the install location on the Battle.net launcher.
    - Open the World of Warcraft in Battle.net.
    - Open the game options right next to the "Play" button.
    - Click game settings and view the "Install Location" tab.

**Planned Future Updates**
- An algorithm to weight the different options for party amenities. This would let the player know which selection to choose from the Entertainment, Refreshments, Decoration, and Security options.
- In-court tips/guides on how to complete the mini events that spawn during the court.
