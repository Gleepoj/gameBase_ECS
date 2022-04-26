package aleiiioa.systems.renderer;

import hxd.Math;
import hxd.BitmapData;
import h2d.Bitmap;
import h3d.Vector;
import h2d.SpriteBatch.BatchElement;


import echoes.Entity;
import aleiiioa.builders.Builders;

import aleiiioa.components.core.camera.FluidScrollerComponent;
import aleiiioa.components.core.position.GridPosition;

import aleiiioa.components.solver.CellComponent;
import aleiiioa.components.solver.LayerComponent;

import aleiiioa.shaders.PressureShader;



class SolverDebugRenderer extends echoes.System {
    
    var level(get,never) : Level; inline function get_level() return Game.ME.level;
    var game(get,never) : Game; inline function get_game() return Game.ME;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);
    
    var sbDirections : Array<h2d.SpriteBatch.BatchElement>;
    var gameScroller:h2d.Layers;
    var sb : h2d.SpriteBatch;
    var pressureBitmap:BitmapData;
    var bitmap:Bitmap;
    var shader:BitmapShader;
    var scrollGridPosition:GridPosition;

    public function new(_gameScroller:h2d.Layers) {
        this.gameScroller = _gameScroller;    
        this.sbDirections = [];
        this.sb = new h2d.SpriteBatch(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID,Const.GRID));
        this.sb.hasRotationScale = true;
        this.gameScroller.add(sb,Const.DP_FRONT);
        Builders.layerComponent(new BitmapShader());        
    }

    
    @a private function onCellComponentAdded(cc:CellComponent) {
        var vectorBatchElement = makeSpriteBatchVectorElement(cc.i,cc.j);
        sb.add(vectorBatchElement);
        sbDirections.push(vectorBatchElement);
    }

    @a function onLayerAdded(lc:LayerComponent){
        pressureBitmap = new hxd.BitmapData(level.cWid, Const.FLUID_MAX_HEIGHT);
        lc.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(pressureBitmap));
        lc.bitmap.scaleX = width/level.cWid;
        lc.bitmap.scaleY = height/level.cHei;
        this.gameScroller.add(lc.bitmap,Const.DP_BG);

        scrollGridPosition = null;
    }

    @u function systemUpdate(){
        pressureBitmap.dispose();
        pressureBitmap = new hxd.BitmapData(level.cWid, Const.FLUID_MAX_HEIGHT);
        
        if( ui.Console.ME.hasFlag("grid")){
            sb.visible = true;
        } 
        if(!ui.Console.ME.hasFlag("grid"))
            sb.visible = false;
    }

    @a function getScrollerPosition(en:echoes.Entity,scr:FluidScrollerComponent) {
        scrollGridPosition = en.get(GridPosition);
    }

    @u function updatePressureBitmapFromCell(cc:CellComponent,gp:GridPosition) {
        var uv  = new Vector(cc.u,cc.v);
        var uvl = uv.length();
        var col = new Vector(uvl + uv.y,uvl,uvl-uv.y,0.5);
        pressureBitmap.setPixel(cc.i, cc.j,col.toColor());

    }


    @u function updateSpriteBatchDebug(cc:CellComponent,gp:GridPosition) {
        
        if( ui.Console.ME.hasFlag("grid")){
            if(sb.visible && cc.index < sbDirections.length){
                sbDirections[cc.index].rotation = Math.atan2(cc.v,cc.u);
                sbDirections[cc.index].y = gp.attachY;
            }
        }    
    }

    @u function refreshLayer(lc:LayerComponent){
        
        lc.bitmap.remove();
        lc.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(pressureBitmap));
        lc.bitmap.scaleX = width/level.cWid;
        lc.bitmap.scaleY = height/level.cHei;
       
        if(scrollGridPosition != null)
            lc.bitmap.setPosition(0,scrollGridPosition.attachY);
     

        gameScroller.add(lc.bitmap,Const.DP_BG);
    }

    @r function onLayerRemoved(lc:LayerComponent){
        lc.bitmap.remove();
    }


    
    private function makeSpriteBatchVectorElement(i:Int,j:Int){
        var vec = new BatchElement(Assets.tiles.getTile(D.tiles.vector12));
        vec.x = i*Const.GRID + Const.GRID/2;
        vec.y = j*Const.GRID + Const.GRID/2;
        vec.rotation = 0;
        return vec;
    }
 

}
