package aleiiioa.systems.collisions;

import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.gun.BulletComponent;
import aleiiioa.components.flags.collision.*;
import aleiiioa.components.flags.*;
import echoes.Entity;

class LevelCollisionsSystem extends echoes.System {
    public var level(get,never) : Level; inline function get_level() return Game.ME.level;
    public var camera(get,never): Camera; inline function get_camera() return Game.ME.camera; 
    
    public function new() {
        
    }

    /** Return TRUE if the Entity *center point* is in screen bounds (default padding is +32px) **/
    // a remplacer par grid pos 
/* 	public inline function isOnScreenCenter(padding=32,bb:BoundingBox) {
		return camera.isOnScreen( bb.centerX, bb.centerY, padding + M.fmax(bb.wid*0.5, bb.hei*0.5) );
	}

	public inline function isOnScreenBounds(padding=32,bb:BoundingBox) {
		return camera.isOnScreenRect( bb.left,bb.top, bb.wid, bb.hei, padding );
	} */

    @u public function destroyObjectOnWallCollision(entity:Entity,gp:GridPosition) {
        if(entity.isValid()){
            if(level.hasCollision(gp.cx,gp.cy)){
                if(entity.exists(BodyFlag)){
                    if(!entity.exists(IsDiedFlag)){
                        entity.add(new IsDiedFlag());
                    }
                }
                if(entity.exists(BulletComponent)){
                    entity.destroy();
                } 
            }
        }
    }

}