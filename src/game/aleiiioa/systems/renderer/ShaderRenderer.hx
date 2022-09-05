package aleiiioa.systems.renderer;

import h3d.shader.AlphaChannel;
import aleiiioa.shaders.PressureShader.PerlinNoiseShader;
import h2d.Layers;
import aleiiioa.shaders.PressureShader.BeetleShader;
import echoes.View;
import h3d.Vector;
import h2d.Bitmap;

class ShaderRenderer extends echoes.System {
    

    var scroller:h2d.Layers;
    var level(get,never) : Level; inline function get_level() return Game.ME.level;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);

    var ish(get,never): Float; inline function get_ish() return 1 / height;
	var aspectRatio(get,never):Float ;inline function get_aspectRatio() return width * ish;
    

    var bitmap:Bitmap;
    var shader:BeetleShader;
    //var shader:PerlinNoiseShader;
    var layer : Layers;

    public function new(_scroller:h2d.Layers) {
        scroller = _scroller;
        
        layer = new h2d.Layers();
        Game.ME.root.add(layer,Const.DP_BG);
		layer.name = "VFX";

        var b = uniBitmap();
        
        for(i in 0...20){
            //bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(b));
            bitmap = new h2d.Bitmap(Assets.alpha);
            var tex =  bitmap.tile.getTexture();
            shader = new BeetleShader(tex);
            //shader = new PerlinNoiseShader(tex);
            
            bitmap.addShader(shader);
            bitmap.height = 532;
            bitmap.width  = 532;
            //bitmap.alpha = 0.5;
            bitmap.blendMode = Add;
            bitmap.x = M.frand()*1000;
            bitmap.y = M.frand()*1000;
            layer.add(bitmap);
        }
    }

    public function getNormalizePos(vector:Vector){
        return new Vector((vector.x/width)*aspectRatio,(vector.y/height)-0.005);
    }

    public function uniBitmap() {
        var bmpData = new hxd.BitmapData(level.cWid, level.cHei);
        for( x in 0...level.cWid ){
        	for( y in 0...level.cHei){
           	 bmpData.setPixel(x, y, 0xffff0000);
            }
        }
        return bmpData;
    }
}