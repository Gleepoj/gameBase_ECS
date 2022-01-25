package solv;

import dn.Bresenham;

typedef CellStruct = {index:Int,x:Int,y:Int,abx:Int,aby:Int,u:Float,v:Float}

class SolverModifier extends Entity {
	public static var ALL:Array<SolverModifier> = [];

	var solver(get, never):Solver;inline function get_solver()return Game.ME.solver;

	var areaInfluence:AreaInfluence = AiSmall;
	var areaEquation:AreaEquation = EqCurl;

	var areaRadius:Int = 3;

	public var isBlowing(get,never):Bool;inline function get_isBlowing()return blowingIsActive;
	

	var blowingIsActive:Bool;
	var parentEntity:Entity;
	var angle:Float = 0;

	var informedCells:Array<CellStruct> = [];

	public function new(x:Int, y:Int, ?entity:Entity) {
		super(x, y);
		ALL.push(this);
		actualizeAndStoreAreaCells();
		computeCaseDistanceToCenterAreaCase();
        informCellUVFields();
        //printEquation();

		if(entity != null){
			parentEntity = entity;
			setPosCase(parentEntity.cx,parentEntity.cy);
		}

        spr.set(D.tiles.fxCircle15);
        spr.colorize(0xff00af);
	}
	
	override function update() {
		angle += 0.1;
        
		stickToParentEntity();
		actualizeAndStoreAreaCells();
		computeCaseDistanceToCenterAreaCase();
		informCellUVFields();

	}
	
	//API//

	public function getInformedCellsIndex() {
		var list:Array<Int> = [];
			for(iCell in informedCells){
				list.push(iCell.index);
			}
		return list;
	}

	public function getInformedCells(){
		return informedCells;
	}

	public function activateFan(){
		if (blowingIsActive == false)
			blowingIsActive = true;
			spr.colorize(0xff0000);
	}

	public function deactivateFan(){
		if (blowingIsActive == true)
			blowingIsActive = false;
		    spr.colorize(0xff00af);
	}
	
	//Private functions//
	private function printEquation() {
		for(c in informedCells){
			trace(Equation.curl(c.abx,c.aby));
		}
	}

	private function stickToParentEntity(){
		if(parentEntity != null){
			setPosPixel(parentEntity.attachX,parentEntity.attachY);
		}
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
				var equation = Equation.curl(cell.abx,cell.aby);
				cell.u = equation.x;
				cell.v = equation.y;
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
