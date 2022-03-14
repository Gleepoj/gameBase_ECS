package aleiiioa.systems.renderer;

import echoes.View;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.flags.vessel.VesselFlag;
import h3d.Vector;
import aleiiioa.shaders.PressureShader.BeetleShader;
import h2d.Bitmap;

class ShaderRenderer extends echoes.System {
    
    var ALL_VESSELS:View<GridPosition,VesselFlag>;

    var N_POSITIONS:Array<Vector>;

    var scroller:h2d.Layers;
    var level(get,never) : Level; inline function get_level() return Game.ME.level;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);

    var ish(get,never): Float; inline function get_ish() return 1 / height;
	var aspectRatio(get,never):Float ;inline function get_aspectRatio() return width * ish;
    

    var bitmap:Bitmap;
    var shader:BeetleShader;

    public function new(_scroller:h2d.Layers) {
        scroller = _scroller;
        
        N_POSITIONS = [];

        var b = uniBitmap();
        bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(b));
        var tex =  bitmap.tile.getTexture();
        shader = new BeetleShader(tex,50);
        
		for(i in 0...5){
			shader.positions.push(new Vector(Math.random(),Math.random()));
		}
        
        bitmap.addShader(shader);
        bitmap.height = height;
        bitmap.width = width;
        bitmap.alpha = 0.5;
        scroller.add(bitmap,Const.DP_FX_BG);

    }

    @u function updateVesselShade() {
        
        var head = ALL_VESSELS.entities.head;
        N_POSITIONS = [];
        shader.positions = [];
        while (head != null){
            var vessel = head.value;
            var vec = vessel.get(GridPosition).gpToVector();
            var nvec = getNormalizePos(vec);
            N_POSITIONS.push(nvec);
            head = head.next;
        }
        shader.positions = [];
        shader.positions = N_POSITIONS;
    }
    /* 
    @r function clear(){
        shader.positions = [];
    } */

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