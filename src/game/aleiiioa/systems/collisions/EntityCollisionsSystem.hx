package aleiiioa.systems.collisions;

import echoes.View;

import aleiiioa.systems.collisions.CollisionEvent.InstancedCollisionEvent;
import aleiiioa.components.core.collision.CollisionsListener;
import aleiiioa.components.core.position.GridPosition;

import aleiiioa.components.flags.collision.*;
import aleiiioa.components.flags.vessel.*;


class EntityCollisionsSystem extends echoes.System {
    var ALL_VESSELS:View<GridPosition,VesselFlag>;

    

    var events:InstancedCollisionEvent;

    public function new() {
        events = new InstancedCollisionEvent();
    }

    
    @u function playerCollideWithVessels(gp:GridPosition,flag:PlayerFlag,cl:CollisionsListener) {
        var head = ALL_VESSELS.entities.head;
        var vecPos = gp.gpToVector();
        while (head != null){
            var vessel = head.value;
            var vecVessel = vessel.get(GridPosition).gpToVector();
            if(vecPos.distance(vecVessel)<40){
                cl.lastEvent = events.vesselInpact;
                orderListener(cl);
            }
            head = head.next;
        }
    }

    function orderListener(cl:CollisionsListener){
        if (cl.lastEvent!=null)
            cl.lastEvent.send(cl);
    }
}