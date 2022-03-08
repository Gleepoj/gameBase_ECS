package aleiiioa.components.vehicule;

class WingsComponent {
    
    public var inputX:Float = 0;
    public var inputY:Float = 0;

    public var inputLock:Bool = false;

    public var isLocked(get,never):Bool; inline function get_isLocked() return inputLock;
  

    public var angleLeftCos:Float = 0;
    public var angleLeftSin:Float = 0;

    public var angleRightCos:Float = 0;
    public var angleRightSin:Float = 0;

    public var angleR:Float=0;
    public var angleL:Float=0;

    public var xRratio:Float=0;
    public var xLratio:Float=0;
    
    public function new() {
        
    }
}