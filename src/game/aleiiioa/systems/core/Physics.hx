package aleiiioa.systems.core;

import aleiiioa.components.solver.ModifierComponent;
import aleiiioa.components.core.*;
import aleiiioa.components.vehicule.SteeringWheel;
//import aleiiioa.components.VelocityComponent;


class Physics extends echoes.System {
	

	public function new() {
	
	}

/* 	@u inline function updatePosition(gp:GridPosition,vc:VelocityComponent) {
		vc.dx += 0.05;
		vc.dy += 0.05;
		fixedUpdate(gp,vc);
	} */
	@u function updateBoids(gp:GridPosition,sw:SteeringWheel,vc:VelocityComponent,bb:BoundingBox) {
		vc.dx = sw.eulerSteering.x * 2;
		vc.dy = sw.eulerSteering.y * 2;
		fixedUpdate(gp,vc);
	} 
/* 
	@u function updateModifier(gp:GridPosition,vc:VelocityComponent,mod:ModifierComponent) {
		//vc.dx = 0.5;
		//vc.dy = 0.5;
		fixedUpdate(gp,vc);
	} */

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

	/** Called at the beginning of each X movement step **/
	function onPreStepX() {}

	/** Called at the beginning of each Y movement step **/
	function onPreStepY() {}

	function fixedUpdate(gp:GridPosition, vc:VelocityComponent) {

		var steps = M.ceil((M.fabs(vc.dxTotal) + M.fabs(vc.dyTotal)) / 0.33);
		if (steps > 0) {
			var n = 0;
			while (n < steps) {
				// X movement
				gp.xr += vc.dxTotal / steps;

				if (vc.dxTotal != 0)
					onPreStepX(); // <---- Add X collisions checks and physics in here

				while (gp.xr > 1) {
					gp.xr--;
					gp.cx++;
				}
				while (gp.xr < 0) {
					gp.xr++;
					gp.cx--;
				}

				// Y movement
				gp.yr += vc.dyTotal / steps;

				if (vc.dyTotal != 0)
					onPreStepY(); // <---- Add Y collisions checks and physics in here

				while (gp.yr > 1) {
					gp.yr--;
					gp.cy++;
				}
				while (gp.yr < 0) {
					gp.yr++;
					gp.cy--;
				}

				n++;
			}
		}
		applyFriction(vc);
	}

	function applyFriction(vc:VelocityComponent) {
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
