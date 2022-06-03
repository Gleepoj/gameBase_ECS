package aleiiioa.systems.ui;

import h2d.Flow.FlowLayout;
import h2d.Flow.FlowAlign;
import aleiiioa.components.ui.UIOptionComponent;
import echoes.View;
import aleiiioa.components.ui.UIDialogComponent;

class UIDialogSystem extends echoes.System {
    
    var fui : h2d.Flow;

    var ALL_DIALOG:View<UIDialogComponent>;
    var ALL_OPTION:View<UIOptionComponent>;
    
    public function new() {
        
        var dialog = new h2d.Layers();
        Game.ME.root.add(dialog,Const.DP_UI);
		dialog.name = "Dialog system";
		
        fui = new h2d.Flow(dialog);
        
        fui.layout = Vertical;
        fui.multiline = true;
        fui.reverse = true;
        fui.verticalSpacing = 5;
        fui.padding = 10;
        
        //SAMPLE USAGE //
        
        //UIBuild.slider("Speed", function() return tf, function(v) tf = v, 0, 10);
        //UIBuild.check("Loop", function() return tv, function(v)  tv = v );
    }

    private function getFont() {
        return hxd.res.DefaultFont.get();
    }

    @a public function onDialogAdded(udc:UIDialogComponent){
        
        if(ALL_DIALOG.entities.head != ALL_DIALOG.entities.tail)
            clearDialogComponent();

        var tile = Assets.tiles.getTile( D.tiles.uiBar );
		var f = new dn.heaps.FlowBg(tile, 2,fui);
		
        //new dn.heaps.FlowBg(t, 2, root);
        f.horizontalSpacing = 5;
        
        f.paddingHorizontal = 20;
        f.paddingVertical = 20;
        
        fui.debug = true;
        if(udc.character == 1){
            fui.setPosition(300,300);
            f.colorizeBg(0xA56DE7);
        }

        if(udc.character == 2){
            fui.setPosition(500,300);
            f.colorizeBg(0x006DE7);
        }
        

        var tf = new h2d.Text(getFont(), f);
        tf.text = udc.text;
        tf.maxWidth = 300;
        tf.textAlign = Left;
          
    }

    @r function onRemove(udc:UIDialogComponent){
        fui.removeChildren();
    }

    private function clearDialogComponent(){
        var head = ALL_DIALOG.entities.head;
        head.value.destroy();
    }

    @a public function onOptionAdded(uoc:UIOptionComponent){
        
        if(ALL_DIALOG.entities.head != ALL_DIALOG.entities.tail)
            clearDialogComponent();
        
        var tile = Assets.tiles.getTile( D.tiles.uiBar );
		var f = new dn.heaps.FlowBg(tile, 2,fui);
		
        f.horizontalSpacing = 5;
        f.paddingHorizontal = 20;
        f.paddingVertical = 20;
        
        fui.debug = true;
        
        //fui.setPosition(300,300);
        f.colorizeBg(0xA56FF7);
        f.reverse = true;
        //f.multiline = true;
        f.horizontalAlign = FlowAlign.Left;
        f.layout = FlowLayout.Horizontal; 
    

        var tf = new h2d.Text(getFont(), f);
        tf.text = uoc.text;
        tf.maxWidth = 300;
        tf.textAlign = Left;
          
    }

    @r function onRemoveOption(uoc:UIOptionComponent){
        fui.removeChildren();
    }

}

 