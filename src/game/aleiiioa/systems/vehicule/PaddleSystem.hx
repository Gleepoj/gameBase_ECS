package aleiiioa.systems.vehicule;

import hxd.Math;
import h3d.Vector;
import aleiiioa.components.flags.hierarchy.MasterFlag;
import aleiiioa.components.vehicule.SteeringWheel;
import aleiiioa.components.core.velocity.VelocityAnalogSpeed;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.flags.vessel.*;

import aleiiioa.components.vehicule.PaddleSharedComponent;
import aleiiioa.components.core.position.GridPositionOffset;
import aleiiioa.components.core.rendering.*;

class PaddleSystem extends echoes.System {
    
    var kayakPos:Vector = new Vector(0,0);
     
    public function new() {
        
    }

    @u function updateKayakVector(sw:SteeringWheel,p:PlayerFlag,m:MasterFlag){
        kayakPos = sw.location;
    }

    @u function updatePaddle(pad:PaddleSharedComponent,spr:SpriteComponent,gop:GridPositionOffset){
       
        gop.oyr = -1.5 ;
        
        if(!pad.isLocked){
            spr.rotation = pad.angleL+pad.angleR;
        }

        if(pad.isLocked){
            spr.rotation = 0;
        }
    }

    @u function updateKayakTarget(pad:PaddleSharedComponent,gp:GridPosition,vas:VelocityAnalogSpeed,tf:TargetedFlag,tsf:SteeringPointFlag){
        if(pad.rb){
            gp.xr +=0.8;
            gp.yr -=4; 
        }

        if(pad.lb){
            gp.xr -=0.8;
            gp.yr -=4; 
        }

        var angle = Math.atan2(kayakPos.y-gp.attachY,kayakPos.x-gp.attachX);
        vas.xSpeed = Math.cos(-angle)/10;
        vas.ySpeed = Math.sin(-angle)/10;

    }
}