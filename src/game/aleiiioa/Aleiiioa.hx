package aleiiioa;

import h3d.Vector;
import h2d.Bitmap;
import h2d.Graphics;
import aleiiioa.systems.core.*;
import aleiiioa.systems.solver.*;

import aleiiioa.builders.*;
import echoes.Workflow;

class Aleiiioa extends Game {
	var game(get,never) : Game; inline function get_game() return Game.ME;
	//var level(get,never) : Level; inline function get_level() return Game.ME.level;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);
    
	 
    var isw(get,never): Float; inline function get_isw() return 1 / width;
    var ish(get,never): Float; inline function get_ish() return 1 / width;

	var aspectRatio(get,never):Float ;inline function get_aspectRatio() return width * ish;
	var aspectRatio2(get,never):Float;inline function get_aspectRatio2() return aspectRatio * aspectRatio;

    var FLUID_WIDTH(get,never) : Int; inline function get_FLUID_WIDTH()  return level.cWid;
    var FLUID_HEIGHT(get,never): Int; inline function get_FLUID_HEIGHT() return Std.int( FLUID_WIDTH * height / width );
    var test:SolverDebugRendering;
	var solver:FluidSolver;

	var g:h2d.Graphics;
	var testShader:aleiiioa.systems.shaders.TestShaders;

	public function new() {
		super();
		solver = new FluidSolver(FLUID_WIDTH,FLUID_HEIGHT);
		Workflow.reset();
		Game.ME.camera.clampToLevelBounds = true;

		Workflow.addSystem(new GridPositionActualizer());
		Workflow.addSystem(new Physics());
		Workflow.addSystem(new SolverDebugRendering(Game.ME.scroller,solver));
		
		//testShader = new aleiiioa.systems.shaders.TestShaders(Game.ME.scroller);
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
		addForce(20,20,0,10);
		solver.update();
		//testShader.update();
				//test.drawGridGraphics();
	    
	}

	override function postUpdate() {
		super.postUpdate();
		
		Workflow.postUpdate(tmod);
	}

	private function addForce(cx:Int, cy:Int, dx:Float, dy:Float):Void {
		var speed:Float = dx * dx  + dy * dy * aspectRatio2;
		if(speed > 0) {
			var velocityMult:Float = 20.0;
			var index:Int = solver.getIndexForCellPosition(cx,cy);

			solver.uOld[index] += dx * velocityMult;
			solver.vOld[index] += dy * velocityMult;
		}
	}
}
	

