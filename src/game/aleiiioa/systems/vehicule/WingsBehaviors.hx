package aleiiioa.systems.vehicule;

import aleiiioa.components.core.GridPositionOffset;
import hxd.Math;
import aleiiioa.components.flags.WingRightFlag;
import aleiiioa.components.core.SpriteComponent;
import aleiiioa.components.core.SpriteExtension;
import aleiiioa.components.flags.WingLeftFlag;
import aleiiioa.components.flags.WingsMasterFlag;
import aleiiioa.components.vehicule.WingsComponent;

class WingsBehaviors extends echoes.System {
    public function new() {
        
    }

    @u function updateWingsAngleY(win:WingsComponent,wms:WingsMasterFlag) {
/*         win.angleLeftCos = Math.cos(win.normalizeY);
        win.angleLeftSin = Math.sin(win.normalizeY);
        
        win.angleRightCos = Math.cos(win.normalizeY);
        win.angleRightSin = Math.sin(win.normalizeY); */

        var lerpY = Math.clamp(win.normalizeY,-0.2,1);
        win.angleL = -lerpY;
        win.angleR = lerpY;

        var lerpX = Math.clamp(win.normalizeX,-0.5,0.5);
        win.xLratio = lerpX;
        win.xRratio = -lerpX;
    
    }

    @u function updateLeftWing(win:WingsComponent,wl:WingLeftFlag,spr:SpriteComponent,gop:GridPositionOffset){
        spr.rotation = win.angleL;
        gop.oyr = win.xLratio;
    }

    @u function updateRightWing(win:WingsComponent,wr:WingRightFlag,spr:SpriteComponent,gop:GridPositionOffset){
        spr.rotation = win.angleR;
        gop.oyr = win.xRratio;
    }
}