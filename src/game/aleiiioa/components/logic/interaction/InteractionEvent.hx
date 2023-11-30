package aleiiioa.components.logic.interaction;

import dn.Cooldown;

interface InteractionEvent {
    public function send(cd:Cooldown):Void;    
}

class IEvent_Reset implements  InteractionEvent {
    public function new() {
    }

    public function send(cd:Cooldown) {
  
    }
}

class IEvent_OnDialogArea implements  InteractionEvent {
    public function new() {
    }

    public function send(cd:Cooldown) {
        //cd.setS("pnj ready",0.005);  
        cd.setMs("pnj ready",1000);
    }
}

class IEvent_OnInteractArea implements InteractionEvent {
    public function new() {
        
    }
    public function send(cd:Cooldown){
        cd.setMs("interact",100);
    }
}

class InstancedInteractionEvent {
    
    public var allowDialog  :IEvent_OnDialogArea;
    public var allowInteract:IEvent_OnInteractArea;

    public var reset :IEvent_Reset;

    public function new() {
        allowInteract = new IEvent_OnInteractArea();
        allowDialog   = new IEvent_OnDialogArea();
        reset  = new IEvent_Reset();
    }
    
}