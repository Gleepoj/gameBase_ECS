package aleiiioa.components.solver;

import h3d.Vector;

class CellComponent {
    //Solver array index
    public var index:Int;
    //Solver grid coordinates
    public var i:Int;
    public var j:Int;
    public var u:Float;
    public var v:Float;
    var uv:Vector;
    var isSelected(get,never):Bool;inline function get_isSelected() return selected; 
    var selected:Bool = false;

    public function new(_i:Int,_j:Int) {
        i = _i;
        j = _j;
        uv = new Vector(0,0);
    }
}