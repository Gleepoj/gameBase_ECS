package aleiiioa.components.logic.interaction;

import dn.Cooldown;
import aleiiioa.components.logic.interaction.InteractionEvent;

// Mettre en place des interaction possible en fonction des touches ActionX,ACtionY, etc. assigner une interaction a une touche 
// Peut etre debugger == flow avec rouge, vert bleu, jeune qui s'allume quand l'interaction est possible 

class InteractionListener {
    //public var onPnjArea:Bool = false;
    public var cd:Cooldown;
    
    public var lastEvent:InteractionEvent;
    
    public var onInteract(get,never):Bool;
        inline function get_onInteract() return cd.has("interact");
    
    public var onArea(get,never):Bool;
        inline function get_onArea() return cd.has("pnj ready");
    
    
    public function new(){
        lastEvent = new IEvent_Reset();
        cd = new Cooldown(Const.FIXED_UPDATE_FPS);
    }

    public function order(){
        if (lastEvent!=null)
            lastEvent.send(cd);
    }
}