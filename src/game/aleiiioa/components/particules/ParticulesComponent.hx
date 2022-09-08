package aleiiioa.components.particules;

import aleiiioa.shaders.PressureShader;
import h2d.Bitmap;
import dn.Cooldown;

class ParticulesComponent {
    
    public var bitmap:Bitmap;
    public var shader:SmokeShader;
    
    public var cd:Cooldown;
    public var lifetime:Float;
    
    public var shrink:Float;
    public var rotation:Float = Math.PI*1/60;
    
    public var scaleX:Float=1;
    public var scaleY:Float=1;
    
    public var alpha  :Float  =1;
    
    public var collide:Bool  =true;
    public var gravity:Float =0.;
    public var frict:Float   =0.;

    public var lifeRatio(get,never):Float; inline function get_lifeRatio() return cd.getRatio("alive");
   
    public function new(_lifetime:Float,?_collide:Bool=false,?_frict:Float=0,?_gravity:Float=0) {
        
        lifetime= _lifetime;
        collide = _collide;
        frict   = _frict;
        gravity = _gravity;
        shrink  = 1/lifetime;


        cd = new Cooldown(Const.FPS);
        cd.setS("alive",lifetime);
       
        var tile = Assets.smoke;
        tile = tile.center();

        bitmap = new h2d.Bitmap(tile);
        var tex =  bitmap.tile.getTexture();
        
        shader = new SmokeShader(tex);
        bitmap.addShader(shader);
        
        var r = M.frandRange(0.4,0.7);
        bitmap.scaleX *= r;
        bitmap.scaleY *= r;
        
        bitmap.rotate(M.frand()*Math.PI);
    }
}