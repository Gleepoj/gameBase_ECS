package aleiiioa.systems.core;

import aleiiioa.components.core.BoundingBox;

class LevelCollisionsSystem extends echoes.System {
    public var level(get,never) : Level; inline function get_level() return Game.ME.level;
    public var camera(get,never): Camera; inline function get_camera() return Game.ME.camera; 

    public function new() {
        
    }

    /** Return TRUE if the Entity *center point* is in screen bounds (default padding is +32px) **/
	public inline function isOnScreenCenter(padding=32,bb:BoundingBox) {
		return camera.isOnScreen( bb.centerX, bb.centerY, padding + M.fmax(bb.wid*0.5, bb.hei*0.5) );
	}

	/** Return TRUE if the Entity rectangle is in screen bounds (default padding is +32px) **/
	public inline function isOnScreenBounds(padding=32, bb:BoundingBox) {
		return camera.isOnScreenRect( bb.left,bb.top, bb.wid, bb.hei, padding );
	}

}