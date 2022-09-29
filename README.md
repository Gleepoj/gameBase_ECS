# About

**A lightweight and simple base structure for games, using *[Heaps](https://heaps.io)* framework  and *[Haxe](https://haxe.org)* language.**

Gamebase_ECS is a transcription of deepnight *[gameBase](https://github.com/deepnight/gameBase)* for Heaps.io in an Entity Component System 

Latest release notes: [View changelog](CHANGELOG.md).

# Install


## Getting master

 1. Install **Haxe** and **Hashlink**: [Step-by-step tutorial](https://deepnight.net/tutorial/a-quick-guide-to-installing-haxe/)
 2. Install required libs by running the following command **in the root of the repo**: `haxe setup.hxml`

# Compile

From the command line, run either:

 - For **DirectX**: `haxe hl.dx.hxml`
 - For **OpenGL**: `haxe hl.sdl.hxml`
 - For **Javascript/WebGL**: `haxe js.hxml`

The `hl.debug.hxml` is just a shortcut to one of the previous ones, with added `-debug` flag.

Run the result with either:

 - For **DirectX/OpenGL**: `hl bin\client.hl`
 - For **Javascript**: `start run_js.html`

# Full guide



# Cleanup for your own usage

You can safely remove the following files/folders from repo root:

- `.github/`
- `LICENSE`
- `README.md`
- `CHANGELOG.md`


