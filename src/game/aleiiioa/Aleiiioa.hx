package aleiiioa;

import aleiiioa.builders.*;

import aleiiioa.systems.core.*;
import aleiiioa.systems.core.renderer.*;
import aleiiioa.systems.solver.*;
import aleiiioa.systems.collisions.*;
import aleiiioa.systems.vehicule.*;


import echoes.Workflow;

class Aleiiioa extends Game {
	var game(get,never) : Game; inline function get_game() return Game.ME;


	public function new() {
		super();
		Workflow.reset();
		Game.ME.camera.clampToLevelBounds = true;

		for (b in level.data.l_Entities.all_Vessel){
			Builders.basicHunter(b.cx,b.cy,b.f_Path,b.f_spawn_sec);
		}
		var player = level.data.l_Entities.all_PlayerStart[0];

		Builders.basicPlayer(player.cx,player.cy);


		Workflow.addSystem(new SpawnSystem());
		//Collision
		Workflow.addSystem(new LevelCollisionsSystem());
		Workflow.addSystem(new EntityCollisionsSystem());
		Workflow.addSystem(new CollisionsListenerActualizer());

		//Logic
		Workflow.addSystem(new PathActualizer());
		Workflow.addSystem(new SteeringBehaviors());
		Workflow.addSystem(new GunSystem());
		
		//Physics
		Workflow.addSystem(new Solvered());// is Hiding Modifier system // 
		Workflow.addSystem(new Physics());
		Workflow.addSystem(new GridPositionActualizer());

		//Graphics
		Workflow.addSystem(new SpriteExtensionFx());

		Workflow.add60FpsSystem(new InputSystem());
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller,Game.ME));
		Workflow.add60FpsSystem(new BoundingBoxRenderer(Game.ME.scroller));


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
	

