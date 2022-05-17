package aleiiioa.systems.renderer;

import aleiiioa.shaders.StreamlineShader;
import hxd.BitmapData;
import h2d.Bitmap;
import h3d.Vector;


import echoes.Entity;
import aleiiioa.builders.Builders;

import aleiiioa.components.solver.CellComponent;
import aleiiioa.components.solver.LayerComponent;

import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.core.camera.FluidScrollerComponent;

import aleiiioa.shaders.PressureShader;

class StreamlineRenderer extends echoes.System {
    
    var scroller:h2d.Layers;
    var level(get,never) : Level; inline function get_level() return Game.ME.level;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);

    var ish(get,never): Float; inline function get_ish() return 1 / height;
	var aspectRatio(get,never):Float ;inline function get_aspectRatio() return width * ish;
    
    var gameScroller:h2d.Layers;
    
    var pressureBitmap:BitmapData;
    var bitmap:Bitmap;
    var shader:BitmapShader;
    var streamlineShader:StreamlineShader;
    
    var scrollGridPosition:GridPosition;

    public function new(_scroller:h2d.Layers) {
        this.gameScroller = _scroller;    
        //streamlineShader = new StreamlineShader();
        Builders.layerComponent(new BitmapShader()); 
    }
    
    @a function onLayerAdded(lc:LayerComponent){
       
        pressureBitmap = new hxd.BitmapData(level.cWid, Const.FLUID_MAX_HEIGHT);
        lc.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(pressureBitmap));
        lc.bitmap.scaleX = width/level.cWid;
        lc.bitmap.scaleY = height/level.cHei;

        var tex =  lc.bitmap.tile.getTexture();
        streamlineShader = new StreamlineShader(tex);

        lc.bitmap.addShader(streamlineShader);
        this.gameScroller.add(lc.bitmap,Const.DP_BG);
        
        scrollGridPosition = null;
    }

    @a function getScrollerPosition(en:echoes.Entity,scr:FluidScrollerComponent) {
        scrollGridPosition = en.get(GridPosition);
    }

    @u function systemUpdate(){
        pressureBitmap.dispose();
        pressureBitmap = new hxd.BitmapData(level.cWid, Const.FLUID_MAX_HEIGHT);
        
    }
   
    @u function updatePressureBitmapFromCell(cc:CellComponent) {
        var uv  = new Vector(cc.u,cc.v);
        var uvl = uv.length();
        var col = new Vector(uvl + uv.y,uvl,uvl-uv.y,0.5);
        pressureBitmap.setPixel(cc.i, cc.j,col.toColor());

    }

    @u function refreshLayer(lc:LayerComponent){
        
        lc.bitmap.remove();
        lc.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(pressureBitmap));
        lc.bitmap.scaleX = width/level.cWid;
        lc.bitmap.scaleY = height/level.cHei;
       
        if(scrollGridPosition != null)
            lc.bitmap.setPosition(0,scrollGridPosition.attachY);
        
        var tex =  lc.bitmap.tile.getTexture();
        streamlineShader.texture = tex;
        lc.bitmap.addShader(streamlineShader);
        
        gameScroller.add(lc.bitmap,Const.DP_BG);
    }

    @r function onLayerRemoved(lc:LayerComponent){
        lc.bitmap.remove();
    }

}