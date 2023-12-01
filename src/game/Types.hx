/**	This enum is used by the Controller class to bind general game actions to actual keyboard keys or gamepad buttons. **/
enum abstract GameAction(Int) to Int {
	var MoveLeft;
	var MoveRight;
	var MoveUp;
	var MoveDown;

	var TriggerLeft;
	var TriggerRight;
	
	var Rb;
	var Lb;
	
	var ActionX;
	var ActionY;
	var Jump;
	var Interaction;

	var Pause;
	var Restart;

	var DebugTurbo;
	var DebugSlowMo;
	var ScreenshotMode;

	var MenuCancel;
}

enum Affect {
	Stun;
}

enum AreaEquation {
	EqCurl;
	EqDiverge;
	EqConverge;
	EqRepel;
}

enum AreaInfluence {
	AiSmall;
	AiMedium;
	AiLarge;
}

enum  UI_Button_Event {

	GameState_Play;
	GameState_Save;
	GameState_Load;
	GameState_Settings;
	GameState_Quit;
	GameState_Menu;
	Order_Next;
	Order_Previous;
	Order_Undefined;
	
}

enum abstract LevelMark(Int) to Int {
	var Coll_Wall;
}
	

enum abstract LevelSubMark(Int) to Int {
	var None; // 0
}