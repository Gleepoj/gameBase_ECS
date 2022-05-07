package aleiiioa.systems.collisions;

import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.flags.collision.*;

import echoes.Entity;

class LevelCollisionsSystem extends echoes.System {
    public var level(get,never) : Level; inline function get_level() return Game.ME.level;
    public var camera(get,never): Camera; inline function get_camera() return Game.ME.camera; 
    
    public function new() {
        
    }

	public inline function isOnScreen(gp:GridPosition) {
		return camera.isOnScreen(gp.attachX, gp.attachY, 0);
	}

    @u public function destroyObjectOnWallCollision(entity:Entity,gp:GridPosition,bf:BodyFlag) {
        if(entity.isValid()){
            if(level.hasCollision(gp.cx,gp.cy)){
                if(!entity.exists(IsDiedFlag)){
                    entity.add(new IsDiedFlag());
                }
            }
        }
    }

}