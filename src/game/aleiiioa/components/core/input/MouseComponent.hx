package aleiiioa.components.core.input;

import dn.Cooldown;
class MouseComponent {
    public var cd:Cooldown;
     
    public var x:Float = 0;
    public var y:Float = 0;
    // Var last
    var lx:Float = 0;
    var ly:Float = 0;
     
    var dist(get,never):Float; public inline function get_dist()return M.dist(x,y,lx,ly);
     
    public var onMove(get,never):Bool; public inline function get_onMove() return dist > 2;
        
    public function new() {
        cd = new Cooldown(Const.FPS);
    }

    public function setLastPos(x:Float,y:Float){
        lx = x;
        ly = y;
    }


}