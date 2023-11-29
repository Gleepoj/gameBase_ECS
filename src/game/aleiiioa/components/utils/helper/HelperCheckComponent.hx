package aleiiioa.components.utils.helper;

class HelperCheckComponent {
    
    
    public var label:String;
    public var get:Void->Bool;
    public var set:Bool->Void;
 
    public function new(_label : String, _get : Void -> Bool, _set : Bool -> Void) {
        label = _label;
        get = _get;
        set = _set;
       
    }
}