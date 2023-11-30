package aleiiioa.systems.core.physics.velocity;

import aleiiioa.components.core.physics.collision.affects.*;
import aleiiioa.components.core.physics.velocity.body.ParticuleBodyFlag;
import aleiiioa.components.core.physics.collision.affects.GravitySensitiveAffects;
import aleiiioa.components.core.physics.velocity.body.KinematicBodyFlag;
import echoes.Entity;
import aleiiioa.components.core.physics.collision.CollisionSensor;
import aleiiioa.components.core.physics.velocity.*;


class VelocitySystem extends echoes.System {
	public function new() {}
	
	@u function undefinedInputAffects(vas:AnalogSpeedComponent,vc:VelocityComponent,part:ParticuleBodyFlag) {
		
		vc.dx = vas.xSpeed;
		vc.dy = vas.ySpeed;
	}

	@u function kinematicInputAffects(vas:AnalogSpeedComponent,vc:VelocityComponent,kin:KinematicBodyFlag) {
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

	@u function kinematicGravityAffects(cl:CollisionSensor,vc:VelocityComponent,kin:KinematicBodyFlag,gr:GravitySensitiveAffects){
		
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
