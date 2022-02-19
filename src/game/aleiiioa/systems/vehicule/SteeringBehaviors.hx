package aleiiioa.systems.vehicule;

import aleiiioa.components.vehicule.PathComponent;
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
        
        sw.predicted = VectorUtils.predict(sw.location,sw.velocity);
    }
    @u function updateTargetFromPath(sw:SteeringWheel,pc:PathComponent) {
        sw.target = getTargetFromPath(sw,pc);
    }

    @u function computeSteeringForce(en:echoes.Entity,sw:SteeringWheel) {
        if(en.exists(PathComponent) == false){
            var d:Vector = sw.solverUVatCoord;
            sw.steering = d.sub(sw.velocity);
        }
        if(en.exists(PathComponent))
            sw.steering = seek(sw);

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

    
    private function getTargetFromPath(sw:SteeringWheel,pc:PathComponent) {
        var targetClosestOnPath = VectorUtils.vectorProjection(pc.currentStart.gpToVector(),sw.predicted,pc.currentEnd.gpToVector());
        var d = sw.predicted.distance(targetClosestOnPath);
        
        if (d<3){
            var targetCurrentEnd = pc.currentEnd.gpToVector();
            return targetCurrentEnd;
        }

        return targetClosestOnPath;
    } 

    private function eulerIntegration(sw:SteeringWheel){
        // not the exact Reynols integration
        var _temp = sw.steering.clone();
        var _limitTemp = VectorUtils.limitVector(_temp,sw.maxForce);
        var accel = VectorUtils.divideVector(_limitTemp,sw.mass);
        return accel;
    }
   
}