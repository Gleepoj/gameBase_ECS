import garbage.comp.EntityRenderer;

class Entity {

	// Various getters to access all important stuff easily
	public var app(get,never) : App; inline function get_app() return App.ME;
	public var game(get,never) : Game; inline function get_game() return Game.ME;
	public var fx(get,never) : Fx; inline function get_fx() return Game.ME.fx;
	public var level(get,never) : Level; inline function get_level() return Game.ME.level;
	public var destroyed(default,null) = false;
	public var ftime(get,never) : Float; inline function get_ftime() return game.ftime;
	public var camera(get,never) : Camera; inline function get_camera() return game.camera;

	var tmod(get,never) : Float; inline function get_tmod() return Game.ME.tmod;
	var utmod(get,never) : Float; inline function get_utmod() return Game.ME.utmod;
	public var hud(get,never) : ui.Hud; inline function get_hud() return Game.ME.hud;

	/** Cooldowns **/
	public var cd : dn.Cooldown;

	/** Cooldowns, unaffected by slowmo (ie. always in realtime) **/
	public var ucd : dn.Cooldown;

	/** Horizontal direction, can only be -1 or 1 **/
	public var dir(default,set) = 1;
	
	public var pivotX(default,set) : Float = 0.5;
	public var pivotY(default,set) : Float = 1;

	// Various coordinates getters, for easier gameplay coding

	var rendering:EntityRenderer;

    public function new(x:Int, y:Int) {

		cd = new dn.Cooldown(Const.FPS);
		ucd = new dn.Cooldown(Const.FPS);


		rendering = new EntityRenderer(this);

    }

	function set_pivotX(v) {
		pivotX = M.fclamp(v,0,1);
		if( rendering.spr!=null )
			rendering.spr.setCenterRatio(pivotX, pivotY);
		return pivotX;
	}

	function set_pivotY(v) {
		pivotY = M.fclamp(v,0,1);
		if( rendering.spr!=null )
			rendering.spr.setCenterRatio(pivotX, pivotY);
		return pivotY;
	}
	
	inline function set_dir(v) {
		return dir = v>0 ? 1 : v<0 ? -1 : dir;
	}


	/** Quickly set X/Y pivots. If Y is omitted, it will be equal to X. **/
	public function setPivots(x:Float, ?y:Float) {
		pivotX = x;
		pivotY = y!=null ? y : x;
	}

	/** Return TRUE if the Entity *center point* is in screen bounds (default padding is +32px) **/
	public inline function isOnScreenCenter(padding=32) {
		//return camera.isOnScreen( centerX, centerY, padding + M.fmax(wid*0.5, hei*0.5) );
	}

	/** Return TRUE if the Entity rectangle is in screen bounds (default padding is +32px) **/
	public inline function isOnScreenBounds(padding=32) {
		//return camera.isOnScreenRect( left,top, wid, hei, padding );
	}

	public function is<T:Entity>(c:Class<T>) return Std.isOfType(this, c);
	public function as<T:Entity>(c:Class<T>) : T return Std.downcast(this, c);

	/** Return a random Float value in range [min,max]. If `sign` is TRUE, returned value might be multiplied by -1 randomly. **/
	public inline function rnd(min,max,?sign) return Lib.rnd(min,max,sign);
	/** Return a random Integer value in range [min,max]. If `sign` is TRUE, returned value might be multiplied by -1 randomly. **/
	public inline function irnd(min,max,?sign) return Lib.irnd(min,max,sign);

	/** Truncate a float value using given `precision` **/
	public inline function pretty(value:Float,?precision=1) return M.pretty(value,precision);

	//public inline function dirTo(e:Entity) return e.centerX<centerX ? -1 : 1;
	public inline function dirToAng() return dir==1 ? 0. : M.PI;
	//public inline function getMoveAng() return Math.atan2(dyTotal,dxTotal);

	/** Return a distance (in grid cells) from this to something **/
	public inline function distCase(?e:Entity, ?tcx:Int, ?tcy:Int, ?txr=0.5, ?tyr=0.5) {
		//if( e!=null )
			//return M.dist(cx+xr, cy+yr, e.cx+e.xr, e.cy+e.yr);
		//else
			//return M.dist(cx+xr, cy+yr, tcx+txr, tcy+tyr);
	}

	/** Return a distance (in pixels) from this to something **/
	public inline function distPx(?e:Entity, ?x:Float, ?y:Float) {
		//if( e!=null )
			//return M.dist(attachX, attachY, e.attachX, e.attachY);
		//else
			//return return M.dist(attachX, attachY, x, y);
	}

	function canSeeThrough(cx:Int, cy:Int) {
		//return !level.hasCollision(cx,cy) || this.cx==cx && this.cy==cy;
	}

	/** Check if the grid-based line between this and given target isn't blocked by some obstacle **/
	public inline function sightCheck(?e:Entity, ?tcx:Int, ?tcy:Int) {
		//if( e!=this )
			//return dn.Bresenham.checkThinLine(cx, cy, e.cx, e.cy, canSeeThrough);
		//else
			//return dn.Bresenham.checkThinLine(cx, cy, tcx, tcy, canSeeThrough);
	}

	/** Create a LPoint instance from current coordinates **/
	//public inline function createPoint() return LPoint.fromCase(cx+xr,cy+yr);

	/** Create a LRect instance from current entity bounds **/
	//public inline function createRect() return tools.LRect.fromPixels( Std.int(left), Std.int(top), Std.int(wid), Std.int(hei) );

    public final function destroy() {
        if( !destroyed ) {
            destroyed = true;
            //GC.push(this);
        }
    }

    public function dispose() {
       // ALL.remove(this);
		rendering.dispose();
		cd.destroy();
		cd = null;
    }
	
	
	/**
		"Beginning of the frame" loop, called before any other Entity update loop
	**/
    public function preUpdate() {
		ucd.update(utmod);
		cd.update(tmod);
		#if debug
			rendering.debugRequest();
		#end
    }

	/**
		Post-update loop, which is guaranteed to happen AFTER any preUpdate/update. This is usually where render and display is updated
	**/
    public function postUpdate() {
		rendering.renderSprite(tmod);
	}

}