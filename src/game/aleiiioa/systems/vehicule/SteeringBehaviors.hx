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
                      
        sw.location.x = gp.attachX;
        sw.location.y = gp.attachY;

        //sw.velocity.x = vc.dx;
        //sw.velocity.y = vc.dy;
            
        sw.acceleration = new Vector(0,0,0,0);
        sw.predicted = VectorUtils.predict(sw.location,sw.velocity);
    }


    @u function computeVelocity(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
        //Velocity prend en compte l'inertie, l'acceleration, le freinage et la vitesse maximale
        //Ainsi que le courant 

        if(psc.rb){
            addForce(sw,new Vector(0.05,-1));
        }

        if(psc.lb){
            addForce(sw,new Vector(-0.05,-1));
        }
        
    }


    
    @u function computeSteering(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
        //Steer est la force angulaire appliqué au gouvernaille elle ne represente que la direction 
        // le *1 peut etre remplacer par la masse

        sw.maxForce = 0.06 * sw.speed;
        sw.desired = new Vector(psc.leftSX,psc.leftSY);

        var lastAngle = sw.vehiculeOrientation;
        
        var d =(sw.desired.dot(sw.orientation))*sw.maxForce;
        
        sw.steering.x = Math.cos(lastAngle+d)*1;
        sw.steering.y = Math.sin(lastAngle+d)*1;
        
        /* sw.steering.normalize();
        sw.steering.scale(sw.speed);
        addForce(sw,sw.steering); */
        sw.orientation = sw.steering.clone();
       
    }

    @u function computeSteeringForce(en:echoes.Entity,sw:SteeringWheel) {
        //sw.maxForce  =0.002;
        sw.maxSpeed  =0.16;

        if(!en.exists(PlayerFlag)){
            var d:Vector = sw.solverUVatCoord;
            sw.steering  = d.sub(sw.velocity);
        } 
        //applyStream(sw);

        sw.eulerSteering = eulerIntegration(sw);
    }

    

    private function eulerIntegration(sw:SteeringWheel){
        // not the exact Reynols integration
        // get polar_vehicule // get polar_desired steering // add desired to vPolar f(x) max torque (max force)
        // ok steering = normalize vec orientation
        // get desired velocity // desired -velocity = steering velocity 
        // steering velocity x.cos(steeringAngle)*steering velocity, y.sin(steeringAngle)*steering velocity
        // cap maxSpeed() return 

        //var _velocity = sw.velocity.add(sw.acceleration);
        var v1 = sw.velocity.clone();
        var v2 = v1.add(sw.acceleration);
        var v = VectorUtils.clampVector(v2,sw.maxSpeed);
        sw.velocity = v.clone();

        applyFriction(sw);

        return  v;
        
    }

    private function addForce(sw:SteeringWheel,f:Vector){
        var acc = sw.acceleration.clone();
        sw.acceleration = acc.add(f);
        //trace("add force");
    }

    function applyFriction(sw:SteeringWheel){
        var frict = 0.95;
        var frictY = 0.99;
        
        var vc = sw.velocity.clone();
        // X frictions
		vc.x *= frict;
		
		if (M.fabs(vc.x) <= 0.005)
			vc.x = 0;
		
		// Y frictions
		vc.y *= frictY;
		
		if (M.fabs(vc.y) <= 0.005)
			vc.y = 0;
        
        sw.velocity = vc.clone();
        //trace(sw.velocity);
    }
    
 
}