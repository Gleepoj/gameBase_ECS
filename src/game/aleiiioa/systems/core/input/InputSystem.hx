package aleiiioa.systems.core.input;


import aleiiioa.components.core.collision.CollisionsListener;
import aleiiioa.components.core.physics.VelocityAnalogSpeed;
import aleiiioa.components.core.physics.VelocityComponent;
import hxd.Pad.PadConfig;
import aleiiioa.components.core.input.InputComponent;

import aleiiioa.components.core.position.GridPositionOffset;



class InputSystem extends echoes.System {
 
    public function new() {
	}

	@u function updatePlayer(inp:InputComponent,vas:VelocityAnalogSpeed,cl:CollisionsListener){
	
		if(inp.ca.isDown(MoveRight)){
			vas.xSpeed = 0.3;
		}
		if(inp.ca.isDown(MoveLeft)){
			vas.xSpeed = -0.3;
		}
		if(inp.ca.isPressed(Jump) && cl.cd.has("recentlyOnGround")){
			vas.ySpeed = -0.9;
			cl.cd.unset("recentlyOnGround");
		}

		if(inp.ca.isDown(MoveUp)){
			//vas.ySpeed = -0.3;
		}
	}
}