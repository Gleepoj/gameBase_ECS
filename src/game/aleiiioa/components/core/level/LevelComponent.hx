package aleiiioa.components.core.level;

class LevelComponent {
    public var data : World_Level;
    /** Level grid-based width**/
    public var cWid(default,null): Int;
	/** Level grid-based height **/
	public var cHei(default,null): Int;
	/** Level pixel width**/
	public var pxWid(default,null) : Int;
	/** Level pixel height**/
	public var pxHei(default,null) : Int;
	
	/** Chunk World Position X**/
	public var i:Int = 0;
	/** Chunk World Position Y**/
	public var j:Int = 0;

    var tilesetSource : h2d.Tile;
	var backgroundImage:Null<h2d.Object>;

    public var marks : dn.MarkerMap<LevelMark>;
	var invalidated = true;
	
    var scroller = Game.ME.scroller;
    
    public function new (ldtkLevel:World_Level){
		
		data = ldtkLevel;

		tilesetSource = hxd.Res.levels.gameBase_ECS_Tiles.toAseprite().toTile();
		
		if(ldtkLevel.hasBgImage())
			backgroundImage = ldtkLevel.getBgBitmap();
        
		// Store chunk coordinates
		i = M.floor((M.floor(data.worldX/Const.GRID))/Const.CHUNK_SIZE);
		j = M.floor((M.floor(data.worldY/Const.GRID))/Const.CHUNK_SIZE);

		cWid = data.l_Collisions.cWid;
		cHei = data.l_Collisions.cHei;

		pxWid = cWid * Const.GRID;
		pxHei = cHei * Const.GRID;

        marks = new dn.MarkerMap(cWid, cHei);
		
		for(cy in 0...cHei){
            for(cx in 0...cWid) {
                var value = data.l_Collisions.getInt(cx,cy);
                if((data.l_Collisions.getInt(cx,cy)) == 1 ){
                    marks.set(M_Coll_Wall,cx-1,cy-1);
                }
            }
        }
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

	/** Return TRUE if "Collisions" layer contains a collision value **/
	public inline function hasCollision(cx,cy) : Bool {
		return !isValid(cx,cy) ? true : marks.has(M_Coll_Wall, cx,cy);
	}

    public function render() {
		// Placeholder level render
     
		if(backgroundImage != null){
			scroller.add(backgroundImage,Const.DP_BG);
			backgroundImage.setPosition(data.worldX,data.worldY);
		}

		var tg = new h2d.TileGroup(tilesetSource, scroller);
		tg.setPosition(data.worldX,data.worldY);
		data.l_Collisions.render(tg);
	}

/* 	override function postUpdate() {
		super.postUpdate();

		if( invalidated ) {
			invalidated = false;
			render();
		}
	} */


/*     override function onDispose() {
		super.onDispose();
		data = null;
		tilesetSource = null;
		backgroundImage = null;
		marks = null;
	} */
 
    
}