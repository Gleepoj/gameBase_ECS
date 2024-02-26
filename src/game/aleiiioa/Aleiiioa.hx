package aleiiioa;

import aleiiioa.builders.worlds.EchoesBuilders;
import echoes.Echoes;

class Aleiiioa extends Game {

	var game(get,never) : Game; inline function get_game() return Game.ME;
	public static var ME : Aleiiioa;

	public function new() {
		super();
		
		ME = this;
		Echoes.reset();
		#if( hl && !debug )
        goToMenu();
		#else
		//goToMenu();
		//goToSetting();
		startPlay();
        #end
	}

	public function startPlay(){
		Echoes.reset();
		game.loadLevel(Assets.worldData.all_worlds.Default.all_levels.Hero_home);
		//EchoesBuilders.newPlateformerLevel(level);
		EchoesBuilders.newTopDownLevel(level);
	}

	public function goToSetting(){
		Echoes.reset();
		game.loadLevel(Assets.worldData.all_worlds.Default.all_levels.Setting);
		EchoesBuilders.newMenu(level);
	}

	public function goToMenu(){
		game.loadLevel(Assets.worldData.all_worlds.Default.all_levels.Menu);
		EchoesBuilders.newMenu(level);
	}

	override function fixedUpdate() {
		super.fixedUpdate();
		
	}

	override function postUpdate() {
		super.postUpdate();
		//Echoes.postUpdate(tmod);
		Echoes.update();
	}

	override function onDispose() {
		super.onDispose();
		Echoes.reset();
	}

}
	

