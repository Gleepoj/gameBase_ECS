package aleiiioa.systems.core.physics;

import aleiiioa.components.core.physics.flags.affects.*;
import aleiiioa.components.core.physics.flags.body.ParticuleBodyFlag;
import aleiiioa.components.core.physics.flags.affects.GravitySensitiveAffects;
import aleiiioa.components.core.physics.flags.body.KinematicBodyFlag;
import echoes.Entity;
import aleiiioa.components.core.collision.CollisionsListener;
import aleiiioa.components.core.physics.*;


class VelocitySystem extends echoes.System {
	public function new() {}
	
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

}
