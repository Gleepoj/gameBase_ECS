package aleiiioa;

import echoes.SystemList;
import echoes.Entity;
import aleiiioa.systems.logic.object.BombLogicSystem;
import aleiiioa.builders.*;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.systems.logic.interaction.CatchLogicSystem;

import aleiiioa.systems.utils.*;
import aleiiioa.systems.core.*;
import aleiiioa.systems.local.particules.*;
import aleiiioa.systems.core.renderer.*;
import aleiiioa.systems.core.input.*;
import aleiiioa.systems.core.physics.*;
import aleiiioa.systems.core.position.*;
import aleiiioa.systems.core.collisions.*;

import aleiiioa.systems.local.dialog.*;

import echoes.Workflow;

class Aleiiioa extends Game {

	var game(get,never) : Game; inline function get_game() return Game.ME;
	
	var cameraFocus:Entity;
	var cameraFocusPosition:GridPosition;

	public function new() {
		super();
		Workflow.reset();
		
		var cameraPoint = level.data.l_Entities.all_CameraPoint[0];
		cameraFocus = EntityBuilders.cameraFocus(cameraPoint.cx,cameraPoint.cy);
		cameraFocusPosition = cameraFocus.get(GridPosition);

		Game.ME.camera.trackEntityGridPosition(cameraFocusPosition,true,1);
		Game.ME.camera.centerOnGridTarget();		
		Game.ME.camera.clampToLevelBounds = false;
		
		
		// ECS //
		var player = level.data.l_Entities.all_Player[0];
		EntityBuilders.player(player.cx,player.cy);

		for (e in level.data.l_Entities.all_PNJ){
			EntityBuilders.pnj(e.cx,e.cy,e.f_Dialog);
		}

		for (cp in level.data.l_Entities.all_ChouxPeteur){
			EntityBuilders.chouxPeteur(cp.cx,cp.cy);
		}
		
		//Collision
		Workflow.addSystem(new GarbageCollectionSystem());
		Workflow.addSystem(new CollisionsListenerActualizer());
		
		
		//Object
		Workflow.addSystem(new LevelCollisionsSystem());
		Workflow.addSystem(new VelocitySystem());
		Workflow.addSystem(new CollisionReactionEvent());
		Workflow.addSystem(new GridPositionActualizer());

		//Interaction
		Workflow.add60FpsSystem(new CatchLogicSystem());
		Workflow.add60FpsSystem(new BombLogicSystem());
		
		//Particles
		Workflow.addSystem(new ParticulesVelocitySystem());
		Workflow.add60FpsSystem(new ParticulesSystem());
		Workflow.add60FpsSystem(new ParticuleRenderer());
		
		//Graphics
		Workflow.add60FpsSystem(new SquashRenderer());
		Workflow.add60FpsSystem(new SpriteExtensionFx());
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller,Game.ME));
		
		//Dialog
		var dialog = new echoes.SystemList()
		.add(new DialogAreaCollisions())
		.add(new DialogYarnSystem())
		.add(new DialogInputSystem())
		.add(new DialogUISystem());

		Workflow.add60FpsSystem(dialog);
		
			//Helpers
		Workflow.add60FpsSystem(new UIHelperSystem());
		//Input
		Workflow.add60FpsSystem(new InputSystem());


	}


	override function fixedUpdate() {
		super.fixedUpdate();
		Workflow.update(Const.FIXED_DELTA);
	}

	override function postUpdate() {
		super.postUpdate();
		Workflow.postUpdate(tmod);
	}


}
	

