package comp;

class EntityRenderer {
    
    var game(get,never) : Game; inline function get_game() return Game.ME;
    
    var en:Entity;

    /** If TRUE, the sprite display coordinlates will be an interpolation between the last known position and the current one. This is useful if the gameplay happens in the `fixedUpdate()` (so at 30 FPS), but you still want the sprite position to move smoothly at 60 FPS or more. **/
	var interpolateSprPos = true;

    var sprX(get,never) : Float;
		inline function get_sprX() {
			return interpolateSprPos
				? M.lerp( en.lastFixedUpdateX, (en.cx+en.xr)*Const.GRID, game.getFixedUpdateAccuRatio() )
				: (en.cx+en.xr)*Const.GRID;
		}

	/** Current sprite Y **/
	var sprY(get,never) : Float;
		inline function get_sprY() {
			return interpolateSprPos
				? M.lerp( en.lastFixedUpdateY, (en.cy+en.yr)*Const.GRID, game.getFixedUpdateAccuRatio() )
				: (en.cy+en.yr)*Const.GRID;
		}

	var sprScaleX = 1.0;
	var sprScaleY = 1.0;

    var sprSquashX = 1.0;
	var sprSquashY = 1.0;

    
	var shakePowX = 0.;
	var shakePowY = 0.;
	
	/** Color matrix transformation applied to sprite **/
	var colorMatrix : h3d.Matrix;   
	var baseColor : h3d.Vector;
	var blinkColor : h3d.Vector;
    
	// Debug stuff
	var debugLabel : Null<h2d.Text>;
	var debugBounds : Null<h2d.Graphics>;
	

    //Position on screen (ie. absolute)//
	var screenAttachX(get,never) : Float;
    inline function get_screenAttachX() return game!=null && !game.destroyed ? sprX*Const.SCALE + game.scroller.x : sprX*Const.SCALE;

    var screenAttachY(get,never) : Float;
    inline function get_screenAttachY() return game!=null && !game.destroyed ? sprY*Const.SCALE + game.scroller.y : sprY*Const.SCALE;
    

    public var invalidateDebugBounds = false;
	public var entityVisible = true;
    public var spr : HSprite;

    public function new(e:Entity) {
        en = e;

        spr = new HSprite(Assets.tiles);
		Game.ME.scroller.add(spr, Const.DP_MAIN);
		spr.colorAdd = new h3d.Vector();
		baseColor = new h3d.Vector();
		blinkColor = new h3d.Vector();
		spr.colorMatrix = colorMatrix = h3d.Matrix.I();
		spr.setCenterRatio(en.pivotX, en.pivotY);

		if( ui.Console.ME.hasFlag("bounds") )
			enableDebugBounds();
    }
	
	public function blink(c:UInt) {
		blinkColor.setColor(c);
		en.cd.setS("keepBlink", 0.06);
	}

	/** Briefly squash sprite on X (Y changes accordingly). "1.0" means no distorsion. **/
	public function setSquashX(scaleX:Float) {
		sprSquashX = scaleX;
		sprSquashY = 2 - scaleX;
	}

	public function setSquashY(scaleY:Float) {
		sprSquashX = 2 - scaleY;
		sprSquashY = scaleY;
	}

	public function renderSprite(tmod:Float) {
		spr.x = sprX;
		spr.y = sprY;
		spr.scaleX = en.dir * sprScaleX * sprSquashX;
		spr.scaleY = sprScaleY * sprSquashY;
		spr.visible = entityVisible;

		sprSquashX += (1 - sprSquashX) * M.fmin(1, 0.2 * tmod);
		sprSquashY += (1 - sprSquashY) * M.fmin(1, 0.2 * tmod);

		if (en.cd.has("shaking")) {
			spr.x += Math.cos(en.ftime * 1.1) * shakePowX * en.cd.getRatio("shaking");
			spr.y += Math.sin(0.3 + en.ftime * 1.7) * shakePowY * en.cd.getRatio("shaking");
		}

		// Blink
		if (!en.cd.has("keepBlink")) {
			blinkColor.r *= Math.pow(0.60, tmod);
			blinkColor.g *= Math.pow(0.55, tmod);
			blinkColor.b *= Math.pow(0.50, tmod);
		}

		// Color adds
		spr.colorAdd.load(baseColor);
		spr.colorAdd.r += blinkColor.r;
		spr.colorAdd.g += blinkColor.g;
		spr.colorAdd.b += blinkColor.b;

		renderAllDebugs();
	}

	public inline function debugFloat(v:Float, ?c = 0xffffff) {
		debug(en.pretty(v), c);
	}

	/** Print some value below entity **/
	public inline function debug(?v:Dynamic, ?c = 0xffffff) {
		#if debug
		if (v == null && debugLabel != null) {
			debugLabel.remove();
			debugLabel = null;
		}
		if (v != null) {
			if (debugLabel == null) {
				debugLabel = new h2d.Text(Assets.fontPixel, Game.ME.scroller);
				debugLabel.filter = new dn.heaps.filter.PixelOutline();
			}
			debugLabel.text = Std.string(v);
			debugLabel.textColor = c;
		}
		#end
	}

    public function dispose() {
		baseColor = null;
		blinkColor = null;
		colorMatrix = null;

		spr.remove();
		spr = null;

		if (debugLabel != null) {
			debugLabel.remove();
			debugLabel = null;
		}

		if (debugBounds != null) {
			debugBounds.remove();
			debugBounds = null;
		}
	}


	private function renderAllDebugs() {
		// Debug label
		if (debugLabel != null) {
			debugLabel.x = Std.int(en.attachX - debugLabel.textWidth * 0.5);
			debugLabel.y = Std.int(en.attachY + 1);
		}

		// Debug bounds
		if (debugBounds != null) {
			if (invalidateDebugBounds) {
				invalidateDebugBounds = false;
				renderDebugBounds();
			}
			debugBounds.x = Std.int(en.attachX);
			debugBounds.y = Std.int(en.attachY);
		}
	}

	public function debugRequest() {
		#if debug
		// Display the list of active "affects" (with `/set affect` in console)
		if (ui.Console.ME.hasFlag("affect")) {
			var all = [];
			for (k in en.affects.keys())
				all.push(k + "=>" + M.pretty(en.getAffectDurationS(k), 1));
			debug(all);
		}

		// Show bounds (with `/bounds` in console)
		if (ui.Console.ME.hasFlag("bounds") && debugBounds == null)
			enableDebugBounds();

		// Hide bounds
		if (!ui.Console.ME.hasFlag("bounds") && debugBounds != null)
			disableDebugBounds();
		#end
	}

	private function renderDebugBounds() {
		var c = Color.makeColorHsl((en.uid % 20) / 20, 1, 1);
		debugBounds.clear();

		// Bounds rect
		debugBounds.lineStyle(1, c, 0.5);
		debugBounds.drawRect(en.left - en.attachX, en.top - en.attachY, en.wid, en.hei);

		// Attach point
		debugBounds.lineStyle(0);
		debugBounds.beginFill(c, 0.8);
		debugBounds.drawRect(-1, -1, 3, 3);
		debugBounds.endFill();

		// Center
		debugBounds.lineStyle(1, c, 0.3);
		debugBounds.drawCircle(en.centerX - en.attachX, en.centerY - en.attachY, 3);
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
			game.scroller.add(debugBounds, Const.DP_TOP);
		}
		invalidateDebugBounds = true;
	}


            /** Print some numeric value below entity **/
	


}