package aleiiioa.components.core.level;

import dn.MarkerMap;

class ChunkCollisionLayer {
    public var collision : dn.MarkerMap<LevelMark>;
    
    public var i:Int = 0;
    public var j:Int = 0;
    

    public function new (_collision:dn.MarkerMap<LevelMark>,_i:Int,_j:Int){
        collision = _collision;
        i = _i;
        j = _j;
    }

    public inline function isValid(cx,cy) return cx>=-1 && cx<Const.CHUNK_SIZE+1 && cy>=-1 && cy<Const.CHUNK_SIZE+1;
    public inline function hasCollision(cx,cy) : Bool {
		return !isValid(cx,cy) ? true : collision.has(M_Coll_Wall, cx,cy);
	}

}