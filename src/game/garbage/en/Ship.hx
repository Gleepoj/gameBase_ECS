package en;

import solv.Modifier;
import comp.Boids;

class Ship extends Entity {
    
    public var boid:Boids;
    public var modifier:Modifier;

    var target:Entity;

    public function new(_cx:Int,_cy:Int,_target:Entity) {
        super(_cx,_cy);

        target = _target;

        rendering.spr.set(D.tiles.Square);
        rendering.spr.colorize(0xffd872);

        boid = new Boids(cx,cy,this);
    }

    override function fixedUpdate() {
        stickToBoid();
    }

    private function stickToBoid() {
        setPosPixel(boid.attachX,boid.attachY);
    }
}