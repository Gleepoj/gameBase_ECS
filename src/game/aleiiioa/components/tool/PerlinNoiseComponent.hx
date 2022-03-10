package aleiiioa.components.tool;

import hxd.Perlin;

class PerlinNoiseComponent {
    
    public var perlin = new Perlin();
    
    public var initX:Float = 1*Math.random();
    public var initY:Float = 1*Math.random();
   
    public var seed:Int = 10;
    public var octaves:Int = 4;
   
    public var incX:Float = 0.0001;
    public var incY:Float = 0.0001;

    public var px:Float = 0;
    public var py:Float = 0;

    public function new() {
        
    }
}