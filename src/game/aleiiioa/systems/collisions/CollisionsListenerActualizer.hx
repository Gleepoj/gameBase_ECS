package aleiiioa.systems.collisions;

import aleiiioa.systems.collisions.CollisionEvent.InstancedCollisionEvent;
import aleiiioa.components.CollisionsListener;
import echoes.System;

class CollisionsListenerActualizer extends System {
    var events:InstancedCollisionEvent;
    public function new() {
        events = new InstancedCollisionEvent();
    }

    @u function cooldownUpdate(dt:Float,cl:CollisionsListener) {
        cl.cd.update(dt);
        if(cl.onBulletHit)
            trace("bullethit");
        if(cl.onVesselHit)
            trace("vesselhit");
    }
}