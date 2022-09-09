package aleiiioa.systems.particules;

import aleiiioa.components.core.velocity.VelocityAnalogSpeed;
import aleiiioa.components.particules.ParticulesComponent;
import dn.Tweenie;

class ParticulesVelocitySystem extends echoes.System {
    
    public function new() {
        
    
    }

    @u function updateParticule(pc:ParticulesComponent,vas:VelocityAnalogSpeed) {
        
        if(pc.frict > 0){
            if(pc.lifeRatio < 0.95){
                vas.xSpeed *= pc.frict;
                vas.ySpeed *= pc.frict;
            }
        }

        if(pc.gravity >0){
            vas.ySpeed += 0.2;
        }
    }
}