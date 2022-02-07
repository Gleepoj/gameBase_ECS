package aleiiioa.components.core;

class GridPosition {
    
	/** Grid X/Y coordinate **/
    public var cx = 0;
    public var cy = 0;
	/** Sub-grid X/Y ratio coordinate (from 0.0 to 1.0) **/
    public var xr = 0.5;
    public var yr = 1.0;

	public var lastFixedUpdateX = 0.;
	public var lastFixedUpdateY = 0.;
    
	public var attachX(get,never) : Float; inline function get_attachX() return (cx+xr)*Const.GRID;
	public var attachY(get,never) : Float; inline function get_attachY() return (cy+yr)*Const.GRID;

	public var prevFrameattachX : Float = -Const.INFINITE;
	public var prevFrameattachY : Float = -Const.INFINITE;


    public function new(_cx:Int,_cy:Int) {
        cx = _cx;
        cy = _cy;
    }
}