package aleiiioa.systems.vehicule;

import aleiiioa.components.solver.SUVatCoordComponent;
import aleiiioa.components.core.GridPosition;
import aleiiioa.components.core.MasterGridPosition;
import aleiiioa.components.vehicule.VeilComponent;
import aleiiioa.components.core.VelocityComponent;

class VeilBehaviors extends echoes.System {
    public function new() {
        
    }

    @u function updateVeil(mgp:MasterGridPosition,gp:GridPosition,veil:VeilComponent,suv:SUVatCoordComponent) {
        veil.anchor = mgp.gpToVector();
        veil.extremity = gp.gpToVector();
        var orDifference = veil.extremity.sub(veil.anchor);
        veil.normalizeOrientation = orDifference.normalized();
        veil.normalizeUV = suv.uv.normalized();

        veil.dotProduct = veil.normalizeUV.dot(veil.normalizeOrientation);
        //trace(veil.normalizeUV);
        //trace(veil.dotProduct);
    }

    function computeDotProduct(veil:VeilComponent) {
        
    }
}