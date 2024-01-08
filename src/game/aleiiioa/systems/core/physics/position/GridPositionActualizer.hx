package aleiiioa.systems.core.physics.position;


import aleiiioa.components.core.rendering.SpriteExtension;
import aleiiioa.components.core.rendering.SpriteComponent;
import aleiiioa.components.core.physics.collision.BoundingBox;
import aleiiioa.components.core.physics.position.flags.*;
import aleiiioa.components.core.physics.position.*;

import aleiiioa.components.core.physics.velocity.VelocityComponent;
import aleiiioa.components.core.physics.collision.OnPreStepX;
import aleiiioa.components.core.physics.collision.OnPreStepY;



class GridPositionActualizer extends echoes.System {
    
    public function new() {
        
    }

    @a function onGridPositionAdded(gp:GridPosition) {
	   gp.onPosManuallyChanged();
    }

	@a function onEntityAdded(spr:SpriteComponent,se:SpriteExtension) {
		Game.ME.origin.addChild(spr);
		var ratio = (spr.frameData.hei * se.sprScaleY)/(Const.GRID/2);
		var cr = M.pretty(1-(1/ratio),1);
		spr.setCenterRatio(0.5,cr);
		spr.alpha = 1;
	}
	
	@u function updateDebugBounds(bb:BoundingBox,gp:GridPosition) {
        bb.attachX = gp.attachX;
        bb.attachY = gp.attachY;
	}
	
	@u function steppedPositionUpdateAndCollisionCall(en:echoes.Entity,gp:GridPosition,vc:VelocityComponent) {
		// step is the max lenght of a implemented movement (in grid ratio) in one frame (0.33 is the max speed) precision could be improved by using a smaller step 0.2
		// allowing continuous collision detection 
		var steps = M.ceil((M.fabs(vc.dxTotal) + M.fabs(vc.dyTotal)) / 0.33);
		
		if (steps > 0) {
			var n = 0;
			while (n < steps) {
				// X movement
				gp.xr += vc.dxTotal / steps;
				if (vc.dxTotal != 0 || vc.dyTotal != 0)
			    	en.add(new OnPreStepX());//<---- Add X collisions checks and physics in CollisionReactionSystem
				
				en.remove(OnPreStepX);
		
				while (gp.xr > 1) {
					gp.xr--;
					gp.cx++;
				}
				while (gp.xr < 0) {
					gp.xr++;
					gp.cx--;
				}
		        
				//Y movement
				gp.yr += vc.dyTotal / steps;
				
				if (vc.dyTotal != 0  || vc.dxTotal != 0)
					en.add(new OnPreStepY());
			
				en.remove(OnPreStepY);
		
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

    @u function ActualizeGridComponent(gp:GridPosition){
		gp.onPosManuallyChanged();
    }

}