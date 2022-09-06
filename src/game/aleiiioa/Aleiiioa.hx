package aleiiioa;

import aleiiioa.builders.*;
import aleiiioa.components.core.position.GridPosition;

import aleiiioa.systems.ui.*;
import aleiiioa.systems.core.*;
import aleiiioa.systems.particules.*;
import aleiiioa.systems.renderer.*;
import aleiiioa.systems.collisions.*;
import aleiiioa.systems.dialog.*;

import echoes.Workflow;

class Aleiiioa extends Game {
	var game(get,never) : Game; inline function get_game() return Game.ME;

	public function new() {
		super();
		Workflow.reset();
		
		
		
		var cameraPoint = level.data.l_Entities.all_CameraPoint[0];
		var cameraFocus = Builders.cameraFocus(cameraPoint.cx,cameraPoint.cy);
		var cameraFocusPosition = cameraFocus.get(GridPosition);

		Game.ME.camera.trackEntityGridPosition(cameraFocusPosition,true,1);
		Game.ME.camera.centerOnGridTarget();		
		Game.ME.camera.clampToLevelBounds = false;
		
		
		// ECS //
		var player = level.data.l_Entities.all_PlayerStart[0];
		
		Builders.player(player.cx,player.cy);

		for (e in level.data.l_Entities.all_PNJ){
			Builders.pnj(e.cx,e.cy,e.f_Dialog);
		}
		
		//Collision
		Workflow.addSystem(new GarbageCollectionSystem());
		Workflow.addSystem(new CollisionsListenerActualizer());
		Workflow.addSystem(new EntityCollisionsSystem());
		//Object
		
		Workflow.addSystem(new LevelCollisionsSystem());
		Workflow.addSystem(new VelocitySystem());
		Workflow.addSystem(new GridPositionActualizer());
		
		
		Workflow.add60FpsSystem(new ParticulesSystem());
		Workflow.add60FpsSystem(new ParticuleRenderer());
		
		//Graphics
		Workflow.add60FpsSystem(new SquashRenderer());
		Workflow.add60FpsSystem(new SpriteExtensionFx());
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller,Game.ME));
		Workflow.add60FpsSystem(new ShaderRenderer(Game.ME.scroller));
		
		//Helpers
		Workflow.add60FpsSystem(new UIHelperSystem());
		
		//Dialog
		Workflow.add60FpsSystem(new DialogYarnSystem());
		Workflow.add60FpsSystem(new DialogInputSystem());
		Workflow.add60FpsSystem(new DialogUISystem());
		
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
	

