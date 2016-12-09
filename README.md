PartyP v0.1b
This is an addon for Windower that displays Party HP% and MP% horizontally across the screen just above the chat box.

Special Thanks to Mike McKee author of Enemybar, Morath86 author of barfiller, 
Cliff author of TParty, and sdahlka on the windower forums.  Looking at the 
coding of their various pieces really helped me piece this together.
Huge Thanks to Iryoku for helping me condense the coding and teaching me a bit of lua.

Current Screenshot available here:

http://orig04.deviantart.net/4325/f/2016/333/4/8/custom_ffxi_windower_addon_by_allibear17-daq12lc.jpg

Screenshot taken on 1600x900 at 1.5 ui scale.

List of Settings.xml variables and what they control:
<font_size>,  controls the font_size of the displays
<pet> Has an X, and Y to control where the pet HP% displays shows.
<pos> Has X and Y to control where your HP% and MP% display, the rest of the party will be added to the right of this
<step> X controls the distance horizontally between each party member's display (smaller makes them closer together)
       Y controls the distance vertically between each member's HP and MP displays.

Changelog 
v0.3
- Altered code to run every 30th frame, instead of every frame.

v0.2
- Changed variable names to be more clear
- Reworked some of the code (Thanks Iryoku)
- Added MP display
- Added variables to control PetHP% display

v0.1b
- PartyP correctly reads the settings file now.
