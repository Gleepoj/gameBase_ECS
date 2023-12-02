package aleiiioa.systems.local.ui.selector;

import aleiiioa.components.local.ui.UIObject;
import aleiiioa.components.local.ui.InteractiveHeapsComponent;
import aleiiioa.components.core.physics.position.GridPosition;
import h2d.ScaleGrid;
import aleiiioa.components.logic.interaction.InteractionListener;
import aleiiioa.components.core.rendering.SpriteComponent;
import aleiiioa.components.local.ui.UISelectorFlag;



class SelectorRenderer extends echoes.System {
    var current_sw:Float = 0;
    var current_sh:Float = 0;
    public function new() {
        
    }

    @u function highLightCursor(select:UISelectorFlag,spr:SpriteComponent,cl:InteractionListener,sc:ScaleGrid,gp:GridPosition){
   /*      if(!cl.overInteractive)
           spr.uncolorize();
        
        if(cl.overInteractive){
           spr.colorize(0x0b704d);
           sc.width  = current_sw*2;
           sc.height = current_sh*2;
           //trace('$current_sh :: $current_sw');
        } */

        //sc.setPosition(gp.attachX ,gp.attachY - current_sh);
    }

    
    @u function highLiffhtCursor(select:InteractiveHeapsComponent,sc:ScaleGrid,cl:InteractionListener,ui:UIObject){
 /*        if(!cl.overInteractive)
            sc.color.r = 0;
        
        if(cl.overInteractive){
            sc.color.r = 1; 
            current_sh = sc.height;
            current_sw = sc.width;
        } */
    }

}