package aleiiioa.systems.utils;

import aleiiioa.components.utils.helper.HelperDebugFloat;
import aleiiioa.components.utils.helper.HelperCheckComponent;
import aleiiioa.components.utils.helper.HelperSliderComponent;


//SAMPLE USAGE // Could be use everywhere in code 
        
//UIBuild.slider("Speed", function() return speed, function(v) speed = v, 0, 10);
//UIBuild.check("Button", function() return button, function(v)  button = v );
//UIBuilders.debugfloat("player_wcx ::",function()return player_world_cx,function(v) player_world_cx = v);

class UIHelperSystem extends echoes.System {
    
    var fui : h2d.Flow;
    
    public function new() {
        
        var helper = new h2d.Layers();
        Game.ME.root.add(helper,Const.DP_UI);
		helper.name = "Hud system";
		
        fui = new h2d.Flow(helper);
        
        fui.layout = Vertical;
        fui.verticalSpacing = -2;
        fui.padding = 10;
        
    }

    private function getFont() {
        return hxd.res.DefaultFont.get();
    }

    @a public function onDebugFloatAdded(df:HelperDebugFloat){
        
        var f = new h2d.Flow(fui);
        
        f.horizontalSpacing = 5;
        //f.paddingLeft = 40;
        //f.
        var i = new h2d.Interactive(200, 25, f);
        i.backgroundColor =0xFF6A5151;
        i.alpha =0.5;
        i.blendMode = AlphaAdd;

        var tf = new h2d.Text(getFont(), i);
        //tf.textAlign = Center;
        tf.blendMode = Alpha;
        tf.text = ":: " + df.label + " ::-> " + df.get();
        tf.dropShadow = { dx: 1, dy: 1, color: 0, alpha: 1 };
        tf.maxWidth = 70;
        tf.textAlign = Left;
        df.text = tf;

    

        //df.flow = f;

    }

    @u public function updateDebugFloat(df:HelperDebugFloat){

        df.text.text = "::" + df.label + "::->" + df.get();

    }

    @a public function onSliderAdded(usc:HelperSliderComponent){
        
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

    @a  function onCheckAdded(ucc:HelperCheckComponent) {
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
        }
    
}

 