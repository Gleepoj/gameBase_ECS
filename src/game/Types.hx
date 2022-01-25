/**	This enum is used by the Controller class to bind general game actions to actual keyboard keys or gamepad buttons. **/
enum GameAction {
	MoveX;
	MoveY;

	Jump;
	Restart;
	Blow;
	ShapeWind;
	
	MenuCancel;
	Pause;

	DebugTurbo;
	DebugSlowMo;
	ScreenshotMode;
}

enum Affect {
	Stun;
}

enum AreaEquation {
	EqCurl;
	EqDiverge;
	EqConverge;
}

enum AreaInfluence {
	AiSmall;
	AiMedium;
	AiLarge;
}

enum LevelMark {
}