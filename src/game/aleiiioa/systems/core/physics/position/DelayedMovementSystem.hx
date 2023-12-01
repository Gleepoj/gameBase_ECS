package aleiiioa.systems.core.physics.position;

import aleiiioa.components.core.physics.position.flag.OnTransformComplete;
import aleiiioa.components.core.physics.position.TransformPositionComponent;
import aleiiioa.components.core.physics.position.GridPosition;

class DelayedMovementSystem extends echoes.System {
    //(the 0>1 expression is parsed by the Tweenie macros and interpret as "set value to 0 then interpolate to 1")
    public function new() {

    }

    @a function addTransform(en:echoes.Entity,tr:TransformPositionComponent,gp:GridPosition){
        tr.tw.createS(tr.ratio,0>1,tr.tw_type,tr.delay).end(function (){en.add(new OnTransformComplete());});
    }

    @u function transformGridPosition(en:echoes.Entity,tr:TransformPositionComponent,gp:GridPosition) {
		
        var target  = tr.target;
        var origin  = tr.origin;
        var direction = tr.direction;
        
        var dist_x = M.dist(origin.x,0,target.x,0);
        var dist_y = M.dist(0,origin.y,0,target.y);
        
        var dx = M.sign(direction.x);
        var dy = M.sign(direction.y);
        
        var current_x = origin.x + (tr.ratio * dist_x * dx);
        var current_y = origin.y + (tr.ratio * dist_y * dy);
        
        gp.setPosPixel(current_x,current_y);
        
        tr.tw.update();
	}

    @a function clearTransformOnCallback(en:echoes.Entity,add:OnTransformComplete){
        en.remove(TransformPositionComponent);
        en.remove(OnTransformComplete);
    }
}