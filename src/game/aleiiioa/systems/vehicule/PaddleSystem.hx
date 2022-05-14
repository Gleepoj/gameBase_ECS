package aleiiioa.systems.vehicule;

import echoes.Entity;
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
    var kayakOrientation:Vector;
    var kayakTargetAngle:Float = 0;

     
    public function new() {
        
    }

    @u function updateKayakVector(sw:SteeringWheel,spr:SpriteComponent,p:PlayerFlag,m:MasterFlag){
        kayakPos = sw.location;
        kayakToTarget = sw.targetDistance;
        kayakTargetAngle = Math.atan2(kayakPos.y-sw.eulerSteering.y,kayakPos.x-sw.eulerSteering.x);
        //spr.rotation = -Math.PI/2 + kayakTargetAngle;
        kayakAngle =  sw.vehiculeOrientation;
        kayakOrientation = sw.orientation;
        //kayakAngle = Math.PI/2 + sw.desiredOrientation;
        spr.rotation =  sw.vehiculeOrientation ;
        
      
        
    }

    @u function updatePaddle(pad:PaddleSharedComponent,spr:SpriteComponent,gop:GridPositionOffset){
        //gop.oxr = 0;
        gop.oyr = 0.1 ;
        var ang = -Math.PI/2 + kayakAngle;
        var inputLeftStick = new Vector(pad.leftSX,pad.leftSY,0,0);

        if(!pad.isLocked){
            spr.rotation = ang + pad.angleL+pad.angleR;
        }
        var dot = inputLeftStick.dot(kayakOrientation);

                
        if(dot>-1)
            spr.colorize(0x00ff00);

        if(dot>-0.5)
            spr.colorize(0xff00ff);

        if(dot>0.7)
            spr.colorize(0xff0000);
         
        
        spr.rotation = ang + inputLeftStick.getPolar();
        if(pad.isLocked){
            spr.rotation = 0;
        }
    }

    @u function updateDebugVector(en:Entity,sw:SteeringWheel,spr:SpriteComponent,gop:GridPositionOffset,d:DebugVectorFlag) {
        if(en.exists(VdesiredFlag)){
            spr.setCenterRatio(0,0.5);
            spr.rotation = sw.desiredOrientation;
        }


        if(en.exists(VsteeringFlag)){
            spr.setCenterRatio(0,0.5);
            spr.rotation = sw.steeringOrientation;
            spr.visible = false;
        }

        
        if(en.exists(VvehiculeFlag)){
            spr.setCenterRatio(0,0.5);
            spr.rotation = sw.vehiculeOrientation;
        }
        
    }
/*     @u function updateKayak(pad:PaddleSharedComponent,spr:SpriteComponent,p:PlayerFlag,m:MasterFlag){
        var ang = -Math.PI/2 + kayakTargetAngle;
        spr.rotation = ang;
    } */
   
}