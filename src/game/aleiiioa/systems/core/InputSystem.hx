package aleiiioa.systems.core;


import aleiiioa.components.vehicule.WingsSharedComponent;
import aleiiioa.components.vehicule.VeilComponent;
import aleiiioa.components.flags.vessel.*;
import aleiiioa.components.*;

import aleiiioa.components.gun.GunComponent;
import aleiiioa.components.core.position.GridPositionOffset;

import aleiiioa.systems.vehicule.GunCommand.InstancedGunCommands;
import aleiiioa.systems.solver.modifier.ModifierCommand.InstancedCommands;


class InputSystem extends echoes.System {
    var ca : ControllerAccess<GameAction>;
    var command:InstancedCommands;
	var gunCommand:InstancedGunCommands;

    public function new() {
		ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;
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
	//View to satellite to securize// 
	@u function inputVeilGridPosition(inp:InputComponent,gop:GridPositionOffset,veil:VeilComponent) {
		gop.setXYratio(ca.getAnalogValue(MoveX)*2,ca.getAnalogValue(MoveY)*2);
	}
	
	@u function inputPlayerWings(inp:InputComponent,win:WingsSharedComponent,wms:WingsMasterFlag){
		win.ix = ca.getAnalogValue(MoveX);
		win.iy = ca.getAnalogValue(MoveY);
	
		if (!ca.isDown(Jump)){
			win.inputLock = false;
		}

		if (ca.isDown(Jump)){
			win.inputLock = true;
		}
	}
}