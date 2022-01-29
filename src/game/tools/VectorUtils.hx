package tools;

import h3d.Vector;

class VectorUtils {
    public static function vectorProjection(_aLocation:Vector,_predictLocation:Vector,_bLocation:Vector) {
            var u = _bLocation.sub(_aLocation);
            var uBis = _bLocation.sub(_aLocation);
            var v = _predictLocation.sub(_aLocation);
            
            var sp = scalarProjection(u,v);
        
            uBis.normalize();
            var p = uBis.multiply(sp);
            var f = uBis.multiply(Math.abs(0.3*sp));
            var n = p.add(f);
            return _aLocation.add(n);
        }
    
    public static function scalarProjection(_u:Vector,v:Vector){
            var u = _u.normalized();
            return v.dot(u);
    }
}