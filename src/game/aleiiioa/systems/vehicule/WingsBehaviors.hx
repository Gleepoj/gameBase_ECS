package aleiiioa.systems.vehicule;

import aleiiioa.components.core.GridPositionOffset;
import hxd.Math;
import aleiiioa.components.flags.WingRightFlag;
import aleiiioa.components.core.SpriteComponent;
import aleiiioa.components.core.SpriteExtension;
import aleiiioa.components.flags.WingLeftFlag;
import aleiiioa.components.flags.WingsMasterFlag;
import aleiiioa.components.vehicule.WingsComponent;
import aleiiioa.components.vehicule.WindSensitivitySharedComponent;

class WingsBehaviors extends echoes.System {
    public function new() {
        
    }

    @u function updateWingsAngleY(win:WingsComponent,wms:WingsMasterFlag,ws:WindSensitivitySharedComponent) {
        
        var lerpY = Math.clamp(win.inputY,-0.2,1);
        win.angleL = -lerpY;
        win.angleR = lerpY;

        var lerpX = Math.clamp(win.inputX,-0.5,0.5);
        win.xLratio = lerpX;
        win.xRratio = -lerpX;

        
        ws.wingYaperture = Math.clamp(win.inputY,0,1);
        ws.xInput = win.inputX;
        ws.yInput = win.inputY;

        ws.attackPosition = win.inputLock;
    
    }

    @u function updateLeftWing(win:WingsComponent,wl:WingLeftFlag,spr:SpriteComponent,gop:GridPositionOffset){
       
        gop.oyr = win.xLratio*0.2;
        
        if(!win.isLocked){
            gop.oxr = -0.5;
            spr.rotation = win.angleL;
        }

        if(win.isLocked){
            gop.oxr = -0.3;
            spr.rotation = 0;
        }

 

    }

    @u function updateRightWing(win:WingsComponent,wr:WingRightFlag,spr:SpriteComponent,gop:GridPositionOffset){
       
        gop.oyr = win.xRratio*0.2;
        
        if(!win.isLocked){
            gop.oxr = 0.5;
            spr.rotation = win.angleR;
        }

        if(win.isLocked){
            gop.oxr = 0.3;
            spr.rotation = 0;
        }

    }
}