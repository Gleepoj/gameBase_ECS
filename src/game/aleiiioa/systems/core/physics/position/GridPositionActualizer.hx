package aleiiioa.systems.core.physics.position;


import aleiiioa.components.core.physics.position.flags.*;
import aleiiioa.components.core.physics.position.*;

import aleiiioa.components.core.physics.velocity.VelocityComponent;
import aleiiioa.components.core.physics.collision.OnPreStepX;
import aleiiioa.components.core.physics.collision.OnPreStepY;



class GridPositionActualizer extends echoes.System {
    
    public function new() {
        
    }

    @a function onGridPositionAdded(gp:GridPosition) {
	   onPosManuallyChanged(gp);
    }

	@u function steppedPositionUpdateAndCollisionCall(en:echoes.Entity,gp:GridPosition,vc:VelocityComponent) {
		// step is the max lenght of a implemented movement (in grid ratio) in one frame (0.33 is the max speed) precision could be improved by using a smaller step 0.2
		
		var steps = M.ceil((M.fabs(vc.dxTotal) + M.fabs(vc.dyTotal)) / 0.33);
		if (steps > 0) {
			var n = 0;
			while (n < steps) {
				// X movement
				gp.xr += vc.dxTotal / steps;

				if (vc.dxTotal != 0)
					en.add(new OnPreStepX());//<---- Add X collisions checks and physics in CollisionReactionSystem
				
				while (gp.xr > 1) {
					gp.xr--;
					gp.cx++;
				}
				while (gp.xr < 0) {
					gp.xr++;
					gp.cx--;
				}
				
				en.remove(OnPreStepX);
				
				
				//Y movement
				gp.yr += vc.dyTotal / steps;
				
				if (vc.dyTotal != 0)
					en.add(new OnPreStepY());

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

	
	@u function updateMasterGridPosition(mgp:MasterGridPosition,gp:GridPosition,mflag:MasterPositionFlag) {
	  	mgp.cx = gp.cx;
		mgp.cy = gp.cy;
		mgp.xr = gp.xr;
		mgp.yr = gp.yr;
	}

	@u function updateChildPos(mgp:MasterGridPosition,gp:GridPosition,gpo:GridPositionOffset,cflag:ChildPositionFlag) {
		gp.cx = mgp.cx + gpo.ocx;
		gp.cy = mgp.cy + gpo.ocy;
		gp.xr = mgp.xr + gpo.oxr;
		gp.yr = mgp.yr + gpo.oyr;

	}

	

    @u inline function ActualizeGridComponent(gp:GridPosition){
		onPosManuallyChanged(gp);
    }


	function setPosCase(gp:GridPosition,_cx:Int,_cy:Int) {
		gp.cx = _cx;
		gp.cy = _cy;
		gp.xr = 0.5;
		gp.yr = 1;
		onPosManuallyChanged(gp);
	}

    function setPosPixel(gp:GridPosition,x:Float, y:Float) {
		gp.cx = Std.int(x/Const.GRID);
		gp.cy = Std.int(y/Const.GRID);
		gp.xr = (x-gp.cx*Const.GRID)/Const.GRID;
		gp.yr = (y-gp.cy*Const.GRID)/Const.GRID;
		onPosManuallyChanged(gp);
	}

	function onPosManuallyChanged(gp:GridPosition) {
		if( M.dist(gp.attachX,gp.attachY,gp.prevFrameattachX,gp.prevFrameattachY) > Const.GRID*2 ) {
			gp.prevFrameattachX = gp.attachX;
			gp.prevFrameattachY = gp.attachY;
		}
		updateLastFixedUpdatePos(gp);
	}

	function finalUpdate(gp:GridPosition) {
		gp.prevFrameattachX = gp.attachX;
		gp.prevFrameattachY = gp.attachY;
	}

    function updateLastFixedUpdatePos(gp:GridPosition) {
		gp.lastFixedUpdateX = gp.attachX;
		gp.lastFixedUpdateY = gp.attachY;
	}

}