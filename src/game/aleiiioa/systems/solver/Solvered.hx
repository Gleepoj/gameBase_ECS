package aleiiioa.systems.solver;

import aleiiioa.components.core.GridPosition;
import aleiiioa.components.solver.CellComponent;
import aleiiioa.components.vehicule.SteeringWheel;
import echoes.System;

class Solvered extends echoes.System {
    
    var game(get,never) : Game; inline function get_game() return Game.ME;
    var level(get,never) : Level; inline function get_level() return Game.ME.level;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);

    var isw(get,never): Float; inline function get_isw() return 1 / width;
    var ish(get,never): Float; inline function get_ish() return 1 / height;

	var aspectRatio(get,never):Float ;inline function get_aspectRatio() return width * ish;
	var aspectRatio2(get,never):Float;inline function get_aspectRatio2() return aspectRatio * aspectRatio;

    var FLUID_WIDTH(get,never) : Int; inline function get_FLUID_WIDTH()  return level.cWid;
    var FLUID_HEIGHT(get,never): Int; inline function get_FLUID_HEIGHT() return Std.int( FLUID_WIDTH * height / width );

    var solver: FluidSolver;

    public function new() {
        solver = new FluidSolver(FLUID_WIDTH,FLUID_HEIGHT);
        createCellsComponents();
        echoes.Workflow.addSystem(new SolverDebugRendering(game.scroller,solver));
    }

    @u function cellUpdate(cc:CellComponent){
        cc.u = solver.getUatIndex(cc.index);
        cc.v = solver.getVatIndex(cc.index);
    } 
    @u function boidsUpdate(sw:SteeringWheel,gp:GridPosition){
        var index = solver.getIndexForCellPosition(gp.cx,gp.cy);
        if(solver.checkIfIndexIsInArray(index)){
            sw.solverUVatCoord = solver.getUVVectorForIndexPosition(index);
        }
    }

    @u function globalSolverUpdate(){
        solver.update();
        addForce(10,10,0,30);
    }

    private function createCellsComponents() {
        for(j in 0...solver.height) {
			for(i in 0...solver.width) {
                var index = solver.getIndexForCellPosition(i,j);
                var cc = new CellComponent(i,j,index);
                new echoes.Entity().add(cc);
            }
        }
    }


    private function addForce(cx:Int, cy:Int, dx:Float, dy:Float):Void {
		var speed:Float = dx * dx  + dy * dy * aspectRatio2;
		if(speed > 0) {
			var velocityMult:Float = 1;
			var index:Int = solver.getIndexForCellPosition(cx,cy);

			solver.uOld[index] += dx * velocityMult;
			solver.vOld[index] += dy * velocityMult;
		}
	}

}