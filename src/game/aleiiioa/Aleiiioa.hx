package aleiiioa;

import aleiiioa.systems.core.*;
import aleiiioa.systems.solver.*;

import aleiiioa.builders.*;
import echoes.Workflow;

class Aleiiioa extends Game {
	var game(get,never) : Game; inline function get_game() return Game.ME;
	//var level(get,never) : Level; inline function get_level() return Game.ME.level;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);
    

    var FLUID_WIDTH(get,never) : Int; inline function get_FLUID_WIDTH() return level.cWid;
    var FLUID_HEIGHT(get,never): Int; inline function get_FLUID_HEIGHT() return Std.int( FLUID_WIDTH * height / width );
    
	var solver:FluidSolver;
	public function new() {
		super();
		solver = new FluidSolver(FLUID_WIDTH,FLUID_HEIGHT);

		Workflow.reset();
		Game.ME.camera.clampToLevelBounds = true;

		Workflow.addSystem(new GridPositionActualizer());
		Workflow.addSystem(new Physics());
		Workflow.addSystem(new SolverDebugRendering(Game.ME.scroller,solver));
		
		
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller,Game.ME));
		Workflow.add60FpsSystem(new BoundingBoxSystem(Game.ME.scroller));

		for (i in 0...20){
			for(j in 0...100){
				Builders.basicObject(i,j);
			}
		}
		trace(Workflow.entities.length);
		
	}

	override function fixedUpdate() {
		super.fixedUpdate();
		Workflow.update(tmod);
	}

	override function postUpdate() {
		super.postUpdate();
		Workflow.postUpdate(tmod);
	}
}
	

