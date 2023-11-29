package aleiiioa.systems.core.physics;

import aleiiioa.components.core.physics.flags.affects.*;
import aleiiioa.components.core.physics.flags.body.ParticuleBodyFlag;
import aleiiioa.components.core.physics.flags.affects.GravitySensitiveAffects;
import aleiiioa.components.core.physics.flags.body.KinematicBodyFlag;
import echoes.Entity;
import aleiiioa.components.core.collision.CollisionsListener;
import aleiiioa.components.core.physics.*;
import aleiiioa.components.core.position.GridPosition;

class VelocitySystem extends echoes.System {
	public function new() {}
	public var level(get,never) : Level; inline function get_level() return Game.ME.level;
	
	@u function undefinedInputAffects(vas:VelocityAnalogSpeed,vc:VelocityComponent,part:ParticuleBodyFlag) {
		
		vc.dx = vas.xSpeed;
		vc.dy = vas.ySpeed;
	}

	@u function kinematicInputAffects(vas:VelocityAnalogSpeed,vc:VelocityComponent,kin:KinematicBodyFlag) {
		if (vas.xSpeed != 0) {
			var speed = 0.3;
				vc.dx += vas.xSpeed * speed;
		}
		if (vas.ySpeed != 0) {
			vc.dy += vas.ySpeed;
		}

		vas.xSpeed = 0;
		vas.ySpeed = 0;
	}

	@u function kinematicGravityAffects(cl:CollisionsListener,vc:VelocityComponent,kin:KinematicBodyFlag,gr:GravitySensitiveAffects){
		
		if(cl.onGround)
			cl.cd.setS("recentlyOnGround",0.01);

		if(!cl.onGround){
			vc.dy += 0.1;
		}
	}

	@u function agnosticFrictionAffects(vc:VelocityComponent,fr:FrictionSensitiveAffects) {
		// X frictions
		vc.dx *= vc.frictX;
		vc.bdx *= vc.bumpFrictX;
		if (M.fabs(vc.dx) <= 0.0005)
			vc.dx = 0;
		if (M.fabs(vc.bdx) <= 0.0005)
			vc.bdx = 0;

		// Y frictions
		vc.dy *= vc.frictY;
		vc.bdy *= vc.bumpFrictY;
		if (M.fabs(vc.dy) <= 0.0005)
			vc.dy = 0;
		if (M.fabs(vc.bdy) <= 0.0005)
			vc.bdy = 0;
	
	}

	@u function steppedPositionUpdateAndCallCollisions(en:echoes.Entity,gp:GridPosition, vc:VelocityComponent, cl:CollisionsListener) {
		// step is the max lenght of a implemented movement (in grid ratio) in one frame (0.33 is the max speed) precision could be improved by using a smaller step 0.2
		var steps = M.ceil((M.fabs(vc.dxTotal) + M.fabs(vc.dyTotal)) / 0.33);
		if (steps > 0) {
			var n = 0;
			while (n < steps) {
				// X movement
				gp.xr += vc.dxTotal / steps;

				if (vc.dxTotal != 0){
					if(vc.physicBody)
						en.add(new OnPreStepX());//<---- Add X collisions checks and physics in here
				
				}

				while (gp.xr > 1) {
					gp.xr--;
					gp.cx++;
				}
				while (gp.xr < 0) {
					gp.xr++;
					gp.cx--;
				}
				en.remove(OnPreStepX);
				// Y movement
				gp.yr += vc.dyTotal / steps;

				if (vc.dyTotal != 0){
					if(vc.physicBody)
						en.add(new OnPreStepY());// <---- Add Y collisions checks and physics in here
				}

				while (gp.yr > 1) {
					gp.yr--;
					gp.cy++;
				}
				while (gp.yr < 0) {
					gp.yr++;
					gp.cy--;
				}
				en.remove(OnPreStepY);
				n++;
			}
		}
	}



	/** Apply a bump/kick force to entity **/
	public function bump(x:Float, y:Float, vc:VelocityComponent) {
		vc.bdx += x;
		vc.bdy += y;
	}

	/** Reset velocities to zero **/
	public function cancelVelocities(vc:VelocityComponent) {
		vc.dx = vc.bdx = 0;
		vc.dy = vc.bdy = 0;
	}

}
