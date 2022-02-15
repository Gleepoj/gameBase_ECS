package aleiiioa.systems.vehicule;

import h3d.Vector;
import echoes.System;

import aleiiioa.components.core.BoundingBox;
import aleiiioa.components.core.VelocityComponent;
import aleiiioa.components.vehicule.SteeringWheel;


class  SteeringBehaviors extends System {
    public function new() {
        
    }

    @u function updateVectors(sw:SteeringWheel,vc:VelocityComponent,bb:BoundingBox){
        sw.location.x = bb.centerX;
        sw.location.y = bb.centerY;

        sw.velocity.x = vc.dx;
        sw.velocity.y = vc.dy;
        
        sw.predicted = predict(sw.location,sw.velocity);
    }

    @u function computeSteeringForce(sw:SteeringWheel) {
        var d:Vector = sw.solverUVatCoord;
        sw.steering = d.sub(sw.velocity);
        //sw.steering = seek(sw);
        sw.eulerSteering = eulerIntegration(sw);
    }
    
    private function seek(sw:SteeringWheel){
        sw.desired = sw.target.sub(sw.location);
        sw.desired.normalize();
        sw.desired.scale(sw.maxSpeed);
        var v = sw.velocity.clone();
        var steer = sw.desired.sub(v);
        return steer;
    }

    private function eulerIntegration(sw:SteeringWheel){
        // not the exact Reynols integration
        var _temp = sw.steering.clone();
        var _limitTemp = VectorUtils.limitVector(_temp,sw.maxForce);
        var accel = VectorUtils.divideVector(_limitTemp,sw.mass);
        return accel;
    }

    private function predict(_location:Vector,_velocity:Vector) {
        var predict = _velocity.clone();
        predict.normalize();
        predict.scale(10);
        var p = _location.add(predict);
        return p;
    }
    
}