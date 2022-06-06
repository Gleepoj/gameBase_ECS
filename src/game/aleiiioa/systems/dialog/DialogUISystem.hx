package aleiiioa.systems.dialog;

// Re architecturer 
// Faire un composant dialog qui contient le flow principal 
// Faire deux composant bubble (avec un update texte )/ option qui creer leur propre flow a la creation et s'update par la suite 


import aleiiioa.components.dialog.UIOption;
import aleiiioa.components.dialog.UIDialog;
import aleiiioa.components.dialog.UIBubble;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.ui.DialogComponent;
import echoes.View;

import h2d.Flow.FlowLayout;
import h2d.Flow.FlowAlign;

import aleiiioa.components.ui.UIOptionComponent;
import aleiiioa.components.ui.UIDialogComponent;

class DialogUISystem extends echoes.System {
    
    //var fbubble : h2d.Flow;
    //var foption : h2d.Flow;

    var ALL_DIALOG:View<UIDialogComponent>;
    var ALL_OPTION:View<UIOptionComponent>;
    
    public function new() {
        
      //  var dialog = new h2d.Layers();
        //Game.ME.root.add(dialog,Const.DP_UI);
		//dialog.name = "Dialog system";
		/* 
        fbubble = new h2d.Flow(dialog);
        
        fbubble.layout = Vertical;
        fbubble.multiline = true;
        fbubble.reverse = true;
        fbubble.verticalSpacing = 5;
        fbubble.padding = 10;
        

        var options = new h2d.Layers();
        Game.ME.root.add(options,Const.DP_UI);
		options.name = "Dialog system";
		
        foption = new h2d.Flow(dialog);
        
        foption.layout = Horizontal;
        foption.multiline = true;
        foption.verticalSpacing = 5;
        foption.padding = 10; */
        
        //SAMPLE USAGE //       
        //UIBuild.slider("Speed", function() return tf, function(v) tf = v, 0, 10);
        //UIBuild.check("Loop", function() return tv, function(v)  tv = v );
    }

    @a public function onBubbleAdded(udc:UIDialog,b:UIBubble){
        //bubble is added one and then update//
        b.bubble = new h2d.Flow(udc.dialogLayer);
        
        b.bubble.layout = Vertical;
        b.bubble.multiline = true;
        b.bubble.reverse = true;
        b.bubble.verticalSpacing = 5;
        b.bubble.padding = 10;


    }

    
    @a public function onOptionAdded(udc:UIDialog,o:UIOption){
        // option is added every option call ? 
        // attention op ne fait pas partie du meme flow
        o.option = new h2d.Flow(udc.dialogLayer);
        
        o.option.layout = Horizontal;
        o.option.multiline = true;
        o.option.verticalSpacing = 5;
        o.option.padding = 10;


    }

    private function getFont() {
        return hxd.res.DefaultFont.get();
    }

    @u public function onNewSpeak(udc:UIDialogComponent){
        
       /*  fbubble.setPosition(600,100);

        
        if(ALL_DIALOG.entities.head != ALL_DIALOG.entities.tail)
            clearDialogComponent();

        var tile = Assets.tiles.getTile( D.tiles.uiBar );
		var f = new dn.heaps.FlowBg(tile, 2,fbubble);
        f.horizontalSpacing = 5;
        f.paddingHorizontal = 20;
        f.paddingVertical = 20;
        f.colorizeBg(0xA26AE3);
 */
        /* if(udc.character == 1){
            fbubble.setPosition(300,300);
            f.colorizeBg(0xA56DE7);
        }

        if(udc.character == 2){
            fbubble.setPosition(500,300);
            f.colorizeBg(0x006DE7);
        } */
        
/* 
        var tf = new h2d.Text(getFont(), f);
        tf.text = udc.text;
        tf.maxWidth = 300;
        tf.textAlign = Left; */
          
    }

    @u public function onAskOption(uoc:UIOptionComponent){
       /*  
        var tile = Assets.tiles.getTile(D.tiles.uiBar);
		var f = new dn.heaps.FlowBg(tile,2,foption);
		
        foption.setPosition(fbubble.x,fbubble.y + fbubble.outerHeight);

        f.horizontalSpacing = 5;
        f.paddingHorizontal = 20;
        f.paddingVertical = 20;
        
        f.colorizeBg(0xA56FF7);
        
    
        f.reverse = true;
        f.horizontalAlign = FlowAlign.Right;
        f.layout = FlowLayout.Horizontal; 
    

        var tf = new h2d.Text(getFont(), f);
        tf.text = uoc.text;
        tf.maxWidth = 300;
        tf.textAlign = Left;

        uoc.flowObject = f;
        */   
    }

    @u function colorizeOption(uoc:UIOptionComponent){
       
        uoc.flowObject.colorizeBg(0xA56FF7);

        if(uoc.isSelected)
            uoc.flowObject.colorizeBg(0xFF6F44);

    }

    
    @r function onRemoveBubble(b:UIBubble){
        b.bubble.removeChildren();
    }

    @r function onRemoveOption(o:UIOption){
        o.option.removeChildren();
    }

    @r function onRemoveYarnDialogue(yd:DialogComponent){
        clearOptionComponent();
    }

    private function clearDialogComponent(){
        var head = ALL_DIALOG.entities.head;
        head.value.destroy();
    }

    private function clearOptionComponent(){
        while (ALL_OPTION.size() > 0) {
         var head = ALL_OPTION.entities.head;
         head.value.destroy();
        }
    }
}

 