package aleiiioa.builders.worlds;

import aleiiioa.systems.local.ui.selector.MouseSystem;
import aleiiioa.systems.local.ui.UIGridPositionActualizer;
import aleiiioa.systems.local.ui.selector.SelectorRenderer;
import aleiiioa.systems.local.ui.selector.SelectorNavigationSystem;
import aleiiioa.systems.local.ui.selector.SelectorControlSystem;
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
			//ActorBuilders.bonhomme(e.cx,e.cy,0.,0.,opos,e.f_PieceSide);
            UIBuilders.menu(e);
		} 
        //ActorBuilders.cursor(10,10,0.,1.1,cameraFocusPosition);
		//ActorBuilders.mouse(cameraFocusPosition); */
		
		//Workflow.add60FpsSystem(new MouseSystem());
		//Workflow.add60FpsSystem(new CollisionsListenerActualizer());
		//Workflow.add60FpsSystem(new EntityCollisionsSystem());
		//Object
		Workflow.add60FpsSystem(new VelocitySystem());
		Workflow.add60FpsSystem(new GridPositionActualizer());
        Workflow.add60FpsSystem(new DelayedMovementSystem());
		
		Workflow.add60FpsSystem(new UIGridPositionActualizer());
		Workflow.add60FpsSystem(new MouseSystem());
		Workflow.add60FpsSystem(new SelectorControlSystem());
		///Workflow.add60FpsSystem(new SelectorSelectabilitySystem());
		Workflow.add60FpsSystem(new SelectorNavigationSystem());
		//Workflow.add60FpsSystem(new SelectorRenderer());
		
		//Workflow.add60FpsSystem(new UIMenuSystem());
        //Workflow.add60FpsSystem(new UISubmenuSystem());

		
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
		Workflow.reset();
			
		
		var cameraPoint = level.data.l_Entities.all_CameraPoint[0];
		var cameraFocus = EntityBuilders.cameraFocus(cameraPoint.cx,cameraPoint.cy);
		var cameraFocusPosition = cameraFocus.get(GridPosition);

		Game.ME.camera.trackEntityGridPosition(cameraFocusPosition,true,1);
		Game.ME.camera.centerOnGridTarget();		
		Game.ME.camera.clampToLevelBounds = false;
		
		
		// ECS //
		//var player = level.data.l_Entities.all_Player[0];
		//EntityBuilders.player(player.cx,player.cy);

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

   
}