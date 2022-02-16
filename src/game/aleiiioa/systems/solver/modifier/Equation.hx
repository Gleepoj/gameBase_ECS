package aleiiioa.systems.solver.modifier;

import h3d.Vector;


class Equation {
 
    var type:AreaEquation;
    

    public function new(type:AreaEquation) {
        setType(type);
    }

    public dynamic function compute(eq:Vector) :Vector { return eq; }
    
    public function setType(t:AreaEquation) {
        type = t;
        setCompute();
    }

    private function setCompute() {

		compute = switch(type) {
			case EqConverge  : function(v:Vector){ 
                                    var lx = -v.x * 0.2; var ly = -v.y * 0.2; return new Vector(lx,ly);}
			case EqDiverge	 : function(v:Vector){ 
                                    var lx = v.x * 0.2; var ly = v.y * 0.2; return new Vector(lx,ly);}
			case EqRepel	 : function(v:Vector){ 
                                    var lx = -v.x * 0.2; var ly = v.y * 0.2; return new Vector(lx,ly);}
			case EqCurl	     : function(v:Vector){ 
                                    var lx = v.y * 0.2 - v.x*0.1; var ly = -v.x *0.2 - v.y*0.1; return new Vector(lx,ly);}
		}
		return type;
	}
}
