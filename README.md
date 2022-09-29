# About

**A lightweight and simple base structure for games, using *[Heaps](https://heaps.io)* framework  and *[Haxe](https://haxe.org)* language.**

Gamebase_ECS is a transcription of *[gameBase](https://github.com/deepnight/gameBase)* by *[deepnight](https://github.com/deepnight)* for Heaps.io in an Entity Component System paradigm , based on *[echo](https://github.com/deepcake/echo)* ECS framework by *[deepcake](https://github.com/deepcake)* .

If you're not familiar with Haxe and Heaps.io see install instructions *[here](https://deepnight.net/tutorial)*


# Install gameBase_ECS

 1. Install required libs by running the following command **in the root of the repo**: `haxe setup.hxml`

# Features 
 
 1. gameBase_ECS feature most of *[gameBase](https://github.com/deepnight/gameBase)* functionality like physics system , sprite rendering, 	  squash and stretch, LDtk binding, console stats etc.
 2. ++ An embryo of particules system which is quite confuse and poorly customizable for the moment.
 3. ++ A prototype of a dialog system using *[hxyarn](https://github.com/cxsquared/hxyarn)* by *[cxsquared](https://github.com/cxsquared)*
 4. There is no camera system for the moment.

# Compile

From the command line, run either:

 - For **DirectX**: `haxe hl.dx.hxml`
 - For **OpenGL**: `haxe hl.sdl.hxml`
 - For **Javascript/WebGL**: `haxe js.hxml`

The `hl.debug.hxml` is just a shortcut to one of the previous ones, with added `-debug` flag.

Run the result with either:

 - For **DirectX/OpenGL**: `hl bin\client.hl`
 - For **Javascript**: `start run_js.html`

# Issues

 - If you have issues with compiling maybe it come from the fact that you had to use my fork of deepcake/echo and cxsquared/hxyarn 
   and setup.hxml have not work as intended 


# Cleanup for your own usage

You can safely remove the following files/folders from repo root:

- `.github/`
- `LICENSE`
- `README.md`
- `CHANGELOG.md`



Latest release notes: [View changelog](CHANGELOG.md).