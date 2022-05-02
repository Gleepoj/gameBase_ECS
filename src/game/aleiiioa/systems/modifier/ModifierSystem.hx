package aleiiioa.systems.modifier;

import aleiiioa.components.core.position.FluidPosition;
import h3d.Vector;
import dn.M;
import hxd.Math;

import aleiiioa.components.core.rendering.SpriteComponent;
import aleiiioa.systems.modifier.ModifierCommand.InstancedCommands;

import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.tool.PerlinNoiseComponent;
import aleiiioa.components.solver.ModifierComponent;

class ModifierSystem extends echoes.System {
	
	var command:InstancedCommands;

    public function new() {
		command = new InstancedCommands();
    }

    @a function onModifierAdded(mod:ModifierComponent,fpos:FluidPosition) {
	    mod.equation = new Equation(mod.areaEquation);
		mod.currentOrder = command.turnOn;
		order(mod);

		computeCellDistanceToModifierPosition(mod,fpos);
		computeLocalUVFields(mod);	
		
    }
	@a function onPerlinComponentAdded(mod:ModifierComponent,pnc:PerlinNoiseComponent) {
		pnc.px = pnc.initX;
		pnc.py = pnc.initY;
	}
	
	@u function modifiersUpdate(dt:Float,mod:ModifierComponent,fpos:FluidPosition,spr:SpriteComponent) {
		
		computeCellDistanceToModifierPosition(mod,fpos);
		computeLocalUVFields(mod);
		
		if(mod.onChangeOrder)
			order(mod);
	}

	@u function perlinModifierUpdate(pnc:PerlinNoiseComponent, mod:ModifierComponent) {
		pnc.px += pnc.incX;
		
		var p = pnc.perlin.perlin(pnc.seed,pnc.px,pnc.py,pnc.octaves);

		mod.power = M.fwrap(p,0.05,0.03);
	}

	public function order(mod:ModifierComponent) {
		if(mod.currentOrder != null){
        	mod.currentOrder.execute(mod);
			mod.prevOrder = mod.currentOrder;
		}
    }

	private function computeCellDistanceToModifierPosition(mod:ModifierComponent,fpos:FluidPosition) {	
		for (cell in mod.informedCells) {
		    cell.abx = cell.x - fpos.cx;
			cell.aby = cell.y - fpos.cy;
			cell.dist = M.floor(M.dist(fpos.cx,fpos.cy,cell.abx,cell.aby));
        }
    }

	private function computeLocalUVFields(mod:ModifierComponent) {
		if (mod.isBlowing){
			for (cell in mod.informedCells){
				var pow = cell.dist*mod.power;
				var eqVector = mod.equation.compute(new Vector(cell.abx,cell.aby,pow));
				cell.u = eqVector.x;
				cell.v = eqVector.y;
			}
		}
	}
}
	
	/* private function _test_ifContiguous(circle:Array<CellStruct>) {
		var prev_y = 0 ;
		var y_contiguous = "y not contiguous" ;
		
		for(c in circle){
			if(c.y-prev_y < -1)
				throw y_contiguous;
			prev_y = c.y;
		}
	}
 */
