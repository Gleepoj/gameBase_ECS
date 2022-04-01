package aleiiioa.components.solver;

import aleiiioa.systems.modifier.ModifierCommand;
import aleiiioa.systems.modifier.Equation;


typedef CellStruct = {index:Int,x:Int,y:Int,abx:Int,aby:Int,u:Float,v:Float,dist:Int}

class ModifierComponent {
	
    public var areaEquation:AreaEquation = EqDiverge;
	public var areaRadius:Int = 7;
	public var power:Float = 0.03; //between 0.05(max) and 0.1(min)

    var blowingIsActive:Bool = false;
	public var isBlowing(get,never):Bool;inline function get_isBlowing()return blowingIsActive;
	
	
	public var informedCells:Array<CellStruct> = [];
    public var equation:Equation;

	public var prevState:Bool;
	public var activeColor:UInt = 0xff0000;
	public var idleColor:UInt = 0x00eeff;

	public var prevOrder:ModifierCommand;
	public var currentOrder:ModifierCommand;

	public var onChangeOrder(get,never):Bool;inline function get_onChangeOrder() return prevOrder != currentOrder;
	
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