package aleiiioa.systems.core;

//Bullets are destroy in various collisions systems 
import echoes.System;
import echoes.Entity;
import echoes.View;

import aleiiioa.components.core.*;
import aleiiioa.components.flags.*;
import aleiiioa.components.flags.hierarchy.*;
import aleiiioa.components.vehicule.*;
import aleiiioa.components.solver.*;


class GarbageCollectionSystem extends System {
    public function new() {
        
    }
    
    @r function onRemoveMasterGridPos(en:Entity,mgp:MasterGridPosition,mf:MasterFlag) {
        mgp.isMasterAlive = false;
    }

    @u function flagChild(en:Entity,cflag:ChildFlag,mgp:MasterGridPosition){
        if(!en.get(MasterGridPosition).isMasterAlive){
            en.add(new IsDiedFlag());
        }
    }

    @u function destroyBody(en:Entity,dflag:IsDiedFlag) {
        en.destroy();
    }

}