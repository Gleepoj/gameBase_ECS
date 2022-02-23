package aleiiioa.components.solver;

import aleiiioa.systems.solver.modifier.ModifierCommand;
import aleiiioa.systems.solver.modifier.Equation;


typedef CellStruct = {index:Int,x:Int,y:Int,abx:Int,aby:Int,u:Float,v:Float}

class ModifierComponent {
	
    public var areaEquation:AreaEquation = EqDiverge;
	public var areaRadius:Int = 50;

    var blowingIsActive:Bool = false;
	public var isBlowing(get,never):Bool;inline function get_isBlowing()return blowingIsActive;
	
	
	public var informedCells:Array<CellStruct> = [];
    public var equation:Equation;

	public var prevState:Bool;
	public var activeColor:UInt = 0xffff00;
	public var idleColor:UInt = 0x00eeff;

	public var currentOrder:ModifierCommand ;
	
    public function new() {
        
    }

    
	public function activateModifier(){
		if (blowingIsActive == false)
			blowingIsActive = true;
	}

    public function deactivateModifier(){
		if (blowingIsActive == true)
			blowingIsActive = false;
	}

    public function changeEquationType(eqType:AreaEquation) {
		equation = new Equation(eqType);
	}


}