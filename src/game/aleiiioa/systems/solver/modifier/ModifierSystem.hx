package aleiiioa.systems.solver.modifier;

import aleiiioa.systems.solver.modifier.ModifierCommand.InstancedCommands;
import h3d.Vector;
import dn.Bresenham;
import aleiiioa.components.core.GridPosition;
import aleiiioa.components.solver.ModifierComponent;

class ModifierSystem extends echoes.System {
    // Solver is here only to provide check and grid conversion Not to produce side effects on it !!!// 
	var solver:FluidSolver;
	var t:Float;
	var t_Max:Float = 50;
	var command:InstancedCommands;

    public function new(_solver:FluidSolver) {
        solver = _solver;
		t = 0;
		command = new InstancedCommands();
    }

    @a function onModifierAdded(mod:ModifierComponent,gp:GridPosition) {
	    mod.equation = new Equation(mod.areaEquation);
		modifierStoreCells(mod,gp);
		computeCellDistanceToModifierPosition(mod,gp);
		computeLocalUVFields(mod);
 
    }
	
	@u function modifiersUpdate(dt:Float,mod:ModifierComponent,gp:GridPosition) {
		modifierStoreCells(mod,gp);
		computeCellDistanceToModifierPosition(mod,gp);
		computeLocalUVFields(mod);

		t += dt;
		if (t > t_Max){
			t = 0 ;
			order(mod,command.curl);
		}
	}

	public function order(mod:ModifierComponent,com:ModifierCommand) {
        com.execute(mod);
    }

	private function modifierStoreCells(mod:ModifierComponent,gp:GridPosition) {
        var list = Bresenham.getDisc(gp.cx,gp.cy, mod.areaRadius);
    	mod.informedCells = [];
		for(c in list){
			if(solver.checkIfCellIsInGrid(c.x,c.y)){
				var i = solver.getIndexForCellPosition(c.x,c.y);
				mod.informedCells.push({index: i,x:c.x,y:c.y,abx: 0,aby: 0,u: 0,v: 0});
			}
		}
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
