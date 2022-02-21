package aleiiioa;

import aleiiioa.systems.vehicule.*;
import aleiiioa.systems.core.*;
import aleiiioa.systems.solver.*;
import aleiiioa.builders.*;

import echoes.Workflow;

class Aleiiioa extends Game {
	var game(get,never) : Game; inline function get_game() return Game.ME;


	public function new() {
		super();
		Workflow.reset();
		Game.ME.camera.clampToLevelBounds = true;

		Workflow.addSystem(new GridPositionActualizer());
		Workflow.addSystem(new PathActualizer());
		Workflow.addSystem(new SteeringBehaviors());
		Workflow.addSystem(new GunSystem());
		
		Workflow.addSystem(new Solvered());
		Workflow.addSystem(new Physics());
		Workflow.addSystem(new LevelCollisionsSystem());
		 

		Workflow.add60FpsSystem(new InputSystem());
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller,Game.ME));
		Workflow.add60FpsSystem(new BoundingBoxSystem(Game.ME.scroller));
		 
/* 		for (i in 0...level.cWid){
			for(j in 0...level.cHei){
				Builders.basicObject(i,j);
			}
		}  */

		for (b in level.data.l_Entities.all_Boides){
			Builders.basicHunter(b.cx,b.cy,b.f_Path);
		}
		Builders.basicPlayer(20,20);

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
	

