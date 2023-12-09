package aleiiioa.components.utils.helper;
//function()  return maxSpeed,      function(v) maxSpeed = v
class HelperDebugFloat {
    
    public var value:Float = 0.;
    public var label:String = "";
    public var text:h2d.Text;
    public var get:Void->Float;
    public var set:Float->Void;
    //public var flow:h2d.Flow;
    
    public function new(l:String, _get : Void -> Float, _set : Float -> Void) {
        label = l;
        get = _get;
        set = _set;
       // value = v;
    }
    
}