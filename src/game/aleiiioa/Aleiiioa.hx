package aleiiioa;


import aleiiioa.components.*;
import aleiiioa.systems.*;
import aleiiioa.builders.*;
import echoes.Workflow;
import echoes.Entity;
/**
	This small class just creates a SamplePlayer instance in current level
**/

class Aleiiioa extends Game {

	public function new() {
		super();

		Game.ME.camera.clampToLevelBounds = true;

		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller));
		Workflow.addSystem(new Physics());
		Workflow.addSystem(new GridPositionActualizer());

		for (i in 0...20){
			for(j in 0...20){
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
	

