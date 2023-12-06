package aleiiioa.systems.local.ui.selector;


import aleiiioa.components.local.ui.UISelectorFlag;
import aleiiioa.components.local.ui.On_UIPadMove;
import aleiiioa.components.core.input.InputComponent;



class SelectorControlSystem extends echoes.System {


	@u function playerReceiveInput(en:echoes.Entity, inp:InputComponent, s:UISelectorFlag) {
		var pdx = 0;
		var pdy = 0;

		if (inp.ca.isPressed(MoveRight) || inp.isPressedRightAnalog) {
			pdx += 1;
			inp.ca.lock(0.06);
		}
		if (inp.ca.isPressed(MoveLeft) || inp.isPressedLeftAnalog) {
			pdx -= 1;
			inp.ca.lock(0.06);
		}

		if (inp.ca.isPressed(MoveDown) || inp.isPressedDownAnalog) {
			pdy += 1;
			inp.ca.lock(0.06);
		}

		if (inp.ca.isPressed(MoveUp) || inp.isPressedUpAnalog) {
			pdy -= 1;
			inp.ca.lock(0.06);
		}

		if (pdx != 0 || pdy != 0){
			en.add(new On_UIPadMove(pdx, pdy));
		}

	}
	
}