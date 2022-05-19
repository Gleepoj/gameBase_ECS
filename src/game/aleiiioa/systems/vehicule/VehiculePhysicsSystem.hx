package aleiiioa.systems.vehicule;

import aleiiioa.builders.UIBuild;
import h3d.Vector;

import echoes.Entity;
import echoes.System;

import aleiiioa.components.core.position.*;
import aleiiioa.components.solver.SolverUVComponent;
import aleiiioa.components.vehicule.VehiculeComponent;


class  VehiculePhysicsSystem extends System {

    public function new() {
        
    }

    @a function onAddVehiculeComponent(vhc:VehiculeComponent){
        vhc.steering    = vhc.origin;
        vhc.orientation = vhc.origin;
        vhc.maxForce  = 0.93;
        vhc.maxSpeed  = 0.16;
        
        UIBuild.slider("MaxForce", function() return vhc.maxForce, function(v) vhc.maxForce = v, 0, 2);
        UIBuild.slider("Speed", function() return vhc.maxSpeed, function(v) vhc.maxSpeed = v, 0, 1);
    }

    @u function updateVehicule(vhc:VehiculeComponent,gp:GridPosition,suv:SolverUVComponent){
        
        vhc.stream = suv.uv;
                      
        vhc.location.x = gp.attachX;
        vhc.location.y = gp.attachY;
             
    }


    @u function integrateSteeringForce(vhc:VehiculeComponent){

        var angularMoment = new Vector();
        
        angularMoment.lerp(vhc.steering,vhc.orientation,vhc.maxForce);
        angularMoment.normalize();

        var integrate = vhc.orientation.add(angularMoment);
        
        vhc.orientation = integrate;
        vhc.steering.normalize();
        
        vhc.orientation.normalize();
    }

    @u function computeNewPosition(vhc:VehiculeComponent) {


        vhc.euler = eulerIntegration(vhc);

        vhc.accelerationFriction();
    }

    

    private function eulerIntegration(vhc:VehiculeComponent){
      
        var v = vhc.velocity.add(vhc.acceleration);

        var integration = new Vector();
        var scale = new Vector(vhc.orientation.x*0.2,vhc.orientation.y*0.05);
        integration.lerp(scale,v,0.1);
        
        return  integration;
    } 
 
}