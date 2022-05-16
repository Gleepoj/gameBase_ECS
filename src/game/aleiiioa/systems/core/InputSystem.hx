package aleiiioa.systems.core;


import aleiiioa.components.vehicule.PaddleSharedComponent;
import hxd.Pad.PadConfig;
import aleiiioa.components.vehicule.VeilComponent;
import aleiiioa.components.flags.vessel.*;
import aleiiioa.components.*;

import aleiiioa.components.core.position.GridPositionOffset;

import aleiiioa.systems.modifier.ModifierCommand.InstancedCommands;


class InputSystem extends echoes.System {
    var ca : ControllerAccess<GameAction>;
    var command:InstancedCommands;
	var conf:PadConfig;

    public function new() {
		ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;
		conf = ca.input.pad.config;
        command = new InstancedCommands();
    }

	//View to satellite to 
	@u function inputVeilGridPosition(inp:InputComponent,gop:GridPositionOffset,veil:VeilComponent) {
		gop.setXYratio(ca.getAnalogValue(MoveX)*2,ca.getAnalogValue(MoveY)*2);
	}
	
	@u function inputPlayerPaddle(inp:InputComponent,pad:PaddleSharedComponent){
		
		pad.ix = ca.getAnalogValue(MoveX);
		pad.iy = ca.getAnalogValue(MoveY);

		pad.ltAnalog = ca.input.pad.values[conf.LT];
	 	pad.rtAnalog = ca.input.pad.values[conf.RT];
		
		pad.rb = ca.isPressed(WingRight);
		pad.lb = ca.isPressed(WingLeft);

		pad.xb = ca.isDown(Jump);
		pad.bb = ca.isDown(Blow);

	}
}