package aleiiioa.systems.core;

import echoes.Workflow;
import aleiiioa.components.core.VelocityAnalogSpeed;
import aleiiioa.systems.solver.modifier.ModifierCommand.InstancedCommands;
import aleiiioa.components.*;
import aleiiioa.components.solver.ModifierComponent;

class InputSystem extends echoes.System {
    var ca : ControllerAccess<GameAction>;
    var command:InstancedCommands;

    public function new() {
		ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;
        command = new InstancedCommands();
    }

    @u function inputPlayerControlledModifier(inp:InputComponent,mod:ModifierComponent) {
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
			mod.currentOrder = command.diverge;
		}

		if (ca.isDown(ShapeWind)){
			mod.currentOrder = command.curl;
		}

		if (ca.isDown(Jump)){
			mod.currentOrder = command.repel;
			trace(Workflow.entities.length);
		}
    }

    @u function inputPlayerControlledShip(vas:VelocityAnalogSpeed,inp:InputComponent){
        if ( ca.getAnalogDist(MoveY)>0){
			vas.ySpeed = ca.getAnalogValue(MoveY); 
		}
		if( ca.getAnalogDist(MoveX)>0 ) {
			vas.xSpeed = ca.getAnalogValue(MoveX); // -1 to 1
		}

    }
}