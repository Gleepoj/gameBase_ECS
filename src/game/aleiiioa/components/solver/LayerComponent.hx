package aleiiioa.components.solver;

import aleiiioa.shaders.PressureShader.BitmapShader;
import h2d.Tile;
import h2d.Bitmap;

class LayerComponent {
    public var bitmap:Bitmap;
    public var shader:BitmapShader;

    public function new(_shader:BitmapShader) {
        this.shader = _shader;
        this.bitmap = new Bitmap(Tile.fromColor(Color.makeColorArgb(1,1,1,1)));
    }

}