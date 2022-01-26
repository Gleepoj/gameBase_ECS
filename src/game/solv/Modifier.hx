package solv;

import aleiiioa.ICommand;
import h3d.Vector;
import dn.Bresenham;

typedef CellStruct = {index:Int,x:Int,y:Int,abx:Int,aby:Int,u:Float,v:Float}

class Modifier extends Entity {
	public static var ALL:Array<Modifier> = [];

	var solver(get, never):Solver;inline function get_solver()return Game.ME.solver;

	var areaInfluence:AreaInfluence = AiSmall;
	var areaEquation:AreaEquation = EqCurl;

	var areaRadius:Int = 5;

	public var isBlowing(get,never):Bool;inline function get_isBlowing()return blowingIsActive;
	
	var equation:Equation;

	var blowingIsActive:Bool;
	var parentEntity:Entity;
	var angle:Float = 0;

	var color:UInt = 0xff00af;

	var informedCells:Array<CellStruct> = [];

	public var curl:Curl;
    public var diverge:Diverge;
    public var converge:Converge;
	public var turnOff:TurnOff;

	public function new(x:Int, y:Int, ?entity:Entity) {
		super(x, y);
		ALL.push(this);

		curl     = new Curl();
        diverge  = new Diverge();
        converge = new Converge();
		turnOff  = new TurnOff();

		equation = new Equation(areaEquation);

		actualizeAndStoreAreaCells();
		computeCaseDistanceToCenterAreaCase();
        informCellUVFields();
        

		if(entity != null){
			parentEntity = entity;
			setPosCase(parentEntity.cx,parentEntity.cy);
		}

        spr.set(D.tiles.fxCircle15);
        spr.colorize(color);
	}
	
	override function update() {
		angle += 0.1;
        
		stickToParentEntity();
		refresh();

	}
	override function postUpdate() {
		super.postUpdate();
		spr.colorize(color);
	}
	
	override function dispose() {
		super.dispose();
		ALL.remove(this);
	}
	//API//

	public function getInformedCellsIndex() {
		var list:Array<Int> = [];
			for(cell in informedCells){
				list.push(cell.index);
			}
		return list;
	}

	public function getInformedCells(){
		return informedCells;
	}

	public function activateModifier(){
		if (blowingIsActive == false)
			blowingIsActive = true;
			color = 0xff0000;
	}

	public function deactivateModifier(){
		if (blowingIsActive == true)
			blowingIsActive = false;
		    color = 0xff00af;
	}
	public function changeEquationType(eqType:AreaEquation) {
		equation = new Equation(eqType);
		refresh();
	}
	//Private functions//
	public function order(com:ICommand) {
        com.execute(this);
    }

	private function stickToParentEntity(){
		if(parentEntity != null){
			setPosPixel(parentEntity.attachX,parentEntity.attachY);
		}
	}

	private function refresh(){
		actualizeAndStoreAreaCells();
		computeCaseDistanceToCenterAreaCase();
		informCellUVFields();
	}

	private function actualizeAndStoreAreaCells(){
		var list = Bresenham.getDisc(cx,cy, areaRadius);
		informedCells = [];
		pushAreaCells_toInformedCells(list);
	}

	private function pushAreaCells_toInformedCells(list:Array<{x:Int,y:Int}>) {
		for (l in list) {
            var ind = solver.computeSolverIndexFromCxCy(l.x,l.y);
			if (solver.testIfIndexIsInArray(ind)) {
				informedCells.push({index: ind,x:l.x,y:l.y,abx: 0,aby: 0,u: 0,v: 0});
			}
		}
	}

    private function informCellUVFields() {
		if (isBlowing){
			for (cell in informedCells){
				var eqVector = equation.compute(new Vector(cell.abx,cell.aby));
				cell.u = eqVector.x;
				cell.v = eqVector.y;
			}
		}
    }

    private function computeCaseDistanceToCenterAreaCase() {
        for (cell in informedCells) {
		    cell.abx = cell.x - cx;
			cell.aby = cell.y - cy;
        }
    }
	

}
