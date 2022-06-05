package aleiiioa.systems.core;


import aleiiioa.components.core.velocity.VelocityAnalogSpeed;
import aleiiioa.components.core.velocity.VelocityComponent;
import hxd.Pad.PadConfig;
import aleiiioa.components.*;

import aleiiioa.components.core.position.GridPositionOffset;



class InputSystem extends echoes.System {
 
    public function new() {
	}

	@u function updatePlayer(inp:InputComponent,vas:VelocityAnalogSpeed){
		vas.xSpeed = 0;
		vas.ySpeed = 0;
		if(inp.ca.isDown(MoveRight)){
			vas.xSpeed = 0.3;
		}
		if(inp.ca.isDown(MoveLeft)){
			vas.xSpeed = -0.3;
		}
		if(inp.ca.isDown(MoveDown)){
			vas.ySpeed = 0.3;
		}
		if(inp.ca.isDown(MoveUp)){
			vas.ySpeed = -0.3;
		}
	}
}