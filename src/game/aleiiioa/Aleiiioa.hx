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
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller));
		Workflow.addSystem(new Physics());

		for (i in 0...100){
			for(j in 0...20){
				Builders.basicObject(i*10,200+j*20);
			}
		}
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
	

