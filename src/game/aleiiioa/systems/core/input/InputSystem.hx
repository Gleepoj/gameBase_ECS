package aleiiioa.systems.core.input;


import aleiiioa.components.core.physics.collision.affects.GravitySensitiveAffects;
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
/* 	@u function updateCameraCenter(inp:InputComponent,vas:AnalogSpeedComponent,gp:GridPosition,gr:GravitySensitiveAffects){
		//inp.ca.isKeyboardDown()

	} */

	@u function updateTopDown(inp:InputComponent,vas:AnalogSpeedComponent,cl:CollisionSensor,gp:GridPosition){
		
		var speed = 0.6;

		
		var ratio = 1;

		if(inp.ca.isDown(MoveRight)){
			vas.xSpeed = speed*ratio;
		}
		
		if(inp.ca.isDown(MoveLeft)){
			vas.xSpeed = -speed*ratio;
		}

		if(inp.ca.isDown(MoveDown)){
			vas.ySpeed = speed*ratio;
		}
		
		if(inp.ca.isDown(MoveUp)){
			vas.ySpeed = -speed*ratio;
		}
	

	}

	@u function updatePlateformer(inp:InputComponent,vas:AnalogSpeedComponent,cl:CollisionSensor,gp:GridPosition,gr:GravitySensitiveAffects){
		
		var speed = 0.6;

		
		var ratio = 1;

		if(inp.ca.isDown(MoveRight)){
			vas.xSpeed = speed*ratio;
		}
		
		if(inp.ca.isDown(MoveLeft)){
			vas.xSpeed = -speed*ratio;
		}
		if(inp.ca.isPressed(ActionX) && cl.recentlyOnGround){
			vas.ySpeed = -4.8;
			//trace("jump");
			
		} 
	}
}