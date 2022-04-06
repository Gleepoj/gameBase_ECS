package aleiiioa;

import h3d.Vector;
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
	var camEntityGp:GridPosition;

	public function new() {
		super();
		Workflow.reset();
		
		
		var player = level.data.l_Entities.all_PlayerStart[0];
		pE = Builders.basicPlayer(player.cx,player.cy);
		camEntityGp = pE.get(GridPosition);

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

		Game.ME.camera.trackEntityGridPosition(camEntityGp,false,1);
		Game.ME.camera.clampToLevelBounds = false;
		
		

		Workflow.addSystem(new SpawnSystem());
		
		//Collision
		Workflow.addSystem(new GarbageCollectionSystem());
		Workflow.addSystem(new LevelCollisionsSystem());
		Workflow.addSystem(new EntityCollisionsSystem());
		Workflow.addSystem(new CollisionsListenerActualizer());

		//Logic
		Workflow.addSystem(new PathActualizer());
		Workflow.addSystem(new SteeringBehaviors());
		Workflow.addSystem(new GunSystem());
		
		
		//Fluid
		Workflow.addSystem(new SolverSystem());
		Workflow.addSystem(new ModifierSystem());
		//Workflow.addSystem(new SolverDebugRenderer(Game.ME.scroller));
		
		Workflow.add60FpsSystem(new VelocitySystem());
		Workflow.add60FpsSystem(new GridPositionActualizer());
		//Workflow.addSystem(new FluidScrollingSystem());
		Workflow.add60FpsSystem(new WingsBehaviors());
		//Graphics
		Workflow.add60FpsSystem(new ShaderRenderer(Game.ME.scroller));
		Workflow.add60FpsSystem(new SpriteExtensionFx());
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller,Game.ME));
		
		//Debugger
		//Workflow.add60FpsSystem(new BoundingBoxRenderer(Game.ME.scroller));
		Workflow.add60FpsSystem(new DebugLabelRenderer(Game.ME.scroller));
		
		//Input
		Workflow.add60FpsSystem(new InputSystem());

	

		//trace(Workflow.entities.length);
	}


	override function fixedUpdate() {
		super.fixedUpdate();
		Workflow.update(tmod);
	}

	override function postUpdate() {
		Workflow.postUpdate(tmod);

		super.postUpdate();
	}

	private function cameraTargetInterpolatePosition(gp:GridPosition){
		var _x = M.lerp(gp.lastFixedUpdateX, (gp.cx+gp.xr)*Const.GRID, game.getFixedUpdateAccuRatio());
		var _y = M.lerp(gp.lastFixedUpdateY, (gp.cy+gp.yr)*Const.GRID, game.getFixedUpdateAccuRatio()); 
		return new Vector(_x,_y);
	}

}
	

