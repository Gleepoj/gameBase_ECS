package aleiiioa.systems.core.physics.collision;


import aleiiioa.components.core.physics.collision.OnPreStepX;
import aleiiioa.components.core.physics.collision.OnPreStepY;
import aleiiioa.components.core.physics.collision.CollisionSensor;
import aleiiioa.components.core.physics.collision.affects.CollisionLayer_Wall;

import aleiiioa.components.core.physics.velocity.VelocityComponent;
import aleiiioa.components.core.physics.position.GridPosition;


class CollisionReactionEvent extends echoes.System {
    public var level(get,never) : Level; inline function get_level() return Game.ME.level;
    public function new (){

    }

    @a function wallCollisionOnPreStepX(en:echoes.Entity, add:OnPreStepX, gp:GridPosition, layer:CollisionLayer_Wall){
        // Right collision
		if( gp.xr>0.6 && level.hasCollision(gp.cx+1,gp.cy) )
			gp.xr = 0.6;
		
		// Left collision
		if( gp.xr<0.3 && level.hasCollision(gp.cx-1,gp.cy) )
			gp.xr = 0.3;
    }

    @a function floorCollisionOnPreStepY(en:echoes.Entity, add:OnPreStepY, gp:GridPosition, vc:VelocityComponent,cl:CollisionSensor, layer:CollisionLayer_Wall){
       		// Land on ground
		if( gp.yr>1 && level.hasCollision(gp.cx,gp.cy+1) ) {
			vc.dy  = 0;
			vc.bdy = 0;
			gp.yr = 1;
			cl.cd.setS("landing",0.005);
		}

		// Ceiling collision
		if( gp.yr<=0.5 && level.hasCollision(gp.cx,gp.cy-1) )
			gp.yr = 0.5;
    }
}