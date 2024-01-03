package aleiiioa.systems.core.input;


import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.core.physics.collision.CollisionSensor;
import aleiiioa.components.core.physics.velocity.AnalogSpeedComponent;

import aleiiioa.components.core.input.InputComponent;

class InputSystem extends echoes.System {
 
    public function new() {
	}

	@u function updateCooldown(dt:Float,inp:InputComponent){
        inp.cd.update(dt);

        //for UI Nevigation;
        inp.joy_down_ratio  = inp.ca.getHoldRatio(MoveDown,0.06);
        inp.joy_up_ratio    = inp.ca.getHoldRatio(MoveUp,0.06);
        inp.joy_right_ratio = inp.ca.getHoldRatio(MoveRight,0.06);
        inp.joy_left_ratio  = inp.ca.getHoldRatio(MoveLeft,0.06);

    }

	@u function updatePlayer(inp:InputComponent,vas:AnalogSpeedComponent,cl:CollisionSensor,gp:GridPosition){
		
		
		var tl = inp.ca.input.pad.values[inp.conf.LT];
		var ratio = 1+tl;

		if(inp.ca.isDown(MoveRight)){
			vas.xSpeed = 0.3*ratio;
		}
		
		if(inp.ca.isDown(MoveLeft)){
			vas.xSpeed = -0.3*ratio;
		}

		if(inp.ca.isDown(MoveDown)){
			vas.ySpeed = 0.3*ratio;
		}
		
		if(inp.ca.isDown(MoveUp)){
			vas.ySpeed = -0.3*ratio;
		}
		if(inp.ca.isPressed(ActionX)){
			//trace(''+gp.cx+':::'+ gp.cy+'');
			//trace(''+gp.attachX+':::'+ gp.attachY+'');
			//trace(''+Game.ME.origin.x+':::'+Game.ME.origin.y);
		}
/* 
		if(inp.ca.isPressed(Jump) && cl.cd.has("recentlyOnGround")){
			vas.ySpeed = -0.9;
			cl.cd.unset("recentlyOnGround");
		} */

		if(inp.ca.isDown(MoveUp)){
			//vas.ySpeed = -0.3;
		}
	}
}