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

     function oldwallCollisionOnPreStepX(en:echoes.Entity, add:OnPreStepX, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){
        // Right collision
		// Add recursive check if bb.cr is more than one case wide
/* 		if( gp.xr>0.5 && level.hasCollision(gp.lcx+bb.cr,gp.lcy)){
			gp.xr =0.5;
			vc.dx  = 0;
			vc.bdx = 0; 
			//vc.cancelVelocities();
		}
		
		// Left collision
		if( gp.xr<0.5 && level.hasCollision(gp.lcx+bb.cl,gp.lcy)){
			gp.xr=0.5;
			vc.dx  = 0;
			vc.bdx = 0; 
			//vc.cancelVelocities();
		} */
		    // Calculate top and bottom of the bounding box in grid units
			var top = Math.floor(gp.lcy + bb.ct);
			var bottom = Math.ceil(gp.lcy + bb.cb);
		
			// Right collision
			var y = top;
			while (y <= bottom) {
				if( gp.xr>0.5 && level.hasCollision(gp.lcx+bb.cr, y)){
					gp.xr =0.5;
					vc.dx  = 0;
					vc.bdx = 0; 
					break;
				}
				y++;
			}
			
			// Left collision
			y = top;
			while (y <= bottom) {
				if( gp.xr<0.5 && level.hasCollision(gp.lcx+bb.cl, y)){
					gp.xr=0.5;
					vc.dx  = 0;
					vc.bdx = 0; 
					break;
				}
				y++;
			}
    }

/* 	function checkCollisionLine(start:Int, end:Int, check:Int->Bool):Bool {
		for (i in start...end) {
			if (check(i)) return true;
		}
		return false;
	} */
	function checkCollisionLine(start:Int, end:Int, check:Int->Bool):Bool {
		var i = start;
		while (i < end) {
			if (check(i)) return true;
			i++;
		}
		return false; 
	}

	/* function checkCollisionLine(start:Int, end:Int, check:Int->Bool):Bool {
	/* 	var i = start;
		while (i < end) {
			if (check(i)) return true;
			i++;
		}
		return false; 

		if (start <= end) {
			var i = start;
			while (i <= end) {
				if (check(i)) return true;
				i++;
			}
		} else {
			var i = start;
			while (i >= end) {
				if (check(i)) return true;
				i--;
			}
		}
		return false;
	} */

/* 	function checkCollisionLine(start:Int, end:Int, check:Int->Bool):Bool {
		var step = start <= end ? 1 : -1;
		var i = start;
		while ((step > 0 && i <= end) || (step < 0 && i >= end)) {
			if (check(i)) return true;
			i += step;
		}
		return false;
	} */
	@a function wallCollisionOnPreStepX(en:echoes.Entity, add:OnPreStepX, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){
		// Calculate top and bottom of the bounding box in grid units
		var top = Math.floor(gp.lcy + bb.ct);
		var bottom = Math.ceil(gp.lcy + bb.cb);
	
		// Right collision
		if (gp.xr>0.5 && checkCollisionLine(top, bottom, function(y) return level.hasCollision(Math.ceil(gp.lcx+bb.cr), y))) {
			gp.xr =0.5;
			vc.dx  = 0;
			vc.bdx = 0; 
			//trace("stop r ");
		}
	
		// Left collision
		if (gp.xr<0.5 && checkCollisionLine(top, bottom, function(y) return level.hasCollision(Math.floor(gp.lcx+bb.cl) - 1, y))) {
			gp.xr=0.5;
			vc.dx  = 0;
			vc.bdx = 0; 
			//trace("stop l ");
		}
	}
	
	@a function floorCollisionOnPreStepY(en:echoes.Entity, add:OnPreStepY, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){
		// Calculate left and right of the bounding box in grid units
		var left = Math.floor(gp.lcx + bb.cl);
		var right = Math.ceil(gp.lcx + bb.cr);
	
		// Top collision
		if (gp.yr<0.5 && checkCollisionLine(left, right, function(x) return level.hasCollision(x, Math.ceil(gp.lcy+bb.ct) - 1))) {
			gp.yr=0.5;
			vc.dy  = 0;
			vc.bdy = 0; 
		}
	
		// Bottom collision
		if (gp.yr>0.5 && checkCollisionLine(left, right, function(x) return level.hasCollision(x, Math.ceil(gp.lcy+bb.cb)))) {
			gp.yr=0.5;
			vc.dy  = 0;
			vc.bdy = 0; 
		}
	}
	function oowallCollisionOnPreStepX(en:echoes.Entity, add:OnPreStepX, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){
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
	}

	function oofloorCollisionOnPreStepY(en:echoes.Entity, add:OnPreStepY, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){
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
	}

    function oldfloorCollisionOnPreStepY(en:echoes.Entity, add:OnPreStepY, gp:GridPosition,vc:VelocityComponent,layer:CollisionLayer_Wall,level:ChunkCollisionLayer,bb:BoundingBox){
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
		   var left = Math.floor(gp.lcx + bb.cl);
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
	}
}

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