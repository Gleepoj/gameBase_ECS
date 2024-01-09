package aleiiioa.components.core.physics.velocity;

class AnalogSpeedComponent {
    public var xSpeed:Float = 0;
    public var ySpeed:Float = 0;
    

    public function new(xSp,ySp) {
        xSpeed = xSp;
        ySpeed = ySp;
    }

    inline public function reset(){
        xSpeed = 0;
        ySpeed = 0;
    }
}