package aleiiioa.components.solver;

import aleiiioa.systems.solver.modifier.Equation;


typedef CellStruct = {index:Int,x:Int,y:Int,abx:Int,aby:Int,u:Float,v:Float}

class ModifierComponent {
	
    var areaEquation:AreaEquation = EqCurl;
	public var areaRadius:Int = 50;

    var blowingIsActive:Bool = true;
	public var isBlowing(get,never):Bool;inline function get_isBlowing()return blowingIsActive;
	
	
	public var informedCells:Array<CellStruct> = [];
	
    //public var commands:InstancedCommands;
    public var equation:Equation;


    public function new() {
        
    }
}