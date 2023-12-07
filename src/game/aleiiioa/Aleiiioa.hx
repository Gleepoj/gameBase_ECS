package aleiiioa;

import aleiiioa.builders.worlds.WorkflowBuilders;
import echoes.SystemList;
import echoes.Entity;
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

import echoes.Workflow;

class Aleiiioa extends Game {

	var game(get,never) : Game; inline function get_game() return Game.ME;
	public static var ME : Aleiiioa;

	public function new() {
		super();
		
		ME = this;
		Workflow.reset();
		
		//startPlay();
		goToMenu();
	}

	public function startPlay(){
		Workflow.reset();
	
		game.loadLevel(Assets.worldData.all_worlds.Default.all_levels.Level_1);
		WorkflowBuilders.newLevel(level);
	}

	public function goToSetting(){
		//trace("go to setting");
		//Workflow.reset();
		//game.loadLevel(Assets.worldData.all_worlds.Default.all_levels.Settings);
		//WorkflowBuilders.newMainMenu(level);
	}

	public function goToMenu(){
		game.loadLevel(Assets.worldData.all_worlds.Default.all_levels.Level_0);
		WorkflowBuilders.newMenu(level);
		//trace("go to menu");
		//Workflow.reset();
		//game.loadLevel(Assets.worldData.all_worlds.Default.all_levels.Main_Menu);
		//WorkflowBuilders.newMainMenu(level);
	}


	override function fixedUpdate() {
		super.fixedUpdate();
		Workflow.update(Const.FIXED_DELTA);
	}

	override function postUpdate() {
		super.postUpdate();
		Workflow.postUpdate(tmod);
	}

	override function onDispose() {
		super.onDispose();
		Workflow.reset();
	}

}
	

