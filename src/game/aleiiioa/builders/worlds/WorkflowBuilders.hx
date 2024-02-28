package aleiiioa.builders.worlds;

import aleiiioa.components.core.level.Chunk_Active;
import aleiiioa.components.core.level.Focused_Chunk;
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
import aleiiioa.systems.core.camera.*;
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
		Game.ME.scroller.removeChildren();
		Game.ME.origin.removeChildren();

		Workflow.reset();

		var ocx = level.data.f_ci * Const.CHUNK_SIZE;
		var ocy = level.data.f_cj * Const.CHUNK_SIZE;
		var cxoff = M.floor(level.data.worldX/Const.GRID);
		var cyoff = M.floor(level.data.worldY/Const.GRID);

		// ECS //
		
        for (e in level.data.l_Entities.all_UIWindow){
            UIBuilders.menu(e);
		} 

		for (c in level.data.l_Entities.all_Camera_Center){
			CoreEntity.cameraBis(c.cx+cxoff,c.cy+cyoff);
	   	} 

		var _level = new LevelComponent(level.data);
		
		var focus  = new Focused_Chunk();
		var active = new Chunk_Active();

		new echoes.Entity().add(_level,focus,active);
 
		Workflow.add60FpsSystem(new VelocitySystem());
		Workflow.add60FpsSystem(new GridPositionActualizer());
        Workflow.add60FpsSystem(new DelayedMovementSystem());
		
		Workflow.add60FpsSystem(new UIGridPositionActualizer());
		Workflow.add60FpsSystem(new UIPadInputSystem());
		Workflow.add60FpsSystem(new UIPadNavigationSystem());
		Workflow.add60FpsSystem(new UIButtonInteractionSystem());
		
		//Graphics
		Workflow.add60FpsSystem(new CameraSynchronizer());
		Workflow.add60FpsSystem(new LevelRenderer());
		Workflow.add60FpsSystem(new SquashRenderer());
		Workflow.add60FpsSystem(new SpriteExtensionFx());
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.origin,Game.ME));
		Workflow.add60FpsSystem(new DebugLabelRenderer(Game.ME.origin));
		
	    Workflow.addSystem(new UIHelperSystem());
		Workflow.add60FpsSystem(new InputSystem());
		Workflow.add60FpsSystem(new GarbageCollectionSystem()); 
    }

	//////////////////////////////////////////////////
	//////////////////TOPDOWN////////////////////////



	public static function newTopDownLevel(level:Level){
		Game.ME.ui_layer.removeChildren();
		// To know where the player is investigate "JSON Table of content" in ldtk doc it is an accessible list without loading level 
		var ocx = level.data.f_ci * Const.CHUNK_SIZE;
		var ocy = level.data.f_cj * Const.CHUNK_SIZE;
	
		var player = level.data.l_Entities.all_Player[0];
		
		TopDownEntity.player(player.cx+ocx,player.cy+ocy);
		
		for (c in level.data.l_Entities.all_Camera_Center){
			 CoreEntity.cameraBis(c.cx+ocx,c.cy+ocy);
		} 
 
		for (e in level.data.l_Entities.all_PNJ){
			PlateformerEntity.pnj(e.cx+ocx,e.cy+ocy,e.f_Dialog_File_Path);
		}
 
		for (cp in level.data.l_Entities.all_ChouxPeteur){
			PlateformerEntity.chouxPeteur(cp.cx+ocx,cp.cy+ocy);
		}
	   
	    var loadedLevels = new Map<String, Bool>();
		var start_level = new LevelComponent(level.data);
		
		var focus  = new Focused_Chunk();
		var active = new Chunk_Active();

		new echoes.Entity().add(start_level,focus,active);

		loadedLevels.set(level.data.iid, true);
		loadNeighbours(level,loadedLevels);

	    createWorkflow();
	}

	public static function loadNeighbours(level:Level, _previouslyLoaded:Map<String,Bool>) {
		for(l in level.data.neighbours){
			if (!_previouslyLoaded.exists(l.levelIid)) {
				var a:World_Level = Assets.worldData.all_worlds.Default.getLevel(l.levelIid);
				var new_l  = new LevelComponent(a);
				var new_wl = new Level(a);
				var active = new Chunk_Active();
				new echoes.Entity().add(new_l,active);
				_previouslyLoaded.set(l.levelIid, true);
				loadNeighbours(new_wl,_previouslyLoaded);
			}
		}
	}

	/////////////////////////////////////////////////////////
	////////////////PLATEFORMER//////////////////////////////

	public static function newPlateformerLevel(level:Level){
		Game.ME.ui_layer.removeChildren();	   
	   var ocx = level.data.f_ci * Const.CHUNK_SIZE;
	   var ocy = level.data.f_cj * Const.CHUNK_SIZE;
	   // ECS //
	   var player = level.data.l_Entities.all_Player[0];
	   
	   PlateformerEntity.player(player.cx,player.cy);
	   
	   for (c in level.data.l_Entities.all_Camera_Center){
			CoreEntity.cameraBis(c.cx+ocx,c.cy+ocy);
	   } 

	   for (e in level.data.l_Entities.all_PNJ){
		   PlateformerEntity.pnj(e.cx+ocx,e.cy+ocy,e.f_Dialog_File_Path);
	   }

	   for (cp in level.data.l_Entities.all_ChouxPeteur){
		   PlateformerEntity.chouxPeteur(cp.cx+ocx,cp.cy+ocy);
	   }

	   var _level = new LevelComponent(level.data);
	   new echoes.Entity().add(_level);
	   for(l in level.data.neighbours){
		 var a:World_Level = Assets.worldData.all_worlds.Default.getLevel(l.levelIid);
		 var new_l = new LevelComponent(a);
		 new echoes.Entity().add(new_l);
	   } 
	   
	   createWorkflow();


   }

   public static function createWorkflow() {
		   //Collision
		   Workflow.addSystem(new GarbageCollectionSystem());
	   
		   //Object
		   Workflow.addSystem(new CollisionSensorSystem());
		   Workflow.addSystem(new VelocitySystem());
		   Workflow.addSystem(new CollisionReactionEvent());
		   Workflow.add60FpsSystem(new GridPositionActualizer());
		   Workflow.add60FpsSystem(new DelayedMovementSystem());
		   Workflow.addSystem(new ChunkLoaderSystem());
		   
		  
	
		   //Interaction
		   Workflow.add60FpsSystem(new CatchLogicSystem());
		   Workflow.add60FpsSystem(new BombLogicSystem());
		   
		   //Particles
		   Workflow.addSystem(new ParticulesVelocitySystem());
		   Workflow.add60FpsSystem(new ParticulesSystem());
		   Workflow.add60FpsSystem(new ParticuleRenderer());
		   
		   //Graphics
		   Workflow.add60FpsSystem(new CameraSynchronizer());
		   Workflow.add60FpsSystem(new LevelRenderer());
		   Workflow.add60FpsSystem(new SquashRenderer());
		   Workflow.add60FpsSystem(new BoundingBoxRenderer(Game.ME.origin));
		   Workflow.add60FpsSystem(new SpriteExtensionFx());
		   Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.origin,Game.ME));
		   
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

   
