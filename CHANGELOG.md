# v1.1.0
After the development of Phantom Striker, I decide to update the game to follow the coding style of our latest project. This update includes codebase changes as well as new content for you to explore.

### Major Changes
- Added main menu and credit artwork.
- Added four new rooms to extend the main game (totaling 32 rooms).
  - Now there are 10 golden cherries to find. 
- Made the secret room more elusive to be entered.
- Added some references to Phantom Striker.
- Added option menu to change the audio volume as well as window scaling and fullscreen mode.
- Codebase Changes: 
  - Refactored the codebase. There should be a little bit of extra performance as some of the useless code were removed.
  - Audio logic had been reworked. There shouldn't be any more loud, clipping sounds caused by multiple object playing the same sound at once.
  - Music and Sound has its own different buses and can be adjusted separately in the option menu.

### Minor Changes
- Version numbering now follows the format that Phantom Striker uses (1.Major.Minor)
- Help Tiles now properly reacts to any number of characters who stepped on it.
- Spike Tiles that require exact yellow button combination now has its own sprite.
  - New visual and audio indicator have been added to show when this spike is disabled (can't be raised again) after being stepped on.
- Updated sprite for dual flame/frostfire tile.

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
