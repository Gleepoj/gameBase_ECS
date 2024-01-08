package aleiiioa;

import aleiiioa.builders.worlds.WorkflowBuilders;
import echoes.Workflow;

class Aleiiioa extends Game {

	var game(get,never) : Game; inline function get_game() return Game.ME;
	public static var ME : Aleiiioa;

	public function new() {
		super();
		
		ME = this;
		Workflow.reset();
		#if( hl && !debug )
        goToMenu();
		#else
		startPlay();
        #end
		

	}

	public function startPlay(){
		Workflow.reset();
		game.loadLevel(Assets.worldData.all_worlds.Default.all_levels.Hero_home);
		WorkflowBuilders.newPlateformerLevel(level);
		//WorkflowBuilders.newTopDownLevel(level);
	}

	public function goToSetting(){
		Workflow.reset();
		game.loadLevel(Assets.worldData.all_worlds.Default.all_levels.Setting);
		WorkflowBuilders.newMenu(level);
	}

	public function goToMenu(){
		game.loadLevel(Assets.worldData.all_worlds.Default.all_levels.Menu);
		WorkflowBuilders.newMenu(level);
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
	

