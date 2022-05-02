package aleiiioa.systems.collisions;

import h3d.Vector;
import aleiiioa.components.core.collision.CollisionsListener;


interface CollisionEvent {
    public function send(cl:CollisionsListener):Void;    
}

class Event_Reset implements  CollisionEvent {
    public function new() {
    }

    public function send(cl:CollisionsListener) {
  
    }
}

class Event_BulletInpact implements  CollisionEvent {
    public function new() {
    }

    public function send(cl:CollisionsListener) {
        cl.cd.setS("bullet_inpact",0.2);
        cl.inpact = new Vector(10,10);     
    }
}

class Event_VesselInpact implements  CollisionEvent {
    public function new() {
    }

    public function send(cl:CollisionsListener) {
        cl.cd.setS("vessel_inpact",0.2);
        cl.inpact = new Vector(10,10);     
    }
}


class InstancedCollisionEvent {
    
    public var bulletInpact :Event_BulletInpact;
    public var vesselInpact :Event_VesselInpact;
    public var reset :Event_Reset;

    public function new() {
        bulletInpact    = new Event_BulletInpact();
        vesselInpact    = new Event_VesselInpact();
        reset  = new Event_Reset();
    }
    
}