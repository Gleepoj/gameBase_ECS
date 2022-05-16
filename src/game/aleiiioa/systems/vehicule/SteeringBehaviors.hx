package aleiiioa.systems.vehicule;

import h3d.Vector;

import echoes.Entity;
import echoes.System;

import aleiiioa.components.core.position.*;
import aleiiioa.components.solver.SolverUVComponent;
import aleiiioa.components.vehicule.SteeringWheel;
import aleiiioa.components.vehicule.PaddleSharedComponent;
import aleiiioa.components.flags.vessel.*;




 
class  SteeringBehaviors extends System {

    public function new() {
        
    }

    @a function onAddSteeringWheel(sw:SteeringWheel){
        sw.steering    = sw.origin;
        sw.orientation = sw.origin;
        sw.maxForce  = 0.002;
        sw.maxSpeed  = 0.16;
    }

    @u function updateVehicule(en:Entity,sw:SteeringWheel,gp:GridPosition,suv:SolverUVComponent){
        
        sw.solverUVatCoord = suv.uv;
                      
        sw.location.x = gp.attachX;
        sw.location.y = gp.attachY;
            
        sw.predicted = VectorUtils.predict(sw.location,sw.velocity);
    }


    @u function getInput(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
 
        var stream = sw.solverUVatCoord;
        sw.desired = new Vector(psc.leftSX,psc.leftSY,0,0);
       
        
        if(psc.rb){
            addTorque(sw,0.2); 
            addForce(sw,new Vector(0,-0.4));   
        }

        if(psc.lb){
            addTorque(sw,-0.2); 
            addForce(sw,new Vector(0,-0.4));   
            //trace(sw.acceleration);
        }

        if (psc.xb){
            addTorque(sw,0.02);
            addForce(sw,new Vector(0,0.01));
        }

        if (psc.bb){
            addTorque(sw,-0.02);
            addForce(sw,new Vector(0,0.01));
        }

        stream.scale(0.13);
        var streamDir = M.sign(stream.x);
        addTorque(sw,(streamDir*stream.length())*0.1);
        addForce(sw,stream);
    }


    
    @u function computeSteering(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){

        var angularVelocity = new Vector();
        
        angularVelocity.lerp(sw.steering,sw.orientation,0.9);
        angularVelocity.normalize();

        var integrate = sw.orientation.add(angularVelocity);
        sw.orientation = integrate;
        
        
        sw.steering.normalize();
        sw.orientation.normalize();
        
    }

    @u function computeSteeringForce(en:echoes.Entity,sw:SteeringWheel,pl:PlayerFlag) {


        sw.eulerSteering = eulerIntegration(sw);

        accelerationFriction(sw);
        //applyFriction(sw);

    }

    

    private function eulerIntegration(sw:SteeringWheel){
      
        var v = sw.velocity.add(sw.acceleration);

        var integration = new Vector();
        var scale = new Vector(sw.orientation.x*0.2,sw.orientation.y*0.05);
        integration.lerp(scale,v,0.1);
        
        return  integration;
    }

    private function addForce(sw:SteeringWheel,f:Vector){
        var a = sw.acceleration.clone();
        sw.acceleration = a.add(f);
    }

    private function addTorque(sw:SteeringWheel,a:Float){
        var or = sw.steeringOrientation;
        var a = new Vector(Math.cos(or+a)*1,Math.sin(or+a)*1);
        sw.steering = a.normalized();
    }

    private function accelerationFriction(sw:SteeringWheel){
        var zero = new Vector();
        var friction = new Vector();
        var a = sw.acceleration.clone();
        friction.lerp(zero,a,0.99);
        sw.acceleration = friction;
    }    
 
}