package aleiiioa.systems.ui;
import aleiiioa.components.ui.UICheckComponent;
import aleiiioa.builders.UIBuild;
import aleiiioa.components.ui.UISliderComponent;

class HelperSystem extends echoes.System {
    
    var fui : h2d.Flow;
    var tv:Bool;
    var tf:Float;

    public function new() {
        
        var helper = new h2d.Layers();
        Game.ME.root.add(helper,Const.DP_UI);
		helper.name = "Hud system";
		
        fui = new h2d.Flow(helper);
        
        fui.layout = Vertical;
        fui.verticalSpacing = 5;
        fui.padding = 10;
        
        tv = false;
        tf = 0.3;
        UIBuild.slider("Speed", function() return tf, function(v) tf = v, 0, 10);
        UIBuild.check("Loop", function() return tv, function(v)  tv = v );
    }

    private function getFont() {
        return hxd.res.DefaultFont.get();
    }

    @a public function onSliderAdded(usc:UISliderComponent){
        
        var f = new h2d.Flow(fui);
        
        f.horizontalSpacing = 5;
    
        var tf = new h2d.Text(getFont(), f);
        tf.text = usc.label;
        tf.maxWidth = 70;
        tf.textAlign = Right;
    
        var sli = new h2d.Slider(100, 10, f);
        sli.minValue = usc.min;
        sli.maxValue = usc.max;
        sli.value = usc.get();

        var tf = new h2d.TextInput(getFont(), f);
        tf.text = "" + hxd.Math.fmt(sli.value);
        sli.onChange = function() {
            usc.set(sli.value);
            tf.text = "" + hxd.Math.fmt(sli.value);
            f.needReflow = true;
        };
        tf.onChange = function() {
            var v = Std.parseFloat(tf.text);
            if( Math.isNaN(v) ) return;
            sli.value = v;
            usc.set(v);
        };
    }

    @a  function onCheckAdded(ucc:UICheckComponent) {
            var f = new h2d.Flow(fui);
    
            f.horizontalSpacing = 5;
    
            var tf = new h2d.Text(getFont(), f);
            tf.text = ucc.label;
            tf.maxWidth = 70;
            tf.textAlign = Right;
    
            var size = 10;
            var b = new h2d.Graphics(f);
           
            function redraw() {
                b.clear();
                b.beginFill(0x808080);
                b.drawRect(0, 0, size, size);
                b.beginFill(0);
                b.drawRect(1, 1, size-2, size-2);
                if( ucc.get() ) {
                    b.beginFill(0xC0C0C0);
                    b.drawRect(2, 2, size-4, size-4);
                }
            }

            var i = new h2d.Interactive(size, size, b);
            i.onClick = function(_) {
                ucc.set(!ucc.get());
                redraw();
            };
            redraw();
            return i;
        }
    
}

   /*  @a function onButtonAdded(ubc:UIButtonComponent) {
        //label /on click
		var f = new h2d.Flow(fui);
		f.padding = 5;
		f.paddingBottom = 7;
		f.backgroundTile = h2d.Tile.fromColor(0x404040);
		var tf = new h2d.Text(getFont(), f);
		tf.text = ubc.label;
		f.enableInteractive = true;
		f.interactive.cursor = Button;
		f.interactive.onClick = ubc.onClick(); //function(_) onClick();
		f.interactive.onOver = function(_) f.backgroundTile = h2d.Tile.fromColor(0x606060);
		f.interactive.onOut = function(_) f.backgroundTile = h2d.Tile.fromColor(0x404040);
		return f;
	} */








//addSlider("Amount", function() return parts.amount, function(v) parts.amount = v);
//addSlider("Speed", function() return g.speed, function(v) g.speed = v, 0, 10);
//ddSlider("Gravity", function() return g.gravity, function(v) g.gravity = v, 0, 5);
//addCheck("Sort", function() return g.sortMode == Dynamic, function(v) g.sortMode = v ? Dynamic : None);
//addCheck("Loop", function() return g.emitLoop, function(v) { g.emitLoop = v; if( !v ) parts.currentTime = 0; });
//addCheck("Move", function() return moving, function(v) moving = v);
//addCheck("Relative", function() return g.isRelative, function(v) g.isRelative = v);

