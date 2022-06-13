package aleiiioa.systems.dialog;

// Re architecturer 
// Faire un composant dialog qui contient le flow principal 
// Faire deux composant bubble (avec un update texte )/ option qui creer leur propre flow a la creation et s'update par la suite 


import aleiiioa.components.dialog.YarnDialogListener;
import h2d.Flow;
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
        
        b.flow = new h2d.Flow(udc.dialogLayer);
        b.flow.setPosition(600,50);

        b.flow.layout = Vertical;
        b.flow.multiline = true;
        b.flow.reverse = true;
        b.flow.verticalSpacing = 5;
        b.flow.padding = 10;
    
        
        var tile = Assets.tiles.getTile(D.tiles.uiBar);
		b.bubble = new dn.heaps.FlowBg(tile, 2,b.flow);
        
        b.bubble.horizontalSpacing = 5;
        b.bubble.paddingHorizontal = 20;
        b.bubble.paddingVertical = 20;
        b.bubble.colorizeBg(0xA26AE3);

        b.text = new h2d.Text(getFont(),b.bubble);
        b.text.text = "new text";//dial list text
        b.text.maxWidth = 300;
        b.text.textAlign = Left; 

    }

    
    @a public function onOptionAdded(udc:UIDialog,o:UIOption){
        // option is added every option call ? 
        // attention op ne fait pas partie du meme flow
        o.flow = new h2d.Flow(udc.dialogLayer);

        o.flow.layout = Horizontal;
        o.flow.multiline = true;
        o.flow.verticalSpacing = 5;
        o.flow.padding = 10;


    }

    @u public function updateDialogText(ydl:YarnDialogListener,b:UIBubble) {
        if(ydl.onSpeak && !ydl.onPause){
            b.bubble.removeChild(b.text);
            b.text = new h2d.Text(getFont(),b.bubble);
            b.text.text = ydl.text;
            b.text.maxWidth = 300;
            b.text.textAlign = Left; 
            b.bubble.reflow();    
            ydl.cd.setS("pause",0.3);
        }
    }

    private function getFont() {
        return hxd.res.DefaultFont.get();
    }

    @u public function onNewSpeak(b:UIBubble){
      
    /*     b.text = new h2d.Text(getFont(),b.bubble);
        b.text.text = "new text";//dial list text
        b.text.maxWidth = 300;
        b.text.textAlign = Left;  */
          
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
        b.flow.removeChildren();
    }

    @r function onRemoveOption(o:UIOption){
        o.flow.removeChildren();
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

 