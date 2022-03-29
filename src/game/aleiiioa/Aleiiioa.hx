package aleiiioa;

import aleiiioa.builders.*;
import aleiiioa.components.core.position.GridPosition;

import aleiiioa.systems.core.*;
import aleiiioa.systems.renderer.*;
import aleiiioa.systems.solver.*;
import aleiiioa.systems.modifier.*;
import aleiiioa.systems.collisions.*;
import aleiiioa.systems.vehicule.*;

import echoes.Workflow;

class Aleiiioa extends Game {
	var game(get,never) : Game; inline function get_game() return Game.ME;
	var cameraFocus:LPoint;
	var pE:echoes.Entity;
	public function new() {
		super();
		Workflow.reset();
		
		
		var player = level.data.l_Entities.all_PlayerStart[0];
		pE = Builders.basicPlayer(player.cx,player.cy);

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
		cameraFocus = LPoint.fromCase(cameraPoint.cx,cameraPoint.cy);

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
		Workflow.addSystem(new WingsBehaviors());
		Workflow.addSystem(new SteeringBehaviors());
		Workflow.addSystem(new GunSystem());
		
		
		//Physics
		Workflow.addSystem(new SolverSystem());
		Workflow.addSystem(new ModifierSystem());
		Workflow.addSystem(new VelocitySystem());
		Workflow.addSystem(new GridPositionActualizer());

		//Graphics
		Workflow.add60FpsSystem(new SolverDebugRenderer(Game.ME.scroller));
		//Workflow.add60FpsSystem(new ShaderRenderer(Game.ME.scroller));
		Workflow.add60FpsSystem(new SpriteExtensionFx());
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller,Game.ME));
		
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
		
		if(pE.isValid()){
			var pos = pE.get(GridPosition);
			cameraFocus.updatePoint(pos.attachX,pos.attachY);
		}
		
		Workflow.postUpdate(tmod);
		
	}

}
	

