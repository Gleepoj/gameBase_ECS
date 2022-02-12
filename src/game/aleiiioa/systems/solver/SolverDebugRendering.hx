package aleiiioa.systems.solver;

import aleiiioa.components.solver.LayerComponent;
import hxsl.Shader;
import h2d.Bitmap;
import aleiiioa.builders.Builders;
import h2d.Graphics;
import aleiiioa.components.solver.CellSpriteBatch;
import aleiiioa.components.solver.CellComponent;
import aleiiioa.systems.shaders.PressureShader;

import h3d.Vector;
import h2d.SpriteBatch.BatchElement;


class SolverDebugRendering extends echoes.System {
    private var game(get,never) : Game; inline function get_game() return Game.ME;
    var level(get,never) : Level; inline function get_level() return Game.ME.level;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);
    
	
    // a resoudre solver manager pour les fonction de test de grille //
    public var solver: FluidSolver;
    public var sbDirections : Array<h2d.SpriteBatch.BatchElement>;
    var gameScroller:h2d.Layers;
    var sb : h2d.SpriteBatch;
    var gr : h2d.Graphics;
    var bitmap:Bitmap;
    var shader:BitmapShader;
    

    public function new(_gameScroller:h2d.Layers,fluidSolver:FluidSolver) {
        this.gameScroller = _gameScroller;
        this.solver = fluidSolver;
        
        
        this.sbDirections = [];
        this.sb = new h2d.SpriteBatch(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID,Const.GRID));
        this.sb.hasRotationScale = true;
        this.gameScroller.add(sb,Const.DP_FRONT);
        this.createCellsComponents();
        Builders.layerComponent(new BitmapShader());
        
    }

    
    @a private function onCellComponentAdded(cc:CellComponent) {
        var vectorBatchElement = makeSpriteBatchVectorElement(cc.i,cc.j);
        sb.add(vectorBatchElement);
        sbDirections.push(vectorBatchElement);
    }

    @a function onLayerAdded(lc:LayerComponent){
        var b = makePressureBitmap();
        lc.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(b));
        lc.shader = new BitmapShader();
		lc.shader.texture = lc.bitmap.tile.getTexture();
		lc.bitmap.addShader(lc.shader);
        lc.bitmap.height = height;
        lc.bitmap.width = width;

        this.gameScroller.add(lc.bitmap,Const.DP_BG);
    }

    @u function refreshLayer(lc:LayerComponent){
        var pressure = makePressureBitmap();
        lc.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(pressure));
        lc.shader.texture = lc.bitmap.tile.getTexture();
    }
    @u function systemUpdate(){
        renderDebugGrid();
    }

    @u function cellUpdate(cc:CellComponent){
        cc.u = solver.u[cc.index];
        cc.v = solver.v[cc.index];
        ccRotateVectorElement(cc);
    } 

    function makePressureBitmap(){
        var bitmapPressure = new hxd.BitmapData(level.cWid, level.cHei);
        for( j in 0...level.cWid ){
        	for( i in 0...level.cHei){
                var index = solver.getIndexForCellPosition(i,j);
                var u = solver.u[index];
                var v = solver.v[index];
                var lenUV = u * u + v * v ;
                var color = new Vector(lenUV,0,1-lenUV,0.5);//Color.makeColorArgb(lenUV,0,1-lenUV,0.5);
           	    bitmapPressure.setPixel(i, j,color.toColor());
            }
        }
        return bitmapPressure;
    }
    
    public function renderDebugGrid() {
        
        if( ui.Console.ME.hasFlag("grid")){
            sb.visible = true;
            
            for(index in 0...sbDirections.length){
                //var uvl = new Vector(solver.u[index],solver.v[index]);
                //colorizePressure(index,uvl);
                //rotateVectorElement(index);//,uvl);
            }
            
            //lightSelectedCells();
            
        } 
        if(!ui.Console.ME.hasFlag("grid"))
            sb.visible = false;
    }

    @r public function dispose(csb:CellSpriteBatch) {
        sb.remove();
        sbDirections = [];
    }

    private function createCellsComponents() {
        for(j in 0...solver.height) {
			for(i in 0...solver.width) {
                var index = solver.getIndexForCellPosition(i,j);
                var cc = new CellComponent(i,j,index);
                new echoes.Entity().add(cc);
            }
        }
    }

    
    private function makeSpriteBatchVectorElement(i:Int,j:Int){
        var vec = new BatchElement(Assets.tiles.getTile(D.tiles.vector12));
        vec.x = i*Const.GRID + Const.GRID/2;
        vec.y = j*Const.GRID + Const.GRID/2;
        vec.rotation = 0;
        return vec;
    }

    function rotateVectorElement(index){
      sbDirections[index].rotation = Math.atan2(solver.v[index],solver.u[index]);   
    }

    
    function ccRotateVectorElement(cc:CellComponent){
        sbDirections[cc.index].rotation = Math.atan2(cc.v,cc.u);   
    }
}
