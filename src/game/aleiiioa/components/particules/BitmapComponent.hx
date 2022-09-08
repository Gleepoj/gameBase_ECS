package aleiiioa.components.particules;

import h2d.Tile;
import aleiiioa.shaders.PressureShader.SmokeShader;
import h2d.Bitmap;


class BitmapComponent {
    
    public var bitmap:Bitmap;
    public var shader:Dynamic<>;

    
    public function new(_asset:Tile,?_scale:Float = 1,?_rotate:Float = null,?_shader:Dynamic<>=null) {
        
        var tile = _asset;
        tile = tile.center();

        bitmap = new h2d.Bitmap(tile);
        var tex =  bitmap.tile.getTexture();
        
        if(_shader != null){
            shader = new SmokeShader(tex);
            bitmap.addShader(shader);
            bitmap.blendMode = Add;
        }

        bitmap.scaleX *= _scale;
        bitmap.scaleY *= _scale;
        
        
        if(_rotate == null)
           bitmap.rotate((M.frand()*Math.PI*2));
        
        if(_rotate != null)
            bitmap.rotate(_rotate);
         
    }
}