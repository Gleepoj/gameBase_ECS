package aleiiioa.components;

import h3d.Vector;


@:forward
abstract PixelPosition(h3d.Vector) from h3d.Vector to h3d.Vector {

    public inline function new(x, y) {
        this = new Vector(x,y);
    }

}