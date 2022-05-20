package aleiiioa.systems.renderer;

import aleiiioa.components.flags.cell.OnScreenFlag;
import aleiiioa.components.core.camera.CameraFocusComponent;
import h2d.filter.Blur;
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
    
    var bitmapLayer:h2d.Layers;

    var pressureBitmap:BitmapData;
    var bitmap:Bitmap;
    var shader:BitmapShader;
   
    var streamlineShader:StreamlineShader;
    
    var onScreenFluidGridPosition:GridPosition;
    

    public function new(_scroller:h2d.Layers) {
       // this.gameScroller = _scroller;    
        bitmapLayer = new h2d.Layers();
        
        Game.ME.root.add(bitmapLayer,Const.DP_BG);
		bitmapLayer.name = "Color Solver Bitmap";

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
        bitmapLayer.add(lc.bitmap,Const.DP_BG);
        //this.gameScroller.add(lc.bitmap,Const.DP_BG);
       
        onScreenFluidGridPosition  = null;
    }

    @a function getScrollerPosition(en:echoes.Entity,foc:CameraFocusComponent) {
        onScreenFluidGridPosition = en.get(GridPosition);
    }


    @u function systemUpdate(){
        pressureBitmap.dispose();
        pressureBitmap = new hxd.BitmapData(level.cWid, Const.FLUID_ONSCREEN_HEIGHT);  
        
    }
   
    @u function updatePressureBitmapFromCell(cc:CellComponent,onScreen:OnScreenFlag) {
        
        var uv  = new Vector(cc.u,cc.v);
        var uvl = uv.length();
        var uvn = uv.normalized();
        var b = new Vector(0.5,0.5,1,1);
        var n = uvn.multiply(0.5);
        var color = b.add(n);
       
        pressureBitmap.setPixel(cc.i, cc.j-Const.FLUID_OFFSCREEN_TOP,color.toColor());

    }

    @u function refreshLayer(lc:LayerComponent){
        
        lc.bitmap.remove();
        lc.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(pressureBitmap));
        lc.bitmap.scaleX = width/level.cWid;
        lc.bitmap.scaleY = height/level.cHei;
       
        lc.bitmap.setPosition(Game.ME.scroller.x,0);
       
        var tex =  lc.bitmap.tile.getTexture();
        streamlineShader.wind = tex;
        lc.bitmap.addShader(streamlineShader);
       
        bitmapLayer.add(lc.bitmap,Const.DP_BG);
    }

    @r function onLayerRemoved(lc:LayerComponent){
        lc.bitmap.remove();
    }

}