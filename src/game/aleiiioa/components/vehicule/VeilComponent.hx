package aleiiioa.components.vehicule;

import h3d.Vector;

class VeilComponent {
    public var dotProduct:Float;
    public var anchor:Vector;
    public var extremity:Vector;
    public var normalizeOrientation:Vector;
    public var normalizeUV:Vector;

    public function new() {
        dotProduct = 0;
        anchor = new Vector();
        extremity = new Vector();
        normalizeOrientation = new Vector();
        normalizeUV = new Vector();
    }
}