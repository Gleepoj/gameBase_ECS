package en;

class Bullet extends Entity {
    
    public function new(px:Float,py:Float) {
        super(0,0);
        setPosPixel(px,py);

        rendering.spr.set(D.tiles.fxCircle7);
        rendering.spr.colorize(0xff000ff);
    }
    
    override public function fixedUpdate() {
        super.fixedUpdate();
        dx = 0;
        dy = -0.5;
 
    }
    
}