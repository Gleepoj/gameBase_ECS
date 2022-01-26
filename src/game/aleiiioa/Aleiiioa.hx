package aleiiioa;

import solv.Modifier;
import solv.Boids;
/**
	This small class just creates a SamplePlayer instance in current level
**/

class Aleiiioa extends Game {


	var player:SamplePlayer;
	public function new() {
		super();
	}
	
	override function startLevel(l:World_Level) {
		super.startLevel(l);
		player = new SamplePlayer();
		new Modifier(20,30);
		
		for (i in 0...25){
			for( j in 0...25){
			 var b = new Boids(5+i*2,5+ j*2);
			 b.trackEntity(player);
			}
		}

	}
}

