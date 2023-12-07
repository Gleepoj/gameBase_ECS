package aleiiioa.builders.worlds;

import aleiiioa.systems.local.ui.UIButtonInteractionSystem;

import aleiiioa.systems.local.ui.UIGridPositionActualizer;
import aleiiioa.systems.local.ui.pad.UIPadNavigationSystem;
import aleiiioa.systems.local.ui.pad.UIPadInputSystem;
import echoes.SystemList;
import echoes.Entity;
import echoes.Workflow;

import aleiiioa.systems.logic.object.BombLogicSystem;
import aleiiioa.builders.*;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.systems.logic.interaction.CatchLogicSystem;

import aleiiioa.systems.utils.*;
import aleiiioa.systems.core.*;
import aleiiioa.systems.local.particules.*;
import aleiiioa.systems.core.renderer.*;
import aleiiioa.systems.core.input.*;
import aleiiioa.systems.logic.qualia.*;
import aleiiioa.systems.core.physics.*;
import aleiiioa.systems.core.physics.collision.*;
import aleiiioa.systems.core.physics.position.*;
import aleiiioa.systems.core.physics.velocity.*;
import aleiiioa.systems.core.collisions.*;

import aleiiioa.systems.local.dialog.*;

class WorkflowBuilders {
    var game(get,never) : Game; inline function get_game() return Game.ME;
	
	
    public static function newMenu(level:Level){
        
        var cameraFocus:Entity;
	    var cameraFocusPosition:GridPosition;
		
		Workflow.reset();
		Workflow.reset();
		
		var cameraPoint = level.data.l_Entities.all_CameraPoint[0];
		cameraFocus = EntityBuilders.cameraFocus(cameraPoint.cx,cameraPoint.cy);
		cameraFocusPosition = cameraFocus.get(GridPosition);
        Game.ME.camera.clampToLevelBounds = true;

		

        for (e in level.data.l_Entities.all_UIWindow){
            UIBuilders.menu(e);
		} 
 
		Workflow.add60FpsSystem(new VelocitySystem());
		Workflow.add60FpsSystem(new GridPositionActualizer());
        Workflow.add60FpsSystem(new DelayedMovementSystem());
		
		Workflow.add60FpsSystem(new UIGridPositionActualizer());
		Workflow.add60FpsSystem(new UIPadInputSystem());
		Workflow.add60FpsSystem(new UIPadNavigationSystem());
		Workflow.add60FpsSystem(new UIButtonInteractionSystem());
		
		//Graphics
		Workflow.add60FpsSystem(new SquashRenderer());
		Workflow.add60FpsSystem(new SpriteExtensionFx());
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller,Game.ME));
		Workflow.add60FpsSystem(new DebugLabelRenderer(Game.ME.scroller));
		
	    Workflow.addSystem(new UIHelperSystem());
		Workflow.add60FpsSystem(new InputSystem());
		Workflow.add60FpsSystem(new GarbageCollectionSystem()); 
    }


	public static function newLevel(level:Level){
		
		var cameraPoint = level.data.l_Entities.all_CameraPoint[0];
		var cameraFocus = EntityBuilders.cameraFocus(cameraPoint.cx,cameraPoint.cy);
		var cameraFocusPosition = cameraFocus.get(GridPosition);

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
		
		//Object
		Workflow.addSystem(new CollisionSensorSystem());
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
		Workflow.add60FpsSystem(new DialogAreaCollisions());
		Workflow.add60FpsSystem(new DialogYarnSystem());	
		Workflow.add60FpsSystem(new DialogInputSystem());
		Workflow.add60FpsSystem(new DialogUISystem());
		
			//Helpers
		Workflow.add60FpsSystem(new UIHelperSystem());
		//Input
		Workflow.add60FpsSystem(new InputSystem());

    }

   
}