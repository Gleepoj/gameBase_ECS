package aleiiioa.components.solver;

import aleiiioa.systems.shaders.PressureShader.BitmapShader;
import h2d.Tile;
import h2d.filter.Shader;
import h2d.Bitmap;
import format.abc.Data.IName;
import hxd.BitmapData;
import aleiiioa.systems.shaders.*;
import aleiiioa.systems.shaders.*;

class LayerComponent {
    public var bitmap:Bitmap;
    public var shader:BitmapShader;

    public function new(_shader:BitmapShader) {
        this.shader = _shader;
        this.bitmap = new Bitmap(Tile.fromColor(Color.makeColorArgb(1,1,1,1)));
    }

}