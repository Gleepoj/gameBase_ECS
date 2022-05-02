package aleiiioa.systems.vehicule;


import aleiiioa.components.flags.vessel.*;

import aleiiioa.components.vehicule.WingsSharedComponent;
import aleiiioa.components.core.position.GridPositionOffset;
import aleiiioa.components.core.rendering.*;

class WingsBehaviors extends echoes.System {
    public function new() {
        
    }

    @u function updateLeftWing(win:WingsSharedComponent,wl:WingLeftFlag,spr:SpriteComponent,gop:GridPositionOffset){
       
        gop.oyr = -2 + win.offsetDirL*0.2;
        
        if(!win.isLocked){
            gop.oxr = -0.5;
            spr.rotation = -win.angleL;
        }

        if(win.isLocked){
            gop.oxr = -0.3;
            spr.rotation = 0;
        }
    }

    
    @u function updateRightWing(win:WingsSharedComponent,wr:WingRightFlag,spr:SpriteComponent,gop:GridPositionOffset){
       
        gop.oyr =  -2 + win.offsetDirR*0.2;
    
        if(!win.isLocked){
            gop.oxr = 0.5;
            spr.rotation = -win.angleR;
        }

        if(win.isLocked){
            gop.oxr = 0.3;
            spr.rotation = 0;
        }

    }
}