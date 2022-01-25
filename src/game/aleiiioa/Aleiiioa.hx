package aleiiioa;

import solv.Modifier;
import solv.Boids;
/**
	This small class just creates a SamplePlayer instance in current level
**/

class Aleiiioa extends Game {



	public function new() {
		super();
	}
	
	override function startLevel(l:World_Level) {
		super.startLevel(l);
		new SamplePlayer();
		new Modifier(20,30);
		
		for (i in 0...25){
			for( j in 0...25){
			new Boids(5+i*2,5+ j*2);
			}
		}

	}
}

