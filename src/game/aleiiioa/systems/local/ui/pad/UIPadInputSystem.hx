package aleiiioa.systems.local.ui.pad;


import aleiiioa.components.local.ui.UISelectorFlag;
import aleiiioa.components.local.ui.signal.UISignalArrowMove;
import aleiiioa.components.core.input.InputComponent;



class UIPadInputSystem extends echoes.System {

	@:u function UIPadJoystickToBool(dt:Float,inp:InputComponent){
        inp.cd.update(dt);

        //for UI Nevigation;
        inp.joy_down_ratio  = inp.ca.getHoldRatio(MoveDown,0.06);
        inp.joy_up_ratio    = inp.ca.getHoldRatio(MoveUp,0.06);
        inp.joy_right_ratio = inp.ca.getHoldRatio(MoveRight,0.06);
        inp.joy_left_ratio  = inp.ca.getHoldRatio(MoveLeft,0.06);

    }

	@:u function SelectorReceiveInput(en:echoes.Entity, inp:InputComponent, s:UISelectorFlag) {
		var pdx = 0;
		var pdy = 0;
		
		if (inp.ca.isPressed(MoveRight) || inp.isPressedRightAnalog) {
			pdx += 1;
		}
		if (inp.ca.isPressed(MoveLeft) || inp.isPressedLeftAnalog) {
			pdx -= 1;
		}
		if (inp.ca.isPressed(MoveDown) || inp.isPressedDownAnalog) {
			pdy += 1;
		}
		if (inp.ca.isPressed(MoveUp) || inp.isPressedUpAnalog) {
			pdy -= 1;
		}
	
		if (pdx != 0 || pdy != 0){
			inp.ca.lock(0.06);
			en.add(new UISignalArrowMove(pdx, pdy));
		}
	}
	
}