package aleiiioa.systems.core.renderer;

import aleiiioa.components.core.rendering.SquashComponent;
import aleiiioa.components.core.physics.collision.CollisionSensor;
import echoes.System;

class SquashRenderer extends System {
    public function new() {
        
    }

    @u function updateSquash(sq:SquashComponent, cl:CollisionSensor) {
        if(cl.onFall)
            sq.squashX = 0.90;

        if(cl.onJump)
            sq.squashX = 0.96;

        if(cl.cd.has("landing"))
            sq.squashY = 0.6;
    }
}