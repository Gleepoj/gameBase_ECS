package aleiiioa.builders.worlds;

import aleiiioa.components.core.level.LevelComponent;
import aleiiioa.builders.entity.local.UIBuilders;
import aleiiioa.builders.entity.plateformer.PlateformerEntity;
import aleiiioa.builders.entity.topdown.TopDownEntity;
import aleiiioa.builders.entity.CoreEntity;
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
import aleiiioa.systems.core.camera.CameraSynchronizer;
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
        Game.ME.ui_layer.removeChildren();

		Workflow.reset();
		
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
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.origin,Game.ME));
		Workflow.add60FpsSystem(new DebugLabelRenderer(Game.ME.origin));
		
	    Workflow.addSystem(new UIHelperSystem());
		Workflow.add60FpsSystem(new InputSystem());
		Workflow.add60FpsSystem(new GarbageCollectionSystem()); 
    }

	//////////////////////////////////////////////////
	///////////////////////////////////////////////////
	////////////////////////////////////////////////
	//////////////////////////////////////////////////
	///////////////////////////////////////////////
	/////////////////////////////////////////////////

	public static function newTopDownLevel(level:Level){
		Game.ME.ui_layer.removeChildren();
	
	   // ECS //
	/*    var camera = level.data.l_Entities.all_CameraPoint[0];
	   var camGp = CoreEntity.cameraFocus(camera.cx,camera.cy);
	   Game.ME.level.setFocus(camGp); */
	   
	   var player = level.data.l_Entities.all_Player[0];
	   TopDownEntity.player(player.cx,player.cy);
	   
	   for (e in level.data.l_Entities.all_PNJ){
			TopDownEntity.pnj(e.cx,e.cy,e.f_Dialog_File_Path);
	   }
	
	   for (cp in level.data.l_Entities.all_ChouxPeteur){
			TopDownEntity.chouxPeteur(cp.cx,cp.cy);
	   }
	   
	   var _level = new LevelComponent(level.data);
	   new echoes.Entity().add(_level);
	   for(l in level.data.neighbours){
		 var a:World_Level = Assets.worldData.all_worlds.Default.getLevel(l.levelIid);
		 var new_l = new LevelComponent(a);
		 new echoes.Entity().add(new_l);
	   }
	   //Collision
	   Workflow.addSystem(new GarbageCollectionSystem());
	   
	   //Object
	   Workflow.addSystem(new CollisionSensorSystem());

	  
	   Workflow.add60FpsSystem(new CollisionReactionEvent());
	   Workflow.add60FpsSystem(new GridPositionActualizer());
	  
	   Workflow.add60FpsSystem(new VelocitySystem());
	   //Workflow.add60FpsSystem(new CameraSynchronizer());
	
	   //Interaction
	   Workflow.add60FpsSystem(new CatchLogicSystem());
	   Workflow.add60FpsSystem(new BombLogicSystem());
	   
	   //Particles
	   Workflow.addSystem(new ParticulesVelocitySystem());
	   Workflow.add60FpsSystem(new ParticulesSystem());
	   Workflow.add60FpsSystem(new ParticuleRenderer());
	   
	   //Graphics
	   Workflow.add60FpsSystem(new LevelRenderer());
	   Workflow.add60FpsSystem(new TemporarySystem());
	   Workflow.add60FpsSystem(new BoundingBoxRenderer(Game.ME.origin));
	   Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.origin,Game.ME));
	  
	   Workflow.add60FpsSystem(new SquashRenderer());
	   Workflow.add60FpsSystem(new SpriteExtensionFx());
	  
	  
	  
	   
	   
	   
	   //Dialog
	   Workflow.add60FpsSystem(new DialogAreaCollisions());
	   Workflow.add60FpsSystem(new DialogYarnSystem());	
	   Workflow.add60FpsSystem(new DialogInputSystem());
	   Workflow.add60FpsSystem(new DialogUISystem());
	   
	   //Level 
	  
	   //Helpers
	   Workflow.add60FpsSystem(new UIHelperSystem());
	   //Input
	   Workflow.add60FpsSystem(new InputSystem());
	
	}

	/////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////


	public static function newPlateformerLevel(level:Level){
		Game.ME.ui_layer.removeChildren();

	   /* var cameraPoint = level.data.l_Entities.all_CameraPoint[0];
	   var cameraFocus = CoreEntity.cameraFocus(cameraPoint.cx,cameraPoint.cy);
	   var cameraFocusPosition = cameraFocus.get(GridPosition);

	   Game.ME.camera.trackEntityGridPosition(cameraFocusPosition,true,1);
	   Game.ME.camera.centerOnGridTarget();		
	   Game.ME.camera.clampToLevelBounds = false; */
	   
	   // ECS //
	   var player = level.data.l_Entities.all_Player[0];
	   PlateformerEntity.player(player.cx,player.cy);

	   for (e in level.data.l_Entities.all_PNJ){
		   PlateformerEntity.pnj(e.cx,e.cy,e.f_Dialog_File_Path);
	   }

	   for (cp in level.data.l_Entities.all_ChouxPeteur){
		   PlateformerEntity.chouxPeteur(cp.cx,cp.cy);
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

   
