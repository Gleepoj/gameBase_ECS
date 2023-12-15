import aleiiioa.components.core.physics.position.GridPosition;

class Level extends dn.Process {
	var game(get,never) : Game; inline function get_game() return Game.ME;
	var fx(get,never) : Fx; inline function get_fx() return Game.ME.fx;

	/** Level grid-based width**/
	public var cWid(get,never) : Int; inline function get_cWid() return data.l_Collisions.cWid;

	/** Level grid-based height **/
	public var cHei(get,never) : Int; inline function get_cHei() return data.l_Collisions.cHei;

	/** Level pixel width**/
	public var pxWid(get,never) : Int; inline function get_pxWid() return cWid*Const.GRID;

	/** Level pixel height**/
	public var pxHei(get,never) : Int; inline function get_pxHei() return cHei*Const.GRID;

	public var data : World_Level;
	var tilesetSource : h2d.Tile;
	var backgroundImage:Null<h2d.Object>;

	var marks : Map< LevelMark, Map<Int,Bool> > = new Map();
	var invalidated = true;
	
	var focus:GridPosition;


	public function new(ldtkLevel:World.World_Level) {
		super(Game.ME);
		
		focus = new GridPosition(0,0,0,0);

		createRootInLayers(Game.ME.scroller, Const.DP_BG);
		data = ldtkLevel;
		tilesetSource = hxd.Res.levels.gameBase_ECS_Tiles.toAseprite().toTile();
		if(ldtkLevel.hasBgImage())
			backgroundImage = ldtkLevel.getBgBitmap();



		//Game.ME.scroller.x = ldtkLevel.worldX;
		//Game.ME.scroller.y = ldtkLevel.worldY;
	}

	public function setFocus(_focus:GridPosition){
		focus = _focus;
	}
	override function onDispose() {
		super.onDispose();
		data = null;
		tilesetSource = null;
		backgroundImage = null;
		marks = null;
	}

	/** TRUE if given coords are in level bounds **/
	public inline function isValid(cx,cy) return cx>=0 && cx<cWid && cy>=0 && cy<cHei;

	/** Gets the integer ID of a given level grid coord **/
	public inline function coordId(cx,cy) return cx + cy*cWid;

	/** Ask for a level render that will only happen at the end of the current frame. **/
	public inline function invalidate() {
		invalidated = true;
	}

	/** Return TRUE if mark is present at coordinates **/
	public inline function hasMark(mark:LevelMark, cx:Int, cy:Int) {
		return !isValid(cx,cy) || !marks.exists(mark) ? false : marks.get(mark).exists( coordId(cx,cy) );
	}

	/** Enable mark at coordinates **/
	public function setMark(mark:LevelMark, cx:Int, cy:Int) {
		if( isValid(cx,cy) && !hasMark(mark,cx,cy) ) {
			if( !marks.exists(mark) )
				marks.set(mark, new Map());
			marks.get(mark).set( coordId(cx,cy), true );
		}
	}

	/** Remove mark at coordinates **/
	public function removeMark(mark:LevelMark, cx:Int, cy:Int) {
		if( isValid(cx,cy) && hasMark(mark,cx,cy) )
			marks.get(mark).remove( coordId(cx,cy) );
	}
	
	public function updateFocus(_focus:GridPosition){
		focus = _focus;
	}
	/** Return TRUE if "Collisions" layer contains a collision value **/
	public inline function hasCollision(_cx,_cy) : Bool {
		var cx = _cx+focus.cx;
		var cy = _cy+focus.cy;
		//trace(''+focus.cx+'::'+focus.cy+'');
		return !isValid(cx,cy) ? true : data.l_Collisions.getInt(cx,cy)==1;
	}

	/** Render current level**/
	function render() {
		// Placeholder level render
		/* root.removeChildren();
		if(backgroundImage != null){
			root.add(backgroundImage,Const.DP_BG);
			backgroundImage.setPosition(data.worldX,data.worldY);
		}

		var tg = new h2d.TileGroup(tilesetSource, root);
		tg.setPosition(data.worldX,data.worldY);

		var layer = data.l_Collisions;
		for( autoTile in layer.autoTiles ) {
			var tile = layer.tileset.getAutoLayerTile(autoTile);
			tg.add(autoTile.renderX, autoTile.renderY, tile);
		} */
	}

	override function postUpdate() {
		super.postUpdate();

		if( invalidated ) {
			invalidated = false;
			render();
		}
	}
}