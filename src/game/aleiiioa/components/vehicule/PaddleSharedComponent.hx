

package aleiiioa.components.vehicule;
import hxd.Math;
class PaddleSharedComponent {
    
    public var ix:Float = 0;
    public var iy:Float = 0;

    public var tr:Float = 0;
    public var tl:Float = 0;
    
    public var rb:Bool = false;
    public var lb:Bool = false;
    
    public var lx:Float = 0;
    public var ly:Float = 0;

    public var leftSX(get,never):Float; inline function get_leftSX() return ix;
    public var leftSY(get,never):Float; inline function get_leftSY() return iy;

    public var triggerL(get,never):Float; inline function get_triggerL() return tl;
    public var triggerR(get,never):Float; inline function get_triggerR() return tr; 

    public var angleR(get,never):Float; inline function get_angleR() return Math.clamp(triggerR,-0.2,1);
    public var angleL(get,never):Float; inline function get_angleL() return -Math.clamp(triggerL,-0.2,1);

    public var offsetDirR(get,never):Float; inline function get_offsetDirR() return  -Math.clamp(leftSX,-0.5,0.5);
    public var offsetDirL(get,never):Float; inline function get_offsetDirL() return  Math.clamp(leftSY,-0.5,0.5);

    public var aperture(get,never):Float; inline function get_aperture() return Math.clamp(triggerR+triggerL,0,1);

    public var inputLock:Bool = false;
    public var isLocked(get,never):Bool; inline function get_isLocked() return inputLock;

    
    public function new() {
        
    }
}