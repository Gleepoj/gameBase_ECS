package aleiiioa;


import aleiiioa.builders.*;
import aleiiioa.components.core.position.GridPosition;


import aleiiioa.systems.ui.*;
import aleiiioa.systems.core.*;
import aleiiioa.systems.renderer.*;
import aleiiioa.systems.solver.*;
import aleiiioa.systems.modifier.*;
import aleiiioa.systems.collisions.*;
import aleiiioa.systems.vehicule.*;

import echoes.Workflow;

class Aleiiioa extends Game {
	var game(get,never) : Game; inline function get_game() return Game.ME;

	public function new() {
		super();
		Workflow.reset();
		
		
		var player = level.data.l_Entities.all_PlayerStart[0];
		
		Builders.basicPlayer(player.cx,player.cy);
		
 		for (m in level.data.l_Entities.all_Modifier){
			Builders.basicModifier(m.cx,m.cy,m.f_AreaEquation);
		} 

		var cameraPoint = level.data.l_Entities.all_CameraPoint[0];
		var cameraFocus = Builders.cameraFocus(cameraPoint.cx,cameraPoint.cy);
		var cameraFocusPosition = cameraFocus.get(GridPosition);

		Game.ME.camera.trackEntityGridPosition(cameraFocusPosition,true,1);
		Game.ME.camera.centerOnGridTarget();		
		Game.ME.camera.clampToLevelBounds = false;
		
		
		// ECS //
		Workflow.addSystem(new SpawnSystem());
		
		
		//Collision
		Workflow.addSystem(new GarbageCollectionSystem());
		Workflow.addSystem(new LevelCollisionsSystem());
		Workflow.addSystem(new EntityCollisionsSystem());
		Workflow.addSystem(new CollisionsListenerActualizer());

		//Logic
		Workflow.add60FpsSystem(new PaddleSystem());
		Workflow.add60FpsSystem(new VehiculePhysicsSystem());
		
		
		//Fluid
		Workflow.addSystem(new SolverSystem());
		Workflow.addSystem(new ModifierSystem());
		Workflow.add60FpsSystem(new FluidScrollingSystem());
		
		
		//Object
		Workflow.add60FpsSystem(new VelocitySystem());
		Workflow.add60FpsSystem(new GridPositionActualizer());
		
		
		//Graphics
		
		Workflow.add60FpsSystem(new SolverDebugRenderer());
		Workflow.add60FpsSystem(new StreamlineRenderer(Game.ME.scroller));
		Workflow.add60FpsSystem(new SpriteExtensionFx());
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller,Game.ME));
		
		//Helpers
		Workflow.add60FpsSystem(new UIHelperSystem());
		
		//Debugger
		//Workflow.add60FpsSystem(new BoundingBoxRenderer(Game.ME.scroller));
		//Workflow.add60FpsSystem(new DebugLabelRenderer(Game.ME.scroller));
		
		//Input
		Workflow.add60FpsSystem(new InputSystem());

	

		//trace(Workflow.entities.length);
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
	

