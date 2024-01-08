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
    //public var level(get,never) : Level; inline function get_level() return Game.ME.level;
    public function new (){

    }

	function checkCollisionLine(start:Int, end:Int, check:Int->Bool):Bool {
		var i = start;
		while (i < end) {
			if (check(i)) return true;
			i++;
		}
		return false; 
	}
	function checkReverseCollisionLine(start:Int, end:Int, check:Int->Bool):Bool {
		var i = end;
		while (i > start) {
			if (check(i)) return true;
			i--;
		}
		return false; 
	}

	@a function wallCollisionOnPreStepX(en:echoes.Entity, add:OnPreStepX, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){

		if( level.hasCollision(gp.lcx+1,gp.lcy+bb.cb) && gp.xr>=0.5 ) {
			gp.xr = 0.5;
			vc.dx = 0;
			vc.bdx = 0;
		}

		if( level.hasCollision(gp.lcx-1,gp.lcy+bb.cb) && gp.xr<=0.5 ) {
			gp.xr = 0.5;
			vc.dx = 0;
			vc.bdx = 0;
		}

	}
	
	@a function floorCollisionOnPreStepY(en:echoes.Entity, add:OnPreStepY, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){
		//ceil Collision

		if( level.hasCollision(gp.lcx,gp.lcy+bb.cb-2) && gp.yr<=0.) {
			gp.yr = 0.;
			vc.dy = 0;
			vc.bdy = 0;
		}
		  if( level.hasCollision(gp.lcx,gp.lcy+bb.cb+1) && gp.yr>=1 ) {
			gp.yr = 1;
			vc.dy = 0;
			vc.bdy = 0;
		}
	}

}

/* function oowallCollisionOnPreStepX(en:echoes.Entity, add:OnPreStepX, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){
	// Calculate top and bottom of the bounding box in grid units
	var top = Math.floor(gp.lcy + bb.ct);
	var bottom = Math.ceil(gp.lcy  + bb.cb);

	// Right collision
	if (gp.xr>0.5 && checkCollisionLine(top, bottom, function(y) return level.hasCollision(Math.ceil(gp.lcx+bb.cr), y))) {
		gp.xr = 0.5;
		vc.dx  = 0;
		vc.bdx = 0; 
	}

	// Left collision
	// Left collision
	if (gp.xr<0.5 && checkCollisionLine(top, bottom, function(y) return level.hasCollision(gp.lcx+bb.cl, y))) {
		gp.xr = 0.5;
		vc.dx  = 0;
		vc.bdx = 0; 
	}
} */
/* function oofloorCollisionOnPreStepY(en:echoes.Entity, add:OnPreStepY, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){
	// Calculate left and right of the bounding box in grid units
	var left = Math.floor(gp.lcx + bb.cl);
	var right = Math.ceil(gp.lcx + bb.cr);

	//var left  = gp.lcx + bb.cl;
	//var right = gp.lcx + bb.cr;

	 // Top collision
	 if (gp.yr<0.5 && checkCollisionLine(right, left, function(x) return level.hasCollision(x, Math.ceil(gp.lcy+bb.ct)))) {
		gp.yr = 0.5;
		vc.dy  = 0;
		vc.bdy = 0; 
	}

	// Bottom collision
	if (gp.yr>0.5 && checkCollisionLine(left, right, function(x) return level.hasCollision(x, Math.ceil(gp.lcy+bb.cb)))) {
		gp.yr = 0.5;
		vc.dy  = 0;
		vc.bdy = 0;  
	}
} */

//function oldfloorCollisionOnPreStepY(en:echoes.Entity, add:OnPreStepY, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){
		   // Land on ground
/* 	if( gp.yr>=0.5 && level.hasCollision(gp.lcx,gp.lcy+bb.cb) ) {
		gp.yr =0.5;
		vc.dy  = 0;
		vc.bdy = 0; 
		//vc.cancelVelocities();
		//cl.cd.setS("landing",0.005);
	}

	// Ceiling collision
	if( gp.yr<=0.5 && level.hasCollision(gp.lcx,gp.lcy+bb.ct) ){
		gp.yr =0.5;
		vc.dy  = 0;
		vc.bdy = 0;	 
		//vc.cancelVelocities();
	} */

	   // Calculate left and right of the bounding box in grid units
/* 	   var left = Math.floor(gp.lcx + bb.cl);
	   var right = Math.ceil(gp.lcx + bb.cr);
   
	   // Top collision
	   var x = left;
	   while (x <= right) {
		   if( gp.yr<0.5 && level.hasCollision(x, gp.lcy+bb.ct)){
			   gp.yr=0.5;
			   vc.dy  = 0;
			   vc.bdy = 0; 
			   break;
		   }
		   x++;
	   }
	   
	   // Bottom collision
	   x = left;
	   while (x <= right) {
		   if( gp.yr>0.5 && level.hasCollision(x, gp.lcy+bb.cb)){
			   gp.yr=0.5;
			   vc.dy  = 0;
			   vc.bdy = 0; 
			   break;
		   }
		   x++;
	   }
} */
//plateformer
/* @a function wallCollisionOnPreStepX(en:echoes.Entity, add:OnPreStepX, gp:GridPosition, layer:CollisionLayer_Wall,level:ChunkCollisionLayer){
	// Right collision
	if( gp.xr>0.6 && level.hasCollision(gp.lcx+1,gp.lcy))
		gp.xr = 0.6;
	
	// Left collision
	if( gp.xr<0.3 && level.hasCollision(gp.lcx-1,gp.lcy))
		gp.xr = 0.3;
}

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