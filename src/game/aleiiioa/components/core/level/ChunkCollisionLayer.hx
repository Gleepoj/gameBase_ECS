package aleiiioa.components.core.level;

import dn.MarkerMap;

class ChunkCollisionLayer {
    public var collision : dn.MarkerMap<LevelMark>;
    
    public var i:Int = 0;
    public var j:Int = 0;
    
    var last_i:Int = 0;
    var last_j:Int = 0;

    public var onChunkChange(get,never):Bool; inline function get_onChunkChange()  return (i != last_i || j != last_j);

    public function new (_collision:dn.MarkerMap<LevelMark>,_i:Int,_j:Int){
        collision = _collision;
        i = _i;
        j = _j;
    }

    public inline function isValid(cx,cy) return cx>=0 && cx<Const.CHUNK_SIZE && cy>=0 && cy<Const.CHUNK_SIZE;
    public inline function hasCollision(cx,cy) : Bool {
		return !isValid(cx,cy) ? true : collision.has(M_Coll_Wall, cx,cy);
	}

    public function updateChunkCoordinate(_i:Int,_j:Int){
        last_i = i;
        last_j = j;

        i = _i;
        j = _j;
    }

    public function swapCollisionLayer(_collision:dn.MarkerMap<LevelMark>){
        collision = _collision;
    }
}