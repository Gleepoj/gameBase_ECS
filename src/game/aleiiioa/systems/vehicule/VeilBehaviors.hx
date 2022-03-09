package aleiiioa.systems.vehicule;

import aleiiioa.components.solver.SolverUVComponent;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.core.position.MasterGridPosition;
import aleiiioa.components.vehicule.VeilComponent;

class VeilBehaviors extends echoes.System {
    public function new() {
        
    }

    @u function updateVeil(mgp:MasterGridPosition,gp:GridPosition,veil:VeilComponent,suv:SolverUVComponent) {
        veil.anchor = mgp.gpToVector();
        veil.extremity = gp.gpToVector();
        var orDifference = veil.extremity.sub(veil.anchor);
        veil.normalizeOrientation = orDifference.normalized();
        veil.normalizeUV = suv.uv.normalized();

        veil.dotProduct = veil.normalizeUV.dot(veil.normalizeOrientation);
    }
    
}