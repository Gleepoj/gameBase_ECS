package aleiiioa.systems.solver;


import dn.Bresenham;
import echoes.System;

import aleiiioa.builders.Builders;

import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.solver.SolverUVComponent;
import aleiiioa.components.solver.CellComponent;
import aleiiioa.components.solver.ModifierComponent;



class SolverSystem extends echoes.System {
    // move all maximum to const // 
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
    @a function onModifierAdded(mod:ModifierComponent,gp:GridPosition) {
        reinitModifiedCellsList(mod,gp);
    }

    @u function cellUpdate(cc:CellComponent){
        cc.u = solver.getUatIndex(cc.index);
        cc.v = solver.getVatIndex(cc.index);
    } 

    @u function updateSolverUVComponent(suv:SolverUVComponent,gp:GridPosition){
        var index = solver.getIndexForCellPosition(gp.cx,gp.cy);
        if(solver.checkIfIndexIsInArray(index)){
            suv.uv = solver.getUVVectorForIndexPosition(index);
        }
    }

    @u function pullModifierInput(mod:ModifierComponent,gp:GridPosition){
        if(mod.isBlowing){
            for( c in mod.informedCells){
               setUVatIndex(c.u,c.v,c.index);
            }
        }
        if(gp.isMoving)
            reinitModifiedCellsList(mod,gp);

       
    }

    @u function globalSolverUpdate(){
        solver.update();
        //addForce(10,10,0,30);
    }

    private function reinitModifiedCellsList(mod:ModifierComponent,gp:GridPosition) {
        
        var list = Bresenham.getDisc(gp.cx,gp.cy, mod.areaRadius);
    	mod.informedCells = [];
		for(c in list){
			if(solver.checkIfCellIsInGrid(c.x,c.y)){
				var i = solver.getIndexForCellPosition(c.x,c.y);
				mod.informedCells.push({index: i,x:c.x,y:c.y,abx: 0,aby: 0,u: 0,v: 0,dist:0});
			}
		}
    }
    

    private function createCellsComponents() {
        for(j in 0...solver.height) {
			for(i in 0...solver.width) {
                var index = solver.getIndexForCellPosition(i,j);
                Builders.solverCell(i,j,index);
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

    private function setUVatIndex(u:Float,v:Float,index:Int){
        solver.u[index] = u;
        solver.v[index] = v;
        solver.uOld[index] = u;
        solver.vOld[index] = v;
    }

}