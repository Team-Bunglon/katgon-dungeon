# v1.1.0
After the development of Phantom Striker, I decide to update the game to follow the coding style of our latest project. This update includes codebase changes as well as new content for you to explore.

### Main Changes
- Added main menu and credit artwork.
- Added option menu to change the audio volume as well as window scaling and fullscreen mode.
- Version numbering now follows the format that Phantom Striker uses (1.Major.Minor)
- Codebase Changes: 
  - Refactored the codebase. There should be a little bit of extra performance as some of the useless code were removed.
  - Sorted project directory. Things are easier to find now.
  - Audio logic had been reworked. There shouldn't be any more loud, clipping sounds caused by multiple object playing the same sound at once.
  - Music and Sound has its own different buses and can be adjusted separately in the option menu.

### Dungeon Changes
- Added four new rooms to extend the main game (totaling 32 rooms).
  - Now there are 10 golden cherries to collect. 
- Made the secret room more elusive to be entered.
- Help tiles now properly reacts to any number of characters who stepped on it.
  - The help tile in "Rubble on the Double" should give you a hint on how to solve the next puzzle instead of being a waste of space.
- Spike Tiles that can be activated off screen will now display a minicam showing its process.
  - This lets the player know which spike tile they have activated across different rooms.
  - The spike tile must be offscreen to show the minicam. It won't show the minicam otherwise.
  - Not all spike tiles will show this minicam, however.
- Spike Tiles that require exact yellow button combination now has its own sprite.
  - New visual and audio indicator have been added to show when this spike is disabled (can't be raised again) after being stepped on.
- Adjusted z-index for individual wall tile.
  - As a result, Kat's shockwave sprite now only appears bellow the wall and the ceilling.
- Adjusted Gon's flameball position when being fired to allow shooting at the edge of a flame tile.
- Added screen shake and flash effect on obtaining the golden dragon fruit.
- Updated sprite for dual flame/frostfire tile.
- Updated map.
- Added some references to Phantom Striker.

### Bug Fixes
- Fixed a bug where the status UI doesn't change the leader sprite when splitting to your partner.
- Hopefully fixed a rare bug where Gon would shoot his fireball right after splitting to him this time.

# v1.0.1.0
- Tweaked some rooms for the following:
    - “Button Mashing” and “Rubble on the Double” -> Prevented possible softlock.
    - “Split Brain” -> Made it slightly harder to solve.
    - “The First Task” -> Renamed to “The First Conundrum”, the room’s original name.
    - Few other rooms -> Updated path tiles and fixed some mismatched wall tiles.
- Added version number on the title screen.
- Updated sprite for Kat and Gon.
- Changed the way the collision for the partner works. Now they wouldn’t get stuck around the corner and split up when being too far from the leader as the result.
- Fixed a bug where Gon would face towards Kat instead of south when starting the game.
- Fixed a bug that allowed you to switch character when attacking.
- Fixed a rare bug where Gon would shoot his fireball right after splitting to him.

# v1.0.0.0
- Initial Release
