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

            sw.velocity.x = vc.dx;
            sw.velocity.y = vc.dy;
            
            sw.predicted = VectorUtils.predict(sw.location,sw.velocity);
        }
    }


    @u function seek(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
        //Velocity prend en compte l'inertie, l'acceleration, le freinage et la vitesse maximale
        //Contraindre la rotation en fonction de la vitesse

/*         var stream:Vector = sw.solverUVatCoord;
        sw.target = new Vector(sw.location.x - (psc.leftSX*2), sw.location.y - (psc.leftSY*2));
        sw.speed = 0.5;
        sw.desired = sw.location.sub(sw.target);
        sw.desired.normalize();
        sw.desired.scale(sw.speed); */
        if(psc.triggerLB){
            sw.acceleration = new Vector(0,-10);
            //trace("oklb");
        }

        sw.velocity = sw.acceleration;
    }

    @u function arrival(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
       /*  sw.targetDistance = sw.location.distance(sw.target);
        sw.maxForce = M.pretty(sw.targetDistance/1000,3);
        var slowRadius:Float = 2;
        var slow:Float = 1;

        if(sw.targetDistance < slowRadius){
            slow = sw.targetDistance*0.5 / slowRadius;
        }
        sw.desired.scale(slow);
 */
    }
    
    @u function computeSteering(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
        //Steer est la force du gouvernaille elle ne represente que la direction 
        //La direction est le resultat de la force interne de la barque(continue), du courant(continue), et du coup de pagaie(ponctuelle)
        

        //trace(sw.desired.toString());
        
        //sw.steering = sw.desired.sub(sw.velocity);
    }

    @u function applyFriction(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag) {
        var a = sw.acceleration; 
        a.x *= 0.2;
         
         if (M.fabs(a.x) <= 0.5)
			a.x = 0; 

         a.y *= 0.2; 
         
         if (M.fabs(a.y) <= 0.5){
			a.y = 0; 
         }
        
        sw.acceleration = new Vector(a.x,a.y);
        
    }

    @u function computeSteeringForce(en:echoes.Entity,sw:SteeringWheel) {
        sw.maxForce  =0.1285;
        sw.maxSpeed  =0.08;

        if(!en.exists(PlayerFlag)){
            var d:Vector = sw.solverUVatCoord;
            sw.steering  = d.sub(sw.velocity);
        } 

        //applyStream(sw);

        sw.eulerSteering = eulerIntegration(sw);
    }
    
    

    private function eulerIntegration(sw:SteeringWheel){
        // not the exact Reynols integration
        var _s = sw.steering.clone();
        var _v = sw.velocity.clone();
        var _steering = VectorUtils.limitVector(_s,sw.maxForce);
        var _acceleration = VectorUtils.divideVector(_steering,sw.mass);
        var _speed = _v.add(_acceleration);
        var _velocity = VectorUtils.limitVector(_speed,sw.maxSpeed);

        return  _velocity;
        
    }
  
}