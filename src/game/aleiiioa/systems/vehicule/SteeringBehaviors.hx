package aleiiioa.systems.vehicule;

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

    @u function Entity_PositionToSteeringwheel(en:Entity,sw:SteeringWheel,vc:VelocityComponent,gp:GridPosition,suv:SolverUVComponent){
        sw.previousStream  = sw.solverUVatCoord;
        sw.previousVelocity = sw.velocity;
        sw.solverUVatCoord = suv.uv;
        
        if(!en.exists(TargetGridPosition)){
                      
            sw.location.x = gp.attachX;
            sw.location.y = gp.attachY;

            //sw.velocity.x = vc.dx;
            //sw.velocity.y = vc.dy;
            
            sw.predicted = VectorUtils.predict(sw.location,sw.velocity);
        }
    }


    @u function computeVelocity(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
        //Velocity prend en compte l'inertie, l'acceleration, le freinage et la vitesse maximale
        //Ainsi que le courant 

        /* if(psc.rb){
            sw.velocity.add(new Vector(0.2,10));
        }

        if(psc.lb){
            sw.velocity.add(new Vector(-0.2,10));
        }
        sw.velocity() */

    }


    
    @u function computeSteering(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
        //Steer est la force angulaire appliqué au gouvernaille elle ne represente que la direction 
        // le *1 peut etre remplacer par la masse

        sw.maxForce = 0.05;
        sw.desired = new Vector(psc.leftSX,psc.leftSY);

        var lastAngle = sw.vehiculeOrientation;

        var d =(sw.desired.dot(sw.orientation))*sw.maxForce;
        sw.orientation.x = Math.cos(lastAngle+d)*1;
        sw.orientation.y = Math.sin(lastAngle+d)*1;
        
        sw.steering = sw.orientation.normalized();
    }


    @u function computeSteeringForce(en:echoes.Entity,sw:SteeringWheel) {
        sw.maxForce  =0.1285;
        sw.maxSpeed  =0.004;

        if(!en.exists(PlayerFlag)){
            var d:Vector = sw.solverUVatCoord;
            sw.steering  = d.sub(sw.velocity);
        } 

        //applyStream(sw);

        sw.eulerSteering = eulerIntegration(sw);
    }
    
    

    private function eulerIntegration2(sw:SteeringWheel){
        // not the exact Reynols integration
        var _s = sw.steering.clone();
        var _v = sw.velocity.clone();
        var _steering = VectorUtils.limitVector(_s,sw.maxForce);
        var _acceleration = VectorUtils.divideVector(_steering,sw.mass);
        var _speed = _v.add(_acceleration);
        var _velocity = VectorUtils.limitVector(_speed,sw.maxSpeed);

        return  _velocity;
        
    }

    private function eulerIntegration(sw:SteeringWheel){
        // not the exact Reynols integration
        // get polar_vehicule // get polar_desired steering // add desired to vPolar f(x) max torque (max force)
        // ok steering = normalize vec orientation
        // get desired velocity // desired -velocity = steering velocity 
        // steering velocity x.cos(steeringAngle)*steering velocity, y.sin(steeringAngle)*steering velocity
        // cap maxSpeed() return 
        var velocity = VectorUtils.limitVector(sw.velocity,sw.maxSpeed);
        var x = Math.cos(sw.steeringOrientation)*velocity.x;
        var y = Math.sin(sw.steeringOrientation)*velocity.y;

        var _velocity = new Vector(x,y);
        return  _velocity;
        
    }
  
}