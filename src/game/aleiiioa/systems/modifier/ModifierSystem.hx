package aleiiioa.systems.modifier;

import h3d.Vector;

import aleiiioa.components.core.rendering.SpriteComponent;
import aleiiioa.systems.modifier.ModifierCommand.InstancedCommands;

import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.solver.ModifierComponent;

class ModifierSystem extends echoes.System {
    // Solver is here only to provide check and grid conversion Not to produce side effects on it !!!// 
	
	var command:InstancedCommands;

    public function new() {
		command = new InstancedCommands();
    }

    @a function onModifierAdded(mod:ModifierComponent,gp:GridPosition) {
	    mod.equation = new Equation(mod.areaEquation);
		mod.currentOrder = command.turnOn;

		computeCellDistanceToModifierPosition(mod,gp);
		computeLocalUVFields(mod);	
		
    }
	
	@u function modifiersUpdate(dt:Float,mod:ModifierComponent,gp:GridPosition,spr:SpriteComponent) {
		
		computeCellDistanceToModifierPosition(mod,gp);
		computeLocalUVFields(mod);
		
		order(mod);
	}

	public function order(mod:ModifierComponent) {
		if(mod.currentOrder != null)
        	mod.currentOrder.execute(mod);
    }

	private function computeCellDistanceToModifierPosition(mod:ModifierComponent,gp:GridPosition) {
        
		for (cell in mod.informedCells) {
		    cell.abx = cell.x - gp.cx;
			cell.aby = cell.y - gp.cy;
        }
    }

	private function computeLocalUVFields(mod:ModifierComponent) {
		if (mod.isBlowing){
			for (cell in mod.informedCells){
				var eqVector = mod.equation.compute(new Vector(cell.abx,cell.aby));
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
