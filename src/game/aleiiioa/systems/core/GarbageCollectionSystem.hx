package aleiiioa.systems.core;

import echoes.System;
import echoes.Entity;

import aleiiioa.components.core.*;
import aleiiioa.components.flags.*;
import aleiiioa.components.flags.hierarchy.*;

class GarbageCollectionSystem extends System {
    public function new() {
        
    }
    @u function removeChild(en:Entity,cflag:ChildFlag,dflag:IsDiedFlag) {
        if(en.exists(SpriteComponent)){
            en.remove(SpriteComponent);
            en.remove(SpriteExtension);
        }
    }
}