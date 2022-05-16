package aleiiioa.systems.vehicule;

import aleiiioa.components.vehicule.VehiculeComponent;
import echoes.Entity;
import hxd.Math;
import h3d.Vector;
import aleiiioa.components.flags.hierarchy.MasterFlag;
import aleiiioa.components.flags.vessel.*;

import aleiiioa.components.vehicule.PaddleSharedComponent;
import aleiiioa.components.core.position.GridPositionOffset;
import aleiiioa.components.core.rendering.*;

class PaddleSystem extends echoes.System {
    
    var kayakPos:Vector = new Vector(0,0);
    var kayakToTarget:Float = 0;
    var kayakAngle:Float = 0;
    public var kayakOrientation:Vector = new Vector(0,0);
    var kayakTargetAngle:Float = 0;
    
    public var input:Vector = new Vector(0,0);

    public var dot(get,never):Float;inline function get_dot() return input.dot(kayakOrientation) ;

    public var isIdle(get,never):Bool; inline function get_isIdle () return dot>0.7;
    public var isSided(get,never):Bool; inline function get_isSided () return dot>-0.5 && dot<=0.7 ;
    public var isBackward(get,never):Bool; inline function get_isBackward () return dot >=-1 && dot<=-0.5 ;
    
    
    public function new() {
        
    }

    @u function updateKayakVector(sw:VehiculeComponent,spr:SpriteComponent,p:PlayerFlag,m:MasterFlag){
        kayakPos = sw.location;
        kayakAngle =  sw.orientation.getPolar();
        kayakOrientation = sw.orientation;
        spr.rotation =  kayakAngle;
        
    }

    @u function updatePaddle(pad:PaddleSharedComponent,spr:SpriteComponent,gop:GridPositionOffset){
        //Graphics
        gop.oyr = 0.1 ;
        var ang = -Math.PI/2 + kayakAngle;
        spr.rotation = ang;
        
        input = new Vector(pad.leftSX,pad.leftSY);
        input.normalize();

        if(isSided)
            spr.colorize(0x0000ff);

        if(isBackward)
            spr.colorize(0x00ff00);

        if(isIdle)
            spr.colorize(0xff0000);
        
    }

    @u function getInput(vhc:VehiculeComponent,psc:PaddleSharedComponent,pl:PlayerFlag){
 
        var stream = vhc.stream;
        vhc.desired = new Vector(psc.leftSX,psc.leftSY,0,0);
       
        
        if(psc.rb){
            vhc.addTorque(0.15); 
            vhc.addForce(new Vector(0,-0.6));   
        }

        if(psc.lb){
            vhc.addTorque(-0.15); 
            vhc.addForce(new Vector(0,-0.6));   
            //trace(vhc.acceleration);
        }

        if (psc.xb){
            vhc.addTorque(0.02);
            vhc.addForce(new Vector(0,0.01));
        }

        if (psc.bb){
            vhc.addTorque(-0.02);
            vhc.addForce(new Vector(0,0.01));
        }

        stream.scale(0.13);
        var streamDir = M.sign(stream.x);
        vhc.addTorque((streamDir*stream.length())*0.1);
        vhc.addForce(stream);
    }


    @u function updateDebugVector(en:Entity,sw:VehiculeComponent,spr:SpriteComponent,gop:GridPositionOffset,d:DebugVectorFlag) {
        if(en.exists(VdesiredFlag)){
            spr.setCenterRatio(0,0.5);
            spr.rotation = sw.desired.getPolar();
        }


        if(en.exists(VsteeringFlag)){
            spr.setCenterRatio(0,0.5);
            spr.rotation = sw.steering.getPolar();
        }

        
        if(en.exists(VvehiculeFlag)){
            spr.setCenterRatio(0,0.5);
            spr.rotation = sw.board.getPolar();
        }
        
    }

    
}