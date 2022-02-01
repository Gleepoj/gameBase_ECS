package aleiiioa;

import solv.Modifier;
import comp.Boids;
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
		new Ship(20,30,player);
		
		 for (b in level.data.l_Entities.all_Boides){
			var boide = new Boids(b.cx,b.cy);
			boide.track(player,b.f_Path);
			boide.pathPriority = true;
		}
 
/* 		for (i in 0...20){
			for( j in 0...30){
			new Boids(5+i*2,5+ j*2);
			}
		} */
 
	}
}

