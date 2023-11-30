package aleiiioa.components.core.physics.velocity;

class VelocityComponent {
    
	/** X/Y velocity, in grid fractions **/
    public var dx = 0.;
	public var dy = 0.;

	/** Uncontrollable bump X/Y velocity, usually applied by external factors (eg. a bumper in Sonic) **/
    public var bdx = 0.;
	public var bdy = 0.;
    
	// Velocities + bump velocities
	public var dxTotal(get,never) : Float; inline function get_dxTotal() return dx+bdx;
	public var dyTotal(get,never) : Float; inline function get_dyTotal() return dy+bdy;

	/** Multiplier applied on each frame to normal X/Y velocity 0.82**/
	public var frictX = 0.84;//0.9;//0.82;
	public var frictY = 0.94;//0.82;

	/** Sets both frictX/Y at the same time **/
	public var frict(never,set) : Float;
		inline function set_frict(v) return frictX = frictY = v;

	/** Multiplier applied on each frame to bump X/Y velocity **/
	public var bumpFrictX = 0.93;
	public var bumpFrictY = 0.93;


    public function new() {
     
    }

	/** Apply a bump/kick force to entity **/
	public function bump(x:Float, y:Float, vc:VelocityComponent) {
		vc.bdx += x;
		vc.bdy += y;
	}
	
		/** Reset velocities to zero **/
	public function cancelVelocities(vc:VelocityComponent) {
		vc.dx = vc.bdx = 0;
		vc.dy = vc.bdy = 0;
	}

    
}