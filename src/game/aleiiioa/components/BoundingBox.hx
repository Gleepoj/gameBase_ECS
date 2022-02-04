package aleiiioa.components;

class BoundingBox {
	public var invalidateDebugBounds:Bool = false;
	var debugBounds : Null<h2d.Graphics>;

	public var wid : Float = Const.GRID; // a init avec spr
	public var hei : Float = Const.GRID;

	public var attachX :Float = 0 ;
	public var attachY :Float = 0 ;

	public var pivotX :Float = 0.5; // a initialize avec sprite
	public var pivotY :Float = 1;

	//Bounding box getters//
	public var left(get,never)  : Float; inline function get_left()  return attachX + (0-pivotX) * wid;
	public var right(get,never) : Float; inline function get_right() return attachX + (1-pivotX) * wid;
	public var top(get,never)   : Float; inline function get_top()   return attachY + (0-pivotY) * hei;
	public var bottom(get,never): Float; inline function get_bottom()return attachY + (1-pivotY) * hei;
	// Bounding box center//
	public var centerX(get,never) : Float; inline function get_centerX() return attachX + (0.5-pivotX) * wid;
	public var centerY(get,never) : Float; inline function get_centerY() return attachY + (0.5-pivotY) * hei;

	public function new(ax:Float,ay:Float) {
		attachX = ax;
		attachY = ay;
	}

	
	private function renderDebugBounds() {
		var c = Color.makeColorHsl(1 / 20, 1, 1);
		debugBounds.clear();

		// Bounds rect
		debugBounds.lineStyle(1, c, 0.5);
		debugBounds.drawRect(left - attachX, top - attachY, wid, hei);

		// Attach point
		debugBounds.lineStyle(0);
		debugBounds.beginFill(c, 0.8);
		debugBounds.drawRect(-1, -1, 3, 3);
		debugBounds.endFill();

		// Center
		debugBounds.lineStyle(1, c, 0.3);
		debugBounds.drawCircle(centerX - attachX, centerY - attachY, 3);
	}

	private function disableDebugBounds() {
		if (debugBounds != null) {
			debugBounds.remove();
			debugBounds = null;
		}
	}

	private function enableDebugBounds() {
		if (debugBounds == null) {
			debugBounds = new h2d.Graphics();
			//game.scroller.add(debugBounds, Const.DP_TOP);
		}
		invalidateDebugBounds = true;
	}
	
	private function renderAllDebugs() {

		// Debug bounds
		if (debugBounds != null) {
			if (invalidateDebugBounds) {
				invalidateDebugBounds = false;
				renderDebugBounds();
			}
			debugBounds.x = Std.int(attachX);
			debugBounds.y = Std.int(attachY);
		}
	}

	public function debugRequest() {
		#if debug
		// Show bounds (with `/bounds` in console)
		if (ui.Console.ME.hasFlag("bounds") && debugBounds == null)
			enableDebugBounds();

		// Hide bounds
		if (!ui.Console.ME.hasFlag("bounds") && debugBounds != null)
			disableDebugBounds();
		#end
	}
}