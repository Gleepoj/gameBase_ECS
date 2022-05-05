package aleiiioa.systems.core;


import aleiiioa.components.vehicule.PaddleSharedComponent;
import hxd.Pad.PadConfig;
import aleiiioa.components.vehicule.WingsSharedComponent;
import aleiiioa.components.vehicule.VeilComponent;
import aleiiioa.components.flags.vessel.*;
import aleiiioa.components.*;

import aleiiioa.components.gun.GunComponent;
import aleiiioa.components.core.position.GridPositionOffset;

import aleiiioa.systems.vehicule.GunCommand.InstancedGunCommands;
import aleiiioa.systems.modifier.ModifierCommand.InstancedCommands;


class InputSystem extends echoes.System {
    var ca : ControllerAccess<GameAction>;
    var command:InstancedCommands;
	var gunCommand:InstancedGunCommands;
	var conf:PadConfig;

    public function new() {
		ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;
		conf = ca.input.pad.config;
        command = new InstancedCommands();
		gunCommand = new InstancedGunCommands();
    }
	
	@u function inputPlayerGun(inp:InputComponent,gun:GunComponent) {
		if (!ca.isDown(Blow)){
			gun.currentCommand = gunCommand.turnOff;
			gun.currentCommand.execute(gun);	
		}

		if (ca.isDown(Blow)){	
			gun.currentCommand = gunCommand.primary;
			gun.currentCommand.execute(gun);
		}

	}
	//View to satellite to 
	@u function inputVeilGridPosition(inp:InputComponent,gop:GridPositionOffset,veil:VeilComponent) {
		gop.setXYratio(ca.getAnalogValue(MoveX)*2,ca.getAnalogValue(MoveY)*2);
	}
	
	@u function inputPlayerWings(inp:InputComponent,win:WingsSharedComponent,wms:WingsMasterFlag){
		win.ix = ca.getAnalogValue(MoveX);
		win.iy = ca.getAnalogValue(MoveY);

		win.tl = ca.input.pad.values[conf.LT];
	 	win.tr = ca.input.pad.values[conf.RT];
	
		if (!ca.isDown(Jump)){
			win.inputLock = false;
		}

		if (ca.isDown(Jump)){
			win.inputLock = true;
		}
	}

	@u function inputPlayerPaddle(inp:InputComponent,pad:PaddleSharedComponent){
		pad.ix = ca.getAnalogValue(MoveX);
		pad.iy = ca.getAnalogValue(MoveY);

		pad.tl = ca.input.pad.values[conf.LT];
	 	pad.tr = ca.input.pad.values[conf.RT];
		
		pad.rb = ca.isPressed(WingRight);
		pad.lb = ca.isPressed(WingLeft);

		if (!ca.isDown(Jump)){
			pad.inputLock = false;
		}

		if (ca.isDown(Jump)){
			pad.inputLock = true;
		}
	}
}