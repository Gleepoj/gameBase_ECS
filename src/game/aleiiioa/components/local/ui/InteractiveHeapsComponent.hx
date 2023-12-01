package aleiiioa.components.core.local.ui;

@:forward
abstract InteractiveHeapsComponent(h2d.Interactive) from h2d.Interactive to h2d.Interactive {
    public inline function new() {
      this = new h2d.Interactive(32,32);    
    }
}
