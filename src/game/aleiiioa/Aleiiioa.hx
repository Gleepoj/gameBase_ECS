package aleiiioa;

import aleiiioa.builders.*;

import aleiiioa.systems.core.*;
import aleiiioa.systems.renderer.*;
import aleiiioa.systems.solver.*;
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

		for (b in level.data.l_Entities.all_Vessel){
			Builders.basicHunter(b.cx,b.cy,b.f_Path,b.f_spawn_sec);
		}

		for (e in level.data.l_Entities.all_Elements){
			Builders.basicElement(e.cx,e.cy,e.f_spawn_sec);
		}

		var cameraPoint = level.data.l_Entities.all_CameraPoint[0];
		var cameraFocus = LPoint.fromCase(cameraPoint.cx,cameraPoint.cy);

		Game.ME.camera.trackEntity(cameraFocus,false);
		Game.ME.camera.clampToLevelBounds = true;
		

		Workflow.addSystem(new SpawnSystem());
		
		//Collision
		Workflow.addSystem(new GarbageCollectionSystem());
		Workflow.addSystem(new LevelCollisionsSystem());
		Workflow.addSystem(new EntityCollisionsSystem());
		Workflow.addSystem(new CollisionsListenerActualizer());

		//Logic
		Workflow.addSystem(new PathActualizer());
		Workflow.addSystem(new VeilBehaviors());
		Workflow.addSystem(new WingsBehaviors());
		Workflow.addSystem(new SteeringBehaviors());
		Workflow.addSystem(new GunSystem());
		
		//Physics
		Workflow.addSystem(new SolverSystem());// is Hiding Modifier system // 
		Workflow.addSystem(new VelocitySystem());
		Workflow.addSystem(new GridPositionActualizer());

		//Graphics
		Workflow.add60FpsSystem(new SpriteExtensionFx());
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller,Game.ME));
		//Debugger
		Workflow.add60FpsSystem(new BoundingBoxRenderer(Game.ME.scroller));
		Workflow.add60FpsSystem(new DebugLabelRenderer(Game.ME.scroller));
		//Input
		Workflow.add60FpsSystem(new InputSystem());

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
	

