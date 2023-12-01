package aleiiioa.components.core.physics.position;

import h3d.Vector;
//To move an object linearly using tween // 
//Sample use ::  en.add(new TransformPositionComponent(ori,target, 0.2, TEaseOut));

class TransformPositionComponent {
    public var tw:Tweenie = new Tweenie(Const.FPS);
    public var tw_type:TType;
    public var origin:Vector;
    public var target:Vector;
    public var direction:Vector;
    public var delay:Float;
    public var ratio:Float = 1;

    public function new(_origin,_target,_sec,_tw_type){
        origin = _origin;
        target = _target;
        delay  = _sec;
        tw_type = _tw_type;

        var dx = target.x - origin.x;
		var dy = target.y - origin.y;

        direction = new Vector(dx,dy);
        direction.normalize();
    }
}