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
import echoes.Echoes;

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

class EchoesBuilders {
    var game(get,never) : Game; inline function get_game() return Game.ME;
	
	
    public static function newMenu(level:Level){
        Game.ME.ui_layer.removeChildren();
		Game.ME.scroller.removeChildren();
		Game.ME.origin.removeChildren();

		Echoes.reset();
		Echoes.init();

		var ocx = level.data.f_ci * Const.CHUNK_SIZE;
		var ocy = level.data.f_cj * Const.CHUNK_SIZE;
		var cxoff = M.floor(level.data.worldX/Const.GRID);
		var cyoff = M.floor(level.data.worldY/Const.GRID);
		//trace('$cxoff :: $cyoff');
		//level.coordId()
		// ECS /
		var selector:Entity_UI_Selector = level.data.l_Entities.all_UI_Selector[0];
		
		for (c in level.data.l_Entities.all_Camera_Center){
			CoreEntity.cameraBis(c.cx+cxoff,c.cy+cyoff);
	   	} 

        for (e in level.data.l_Entities.all_UIWindow){
            UIBuilders.menu(e,selector);
		} 



		var _level = new LevelComponent(level.data);
		
		var focus  = new Focused_Chunk();
		var active = new Chunk_Active();

		new echoes.Entity().add(_level,focus,active);
		var list:SystemList = new SystemList();
		
		list.add(new VelocitySystem());
		list.add(new GridPositionActualizer());
        list.add(new DelayedMovementSystem());
		
		list.add(new UIGridPositionActualizer());
		list.add(new UIPadInputSystem());
		list.add(new UIPadNavigationSystem());
		list.add(new UIButtonInteractionSystem());
		
		//Graphics
		list.add(new CameraSynchronizer());
		list.add(new LevelRenderer());
		list.add(new SquashRenderer());
		list.add(new SpriteExtensionFx());
		list.add(new SpriteRenderer(Game.ME.origin,Game.ME));
		list.add(new DebugLabelRenderer(Game.ME.origin));
		
	    list.add(new UIHelperSystem());
		list.add(new InputSystem());
		list.add(new GarbageCollectionSystem()); 

		list.activate();
		//list.clock.setFixedTickLength();
		
    }

	//////////////////////////////////////////////////
	//////////////////TOPDOWN////////////////////////



	public static function newTopDownLevel(level:Level){
		Game.ME.ui_layer.removeChildren();
	   
		var ocx = level.data.f_ci * Const.CHUNK_SIZE;
		var ocy = level.data.f_cj * Const.CHUNK_SIZE;
		//level.coordId() quesako ? 
		//trace(level.coordId(level.w));
		//trace('custom x $ocx y $ocy');
		// ECS //
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
	   
	   //var _level = new LevelComponent(level.data);
	   //var focus = new Focused_Chunk();
/* 
	   new echoes.Entity().add(_level,focus);
	   for(l in level.data.neighbours){
		 var a:World_Level = Assets.worldData.all_worlds.Default.getLevel(l.levelIid);
		 var new_l = new LevelComponent(a);
		 new echoes.Entity().add(new_l);
	   }
 */
	   var loadedLevels = new Map<String, Bool>();
	   // Load the initial level
		var _level = new LevelComponent(level.data);
		
		var focus = new Focused_Chunk();
		var active = new Chunk_Active();

		new echoes.Entity().add(_level,focus,active);

		loadedLevels.set(level.data.iid, true);
		loadNeighbours(level,loadedLevels);

	    createEchoes();
	}

	public static function loadNeighbours(level:Level, _previouslyLoaded:Map<String,Bool>) {
		for(l in level.data.neighbours){
			if (!_previouslyLoaded.exists(l.levelIid)) {
				var a:World_Level = Assets.worldData.all_worlds.Default.getLevel(l.levelIid);
				var new_l = new LevelComponent(a);
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
	   var el = new echoes.Entity();
	   el.add(_level);
	   //new echoes.Entity().add(_level);
	   for(l in level.data.neighbours){
		 var a:World_Level = Assets.worldData.all_worlds.Default.getLevel(l.levelIid);
		 var new_l = new LevelComponent(a);
		 new echoes.Entity().add(new_l);
	   } 
	   
	   createEchoes();


   }

   public static function createEchoes() {
		   //Collision
		   var list:SystemList = new SystemList();

		   list.add(new GarbageCollectionSystem());
	   
		   //Object
		   list.add(new CollisionSensorSystem());
		   list.add(new VelocitySystem());
		   list.add(new CollisionReactionEvent());
		   list.add(new GridPositionActualizer());
		   list.add(new DelayedMovementSystem());
		   list.add(new TemporarySystem());
		   
		   //Interaction
		   list.add(new CatchLogicSystem());
		   list.add(new BombLogicSystem());
		   
		   //Particles
		   list.add(new ParticulesVelocitySystem());
		   list.add(new ParticulesSystem());
		   list.add(new ParticuleRenderer());
		   
		   //Graphics
		   list.add(new CameraSynchronizer());
		   list.add(new LevelRenderer());
		   list.add(new SquashRenderer());
		   list.add(new BoundingBoxRenderer(Game.ME.origin));
		   list.add(new SpriteExtensionFx());
		   list.add(new SpriteRenderer(Game.ME.origin,Game.ME));
		   
		   //Dialog
		   list.add(new DialogAreaCollisions());
		   list.add(new DialogYarnSystem());	
		   list.add(new DialogInputSystem());
		   list.add(new DialogUISystem());
		   
			   //Helpers
		   list.add(new UIHelperSystem());
		   //Input
		   list.add(new InputSystem());
		   list.activate();
   }
}

   
