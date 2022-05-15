package aleiiioa.systems.vehicule;

import hxd.poly2tri.Orientation;
import aleiiioa.components.vehicule.PaddleSharedComponent;
import h3d.Vector;

import echoes.View;
import echoes.Entity;
import echoes.System;



import aleiiioa.components.core.position.*;
import aleiiioa.components.solver.SolverUVComponent;
import aleiiioa.components.core.velocity.VelocityComponent;
import aleiiioa.components.vehicule.SteeringWheel;
import aleiiioa.components.flags.vessel.*;




 
class  SteeringBehaviors extends System {
    var PLAYER_VIEW:View<PlayerFlag,SteeringWheel>;
    var player:Entity;
    public function new() {
        
    }
    @a function onAddSteeringWheel(sw:SteeringWheel){
        sw.steering = sw.origin;
        sw.orientation = sw.origin;
    }

    @u function Entity_PositionToSteeringwheel(en:Entity,sw:SteeringWheel,vc:VelocityComponent,gp:GridPosition,suv:SolverUVComponent){
        
        //var input = new Vector(psc.leftSX,psc.leftSY,0,0);
        //sw.desired = input;
        
        sw.solverUVatCoord = suv.uv;
                      
        sw.location.x = gp.attachX;
        sw.location.y = gp.attachY;
            
        //sw.acceleration = new Vector(0,0,0,0);
        sw.predicted = VectorUtils.predict(sw.location,sw.velocity);
    }


    @u function getInput(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
 
        
        var input = new Vector(psc.leftSX,psc.leftSY,0,0);
        sw.desired = input;
        
        if(psc.rb){
            addTorque(sw,0.5); 
            addForce(sw,new Vector(0,-0.1));   
        }

        if(psc.lb){
            addTorque(sw,-0.5); 
            addForce(sw,new Vector(0,-0.1));   
        }
        
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
        sw.maxForce  =0.002;
        sw.maxSpeed  =0.16;

        sw.eulerSteering = eulerIntegration(sw);

        applyFriction(sw);
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

    function applyFriction(sw:SteeringWheel){
        var frict = 0.95;
        var frictY = 0.99;
        
        var vc = sw.velocity.clone();
        
		vc.x *= frict;
		if (M.fabs(vc.x) <= 0.005)
			vc.x = 0;
		
		vc.y *= frictY;
		if (M.fabs(vc.y) <= 0.005)
			vc.y = 0;
        
        sw.velocity = vc.clone();
        
    }
    
 
}