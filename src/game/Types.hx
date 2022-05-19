/**	This enum is used by the Controller class to bind general game actions to actual keyboard keys or gamepad buttons. **/
enum abstract GameAction(Int) to Int {
	var MoveLeft;
	var MoveRight;
	var MoveUp;
	var MoveDown;


	var WingLeft;
	var WingRight;
	
	var Rb;
	var Lb;
	
	var Jump;
	var Restart;
	var Blow;
	var ShapeWind;
	
	var MenuCancel;
	var Pause;

	var DebugTurbo;
	var DebugSlowMo;
	var ScreenshotMode;
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

enum LevelMark {
}