package aleiiioa.systems.vehicule;

import aleiiioa.components.flags.vessel.*;

import aleiiioa.components.vehicule.PaddleSharedComponent;
import aleiiioa.components.core.position.GridPositionOffset;
import aleiiioa.components.core.rendering.*;

class PaddleSystem extends echoes.System {
    public function new() {
        
    }

    @u function updatePaddle(pad:PaddleSharedComponent,spr:SpriteComponent,gop:GridPositionOffset){
       
        gop.oyr = -1.5 ;
        
        if(!pad.isLocked){
            spr.rotation = pad.angleL+pad.angleR;
        }

        if(pad.isLocked){
            gop.oxr = -0.3;
            spr.rotation = 0;
        }
    }

    
}