package aleiiioa.components.particules;

import h2d.BlendMode;
import h2d.Tile;
import aleiiioa.shaders.PressureShader.SmokeShader;
import h2d.Bitmap;


class BitmapComponent {
    
    public var bitmap:Bitmap;
    public var shader:Dynamic<>;

    
    public function new(_asset:Tile,?_scale:Float = 1,?_rotate:Float = null,?_shader:Dynamic<>=null,?_blend:BlendMode = Alpha) {
        
        var tile = _asset;
        tile = tile.center();

        bitmap = new h2d.Bitmap(tile);
        var tex =  bitmap.tile.getTexture();
        
        if(_shader != null){
            if(_shader == SmokeShader)
                shader = new SmokeShader(tex);
            bitmap.addShader(shader);
        }
        bitmap.blendMode = _blend;
        
        bitmap.scaleX *= _scale;
        bitmap.scaleY *= _scale;   
        
        if(_rotate == null)
           bitmap.rotate((M.frandRange(-Math.PI*2,Math.PI*2)));
        
        if(_rotate != null)
            bitmap.rotate(_rotate);
         
    }
}