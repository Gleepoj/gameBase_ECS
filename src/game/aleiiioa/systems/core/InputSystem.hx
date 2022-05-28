package aleiiioa.systems.core;


import hxd.Pad.PadConfig;
import aleiiioa.components.*;

import aleiiioa.components.core.position.GridPositionOffset;



class InputSystem extends echoes.System {
    var ca : ControllerAccess<GameAction>;
    //var command:InstancedCommands;
	var conf:PadConfig;

    public function new() {
		ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;
		conf = ca.input.pad.config;
       // command = new InstancedCommands();
    
		/* pad.ix = ca.input.pad.values[conf.analogX];
		pad.iy = ca.input.pad.values[conf.analogX];

		pad.ltAnalog = ca.input.pad.values[conf.LT];
	 	pad.rtAnalog = ca.input.pad.values[conf.RT];
		
		pad.rb = ca.isPressed(WingRight);
		pad.lb = ca.isPressed(WingLeft);

		pad.xb = ca.isDown(Jump);
		pad.bb = ca.isDown(Blow);
 */
	}
}