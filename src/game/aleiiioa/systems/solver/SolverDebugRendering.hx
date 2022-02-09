package aleiiioa.systems.solver;

import hxsl.Shader;
import h2d.Bitmap;
import aleiiioa.components.solver.BitmapComponent;
import aleiiioa.builders.Builders;
import h2d.Graphics;
import aleiiioa.components.solver.CellSpriteBatch;
import aleiiioa.components.solver.CellComponent;

import h3d.Vector;
import h2d.SpriteBatch.BatchElement;


class SolverDebugRendering extends echoes.System {
    private var game(get,never) : Game; inline function get_game() return Game.ME;
    var level(get,never) : Level; inline function get_level() return Game.ME.level;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);
    
	
    // a resoudre solver manager pour les fonction de test de grille //
    var solver: FluidSolver;
   // var selectedCells:Array<Int>;
    
    var gameScroller:h2d.Layers;
    var sb : h2d.SpriteBatch;
    var sbCells : Array<h2d.SpriteBatch.BatchElement>;
    var sbDirections : Array<h2d.SpriteBatch.BatchElement>;
    var gr : h2d.Graphics;
    var bitmap:Bitmap;
    

    public function new(_gameScroller:h2d.Layers,_fluidSolver:FluidSolver) {
        this.gameScroller = _gameScroller;
        this.solver = _fluidSolver;
        
        this.sbCells = [];
        this.sbDirections = [];
        this.sb = new h2d.SpriteBatch(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID,Const.GRID));
       
        var b = createBitmapComponent();
        this.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(b));
        var shader = new PressureShader();
        shader.speed = 1;
		shader.amplitude = .1;
		shader.frequency = 1;
		shader.texture = this.bitmap.tile.getTexture();
		this.bitmap.addShader(shader);

        
                //drawGridGraphics();
        
        
        this.bitmap.height = height;
        this.bitmap.width = width;
        

        this.gameScroller.add(this.bitmap,Const.DP_BG);
    }

    public function createBitmapComponent() {
        var bmpData = new hxd.BitmapData(solver.width, solver.height);
        for( x in 0...solver.width ){
        	for( y in 0...solver.height){
           	 bmpData.setPixel(x, y, 0xFF000000 | (x * 4) | ((y * 4) << 8));
            }
        }
        Builders.bitmapComponent(bmpData,solver.width, solver.height);
        return bmpData;
    }

    @u function refreshBitmapVelocity(bmpData:BitmapComponent){
        for( j in 0...solver.height ){
        	for( i in 0...solver.width){
                var index = solver.getIndexForCellPosition(i,j);
                var u = solver.u[index];
                var v = solver.v[index];
                var len = Math.sqrt(u * u + v * v );
                var color =  Color.makeColorRgb(len,0,len - v);
           	    bmpData.solverBmp.setPixel(i, j, color);
            }
        }

    }
    
    public function renderDebugGrid() {
        
        if( ui.Console.ME.hasFlag("grid")){
            sb.visible = true;
            
            for(index in 0...sbCells.length){
                //var uvl = new Vector(solver.u[index],solver.v[index]).lengthSq();
                //colorizePressure(index,uvl);
                //rotateVectorElement(index,uvl);
            }
            
            //lightSelectedCells();
            
        } 
        if(!ui.Console.ME.hasFlag("grid"))
            sb.visible = false;
    }

    @r public function dispose(csb:CellSpriteBatch) {
        sb.remove();
        sbCells = [];
        sbDirections = [];
    }

    private function createCellComponents() {
        for(j in 0...solver.height) {
			for(i in 0...solver.width) {
                var cc = new CellComponent(i,j);
                new echoes.Entity().add(cc);
            }
        }
    }

    @a private function onCellComponentAdded(cc:CellComponent) {
        //var cellBatchElement = makeSpriteBatchCellElement(cc.i,cc.j);
        //sb.add(cellBatchElement);
        //sbCells.push(cellBatchElement);
        //var vectorBatchElement = makeSpriteBatchVectorElement(cc.i,cc.j);
        //sb.add(vectorBatchElement);
        //sbDirections.push(vectorBatchElement);

    }
    
    private function makeSpriteBatchCellElement(i:Int,j:Int){
        var squareCell = new BatchElement(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID-1,Const.GRID-1));
                squareCell.x = i*Const.GRID;
                squareCell.y = j*Const.GRID;
                squareCell.a = 0.3;
        return squareCell;      
    }

    private function makeSpriteBatchVectorElement(i:Int,j:Int){
        var vec = new BatchElement(Assets.tiles.getTile(D.tiles.vector12));
        vec.x = i*Const.GRID + Const.GRID/2;
        vec.y = j*Const.GRID + Const.GRID/2;
        vec.rotation = 0;
        return vec;
    }

    public function drawGridGraphics() {
        this.gr.clear();
        var cgt:h2d.Tile = h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID,Const.GRID);
        var vect:h2d.Tile = Assets.tiles.getTile(D.tiles.vector12);
        for(j in 0...solver.height) {
			for(i in 0...solver.width) {
                this.gr.beginTileFill(i*Const.GRID,j*Const.GRID,cgt);
                this.gr.drawRect(i*cgt.width+1, j*cgt.height+1, cgt.width-1, cgt.height-1);
                this.gr.beginTileFill(i*Const.GRID + Const.GRID/2,j*Const.GRID + Const.GRID/2,vect);
                this.gr.drawRect(i*cgt.width, j*cgt.height, cgt.width, cgt.height);
                this.gr.endFill();
                //this.gr.drawToTextures(this.texture);
                //this.gr.alpha = 0.3;
            }
        }
    }

    /* private function rotateVectorElement(index:Int,lenghtUV:Float) {
        sbDirections[index].rotation = Math.atan2(solver.v[index],solver.u[index]);
        sbDirections[index].a = lenghtUV;     
    }
    
    private function colorizePressure(index:Int,lenghtUV:Float){
        sbCells[index].r = lenghtUV;
        sbCells[index].g = 0;
        sbCells[index].b = 1-lenghtUV;
    }

    private function turnOffCellVisibility(index:Int) {
        sbCells[index].visible = false;
    }

    private function lightSelectedCells() {
        
        for (index in selectedCells){
            if(solver.checkIfIndexIsInArray(index)){
                sbCells[index].r = 1;
                sbCells[index].g = 1;
                sbCells[index].b = 1;
            }
        }
    }
 */
}

class PressureShader extends hxsl.Shader {
    static var SRC = {
        @:import h3d.shader.Base2d;
        
        @param var texture : Sampler2D;
        @param var speed : Float;
        @param var frequency : Float;
        @param var amplitude : Float;
        
        function fragment() {
            calculatedUV.y = calculatedUV.y;
            calculatedUV.x = calculatedUV.y; 
            pixelColor = texture.get(calculatedUV);
        }
    }   
}