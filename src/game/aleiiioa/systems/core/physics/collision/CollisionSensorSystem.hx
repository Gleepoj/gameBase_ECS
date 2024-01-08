package aleiiioa.systems.core.physics.collision;

import aleiiioa.components.core.level.ChunkCollisionLayer;
import aleiiioa.components.core.physics.collision.CollisionSensor;

import aleiiioa.components.core.physics.velocity.VelocityComponent;
import aleiiioa.components.core.physics.position.*;


import echoes.Entity;

class CollisionSensorSystem extends echoes.System {
    
    //public var chunk(get,never) : chunk; inline function get_level() return Game.ME.chunk;
    
    public function new() {    
    }

    @u function cooldownUpdate(dt:Float,cl:CollisionSensor) {
        cl.cd.update(dt);
    }

    @u public function updateListener(entity:echoes.Entity,gp:GridPosition,cl:CollisionSensor,vc:VelocityComponent,chunk:ChunkCollisionLayer) {
        if(entity.isValid() && !entity.exists(GridPositionOffset)){
            cl.on_ground = chunk.hasCollision(gp.lcx,gp.lcy+1) && vc.dy == 0 && gp.yr == 0.5;
            cl.on_land   = chunk.hasCollision(gp.lcx,gp.lcy+1) && vc.dy > 0;
            cl.on_ceil   = chunk.hasCollision(gp.lcx,gp.lcy-1);
            cl.on_left   = chunk.hasCollision(gp.lcx-1,gp.lcy);
            cl.on_right  = chunk.hasCollision(gp.lcx+1,gp.lcy); 
            cl.on_fall   = vc.dy > 0 ; 
            cl.on_jump   = vc.dy < 0 ; 
            if(cl.onGround){
                cl.cd.setMs("onGround",10);
            }
   
            
        }
    }

}