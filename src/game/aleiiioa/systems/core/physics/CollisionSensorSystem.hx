package aleiiioa.systems.core.physics;

import aleiiioa.components.core.physics.VelocityComponent;
import aleiiioa.components.core.collision.CollisionSensor;
import aleiiioa.components.core.position.*;


import echoes.Entity;

class CollisionSensorSystem extends echoes.System {
    public var level(get,never) : Level; inline function get_level() return Game.ME.level;
    public var camera(get,never): Camera; inline function get_camera() return Game.ME.camera; 
    
    public function new() {
        
    }

	public inline function isOnScreen(gp:GridPosition) {
		return camera.isOnScreen(gp.attachX, gp.attachY, 0);
	}

    @u function cooldownUpdate(dt:Float,cl:CollisionSensor) {
        cl.cd.update(dt);
    }

    @u public function updateListener(entity:echoes.Entity,gp:GridPosition,cl:CollisionSensor,vc:VelocityComponent) {
        if(entity.isValid() && !entity.exists(GridPositionOffset)){
            cl.on_ground = level.hasCollision(gp.cx,gp.cy+1) && vc.dy == 0 && gp.yr ==1;
            cl.on_land   = level.hasCollision(gp.cx,gp.cy+1) && vc.dy > 0;
            cl.on_ceil   = level.hasCollision(gp.cx,gp.cy-1);
            cl.on_left   = level.hasCollision(gp.cx-1,gp.cy);
            cl.on_right  = level.hasCollision(gp.cx+1,gp.cy); 
            cl.on_fall   = vc.dy > 0 ; 
            cl.on_jump   = vc.dy < 0 ; 
            
        }
    }

}