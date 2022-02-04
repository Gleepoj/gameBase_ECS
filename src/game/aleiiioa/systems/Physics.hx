package aleiiioa.systems;

import aleiiioa.components.PixelPosition;


class Physics extends echoes.System {
	

	public function new() {
	
	}

	@u inline function updatePosition(pos:PixelPosition) {
		pos.x = pos.x-10;
		pos.y = pos.y-10;//(2*Math.random());
	  }
}
