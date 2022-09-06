package aleiiioa.components.particules;

import aleiiioa.shaders.PressureShader;
import h2d.Bitmap;
import dn.Cooldown;

class ParticulesComponent {
    
    public var bitmap:Bitmap;
    public var shader:BeetleShader;
    public var cd:Cooldown;
    public var lifetime:Float;


    
    public function new() {
        cd = new Cooldown(Const.FPS);
        lifetime = 1.;
        cd.setS("alive",lifetime);

        bitmap = new h2d.Bitmap(Assets.alpha);
        var tex =  bitmap.tile.getTexture();
        shader = new BeetleShader(tex);
        //shader = new PerlinNoiseShader(tex);
            
        bitmap.addShader(shader); 
        bitmap.blendMode = Add;
        
        bitmap.height = 128;
        bitmap.width  = 128;
        bitmap.x = 0;
        bitmap.y = 0;
        //bitmap.alpha = 0.5;
    }
}