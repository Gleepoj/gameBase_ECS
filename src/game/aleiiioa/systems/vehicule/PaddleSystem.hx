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
    var kayakToTarget:Float = 0;
    var kayakTargetAngle:Float = 0;
     
    public function new() {
        
    }

    @u function updateKayakVector(sw:SteeringWheel,spr:SpriteComponent,p:PlayerFlag,m:MasterFlag){
        kayakPos = sw.location;
        kayakToTarget = sw.targetDistance;
        kayakTargetAngle = Math.atan2(kayakPos.y-sw.target.y,kayakPos.x-sw.target.x);
        spr.rotation = -Math.PI/2 + kayakTargetAngle;
        //spr.rotate(0.1);
        
    }

    @u function updatePaddle(pad:PaddleSharedComponent,spr:SpriteComponent,gop:GridPositionOffset){
        //gop.oxr = 0;
        gop.oyr = 0.1 ;
        var ang = -Math.PI/2 + kayakTargetAngle;

        if(!pad.isLocked){
            spr.rotation = ang + pad.angleL+pad.angleR;
        }

        if(pad.isLocked){
            spr.rotation = 0;
        }
    }

    @u function updateKayakTarget(pad:PaddleSharedComponent,gp:GridPosition,vas:VelocityAnalogSpeed,tf:TargetedFlag,tsf:SteeringPointFlag){
        if(pad.rb){
            gp.xr +=0.4;
            gp.yr -=5.8; 
        }

        if(pad.lb){
            gp.xr -=0.4;
            gp.yr -=5.8; 
        }
        

        vas.xSpeed = 0;
        vas.ySpeed = 0;
        
        if(kayakToTarget > 50){
            vas.xSpeed = Math.cos(kayakTargetAngle)*0.001;
            vas.ySpeed = Math.sin(kayakTargetAngle)*0.001;
        }
     
    }
}