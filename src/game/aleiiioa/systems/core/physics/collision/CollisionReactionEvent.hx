package aleiiioa.systems.core.physics.collision;


import aleiiioa.components.core.physics.collision.BoundingBox;
import aleiiioa.components.core.level.ChunkCollisionLayer;
import aleiiioa.components.core.physics.collision.OnPreStepX;
import aleiiioa.components.core.physics.collision.OnPreStepY;
import aleiiioa.components.core.physics.collision.CollisionSensor;
import aleiiioa.components.core.physics.collision.affects.CollisionLayer_Wall;

import aleiiioa.components.core.physics.velocity.VelocityComponent;
import aleiiioa.components.core.physics.position.GridPosition;


class CollisionReactionEvent extends echoes.System {
    public function new (){

    }

	@a function wallCollisionOnPreStepX(en:echoes.Entity, add:OnPreStepX, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){

		if( level.hasCollision(gp.lcx+1,gp.lcy) && gp.xr>0.5 ) {
			gp.xr = 0.5;
			vc.dx = 0;
			vc.bdx = 0;
		}

		if( level.hasCollision(gp.lcx-1,gp.lcy) && gp.xr<0.5 ) {
			gp.xr = 0.5;
			vc.dx = 0;
			vc.bdx = 0;
		}

	}
	
	@a function floorCollisionOnPreStepY(en:echoes.Entity, add:OnPreStepY, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){
		//ceil Collision

		if( level.hasCollision(gp.lcx,gp.lcy-1) && gp.yr<=0.5) {
			gp.yr = 0.5;
			vc.dy = 0;
			vc.bdy = 0;
		}
		//ground
		if( level.hasCollision(gp.lcx,gp.lcy+1) && gp.yr>=0.5) {
			gp.yr = 0.5;
			vc.dy = 0;
			vc.bdy = 0;
		} 
	}

}


/* 
@a function floorCollisionOnPreStepY(en:echoes.Entity, add:OnPreStepY, gp:GridPosition, vc:VelocityComponent,cl:CollisionSensor, layer:CollisionLayer_Wall,level:ChunkCollisionLayer){
		   // Land on ground
	if( gp.yr>1 && level.hasCollision(gp.lcx,gp.lcy+1) ) {
		vc.dy  = 0;
		vc.bdy = 0;
		gp.yr = 1;
		//cl.cd.setS("landing",0.005);
	}

	// Ceiling collision
	if( gp.yr<=0.5 && level.hasCollision(gp.lcx,gp.lcy-1) )
		gp.yr = 0.5;
} */ 