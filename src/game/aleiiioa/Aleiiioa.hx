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
		for (b in level.data.l_Entities.all_Boides){
			var boide = new Boids(b.cx,b.cy);
			boide.addPath(b.f_Path);
			//boide.track(player,b.f_Path);
		}

		for (i in 0...20){
			for( j in 0...30){
			new Boids(5+i*2,5+ j*2);
			 //b.trackEntity(player);
			}
		}

		/* for (i in 0...10){
			for( j in 0...30){
			 var b = new Boids(5+i*2,5+ j*2);
			}
		} */ 
 
	}
}

