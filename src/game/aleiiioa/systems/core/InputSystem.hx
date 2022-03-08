package aleiiioa.systems.core;

import aleiiioa.components.flags.WingsMasterFlag;
import aleiiioa.components.vehicule.WingsComponent;
import aleiiioa.components.vehicule.VeilComponent;
import aleiiioa.components.flags.VeilFlag;
import aleiiioa.components.*;
import aleiiioa.components.core.VelocityAnalogSpeed;

import aleiiioa.components.solver.ModifierComponent;
import aleiiioa.components.vehicule.GunComponent;
import aleiiioa.components.core.GridPositionOffset;

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

    @u function inputPlayerControlledModifier(inp:InputComponent,mod:ModifierComponent,gun:GunComponent) {
        if (!ca.isDown(Blow)){
			mod.currentOrder = command.turnOff;	
		}

		if (!ca.isDown(ShapeWind)){
			mod.currentOrder = command.turnOff;
		}
		if (!ca.isDown(Jump)){
			mod.currentOrder = command.turnOff;
		}

		if (ca.isDown(Blow)){	
			//mod.currentOrder = command.diverge;
			
		}

		if (ca.isDown(ShapeWind)){
			mod.currentOrder = command.curl;
		}

		if (ca.isDown(Jump)){
			mod.currentOrder = command.repel;
			//trace(Workflow.entities.length);
		}
    }
	//View to satellite to securize// 
	@u function inputVeilGridPosition(inp:InputComponent,gop:GridPositionOffset,veil:VeilComponent) {
		gop.setXYratio(ca.getAnalogValue(MoveX)*2,ca.getAnalogValue(MoveY)*2);
	}
	
    @u function inputPlayerControlledShip(vas:VelocityAnalogSpeed,inp:InputComponent){
        if ( ca.getAnalogDist(MoveY)>0){
			//vas.ySpeed = ca.getAnalogValue(MoveY)*0.2; 
		}
		if( ca.getAnalogDist(MoveX)>0 ) {
			//vas.xSpeed = ca.getAnalogValue(MoveX)*0.2; // -1 to 1
		}

    }

	@u function inputPlayerWings(inp:InputComponent,win:WingsComponent,wms:WingsMasterFlag){
		win.inputY = ca.getAnalogValue(MoveY);
		win.inputX = ca.getAnalogValue(MoveX);

		if (!ca.isDown(Jump)){
			win.inputLock = false;
		}

		if (ca.isDown(Jump)){
			win.inputLock = true;
		}
	}
}