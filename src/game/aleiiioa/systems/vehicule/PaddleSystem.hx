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
    var kayakAngle:Float = 0;
    var kayakTargetAngle:Float = 0;
     
    public function new() {
        
    }

    @u function updateKayakVector(sw:SteeringWheel,spr:SpriteComponent,p:PlayerFlag,m:MasterFlag){
        kayakPos = sw.location;
        kayakToTarget = sw.targetDistance;
        kayakTargetAngle = Math.atan2(kayakPos.y-sw.eulerSteering.y,kayakPos.x-sw.eulerSteering.x);
        spr.rotation = -Math.PI/2 + kayakTargetAngle;
        kayakAngle = spr.rotation;
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

/*     @u function updateKayak(pad:PaddleSharedComponent,spr:SpriteComponent,p:PlayerFlag,m:MasterFlag){
        var ang = -Math.PI/2 + kayakTargetAngle;
        spr.rotation = ang;
    } */
   
}