package aleiiioa.components;

class BoundingBox {

    /** Grid X/Y coordinate **/
    public var cx = 0;
    public var cy = 0;
    /** Sub-grid X/Y ratio coordinate (from 0.0 to 1.0) **/
    public var xr = 0.5;
    public var yr = 1.0;
    
	public var pivotX(default,set) : Float = 0.5;
	public var pivotY(default,set) : Float = 1;
    
	public var attachX(get,never) : Float; inline function get_attachX() return (cx+xr)*Const.GRID;
	public var attachY(get,never) : Float; inline function get_attachY() return (cy+yr)*Const.GRID;
	//Bounding box getters//
	public var left(get,never)  : Float; inline function get_left()  return attachX + (0-pivotX) * wid;
	public var right(get,never) : Float; inline function get_right() return attachX + (1-pivotX) * wid;
	public var top(get,never)   : Float; inline function get_top()   return attachY + (0-pivotY) * hei;
	public var bottom(get,never): Float; inline function get_bottom()return attachY + (1-pivotY) * hei;
	// Bounding box center//
	public var centerX(get,never) : Float; inline function get_centerX() return attachX + (0.5-pivotX) * wid;
	public var centerY(get,never) : Float; inline function get_centerY() return attachY + (0.5-pivotY) * hei;
}