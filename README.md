# Bountiful Basins - A Noita Mod

## What Is This

A mod for the game [Noita](https://store.steampowered.com/app/881100/Noita/).

More specifically, this mod overhauls how holy mountain portal basins select a random liquid. It adds a (configurable) weighted pool of materials that worldgen pulls from. It also adds a setting for how likely a basin will be empty, from 0-100% (base game: 90%, mod default: 75%).

Everything should be configurable, so if you don't like a specific material set the weight to 0 in the mod options menu.

Some settings can make the game significantly easier or harder, so be careful when changing weights.

## How To Use
Install it from the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3500779704) if you have a Steam copy of the game, it's easier and comes with automatic updates.

or

1. Download the entire repo and put it in `..\Noita\mods` (the mod directory is in the same location as `noita.exe`)
Note: This mod's directory must be named `bountiful_basins`, so rename it if it has changed while downloading
2. Enable the mod in Noita's mod menu
3. Start a new game

## Compatibility
This mod should detect modded materials and add them to the weighted pool. All modded materials will start with a weight of 0 and must be manually configured.

## License
All original parts of this software are released under the [MIT license](LICENSE.md). A non-exhaustive list of exceptions follows:
* Everything in the `lib/` directory retains the original licenses they were released under, they are only packaged here for convenience
* Nolla Games retains all rights to any portions of the file `data/scripts/biomes/temple_altar_top_shared.lua` not created for this mod
