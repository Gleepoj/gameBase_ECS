package aleiiioa.systems.shaders;

import h2d.Bitmap;
import hxsl.*;
import h3d.shader.*;
import h3d.shader.Base2d;
import aleiiioa.systems.shaders.PressureShader;


class TestShaders {
    var game(get,never) : Game; inline function get_game() return Game.ME;
    var level(get,never) : Level; inline function get_level() return Game.ME.level;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);
    var bitmap:Bitmap;
    var gameScroller:h2d.Layers;
    var shader:BitmapShader;
    public function new(_gameScroller:h2d.Layers) {

        this.gameScroller = _gameScroller;

        //var b = gradientBitmap();
        var b = uniBitmap();
        bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(b));
        shader = new BitmapShader();
        shader.texture = bitmap.tile.getTexture();
        
        bitmap.addShader(shader);
        gameScroller.add(bitmap,Const.DP_FRONT);
        bitmap.height = height;
        bitmap.width = width;
    }
    
    public function gradientBitmap() {
        var bmpData = new hxd.BitmapData(level.cWid, level.cHei);
        for( x in 0...level.cWid ){
        	for( y in 0...level.cHei){
           	 bmpData.setPixel(x, y, 0xFF000000 | (x * 4) | ((x * 4) << 8));
            }
        }
        return bmpData;
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

    public function update() {
        var gradient = gradientBitmap();
        bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(gradient));
        shader.texture = bitmap.tile.getTexture();
    }
}
