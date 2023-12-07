package aleiiioa.components.local.ui;

@:forward
abstract UIMouse_Interactive_Component(h2d.Interactive) from h2d.Interactive to h2d.Interactive {
    public inline function new() {
      this = new h2d.Interactive(32,32);    
    }
}
