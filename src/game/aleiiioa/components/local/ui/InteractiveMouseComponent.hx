package aleiiioa.components.local.ui;

@:forward
abstract InteractiveMouseComponent(h2d.Interactive) from h2d.Interactive to h2d.Interactive {
    public inline function new() {
      this = new h2d.Interactive(32,32);    
    }
}
