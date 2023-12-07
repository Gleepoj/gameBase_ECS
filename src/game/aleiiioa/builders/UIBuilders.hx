package aleiiioa.builders;

import aleiiioa.components.local.ui.InteractiveMouseComponent;
import aleiiioa.components.local.ui.algo.On_Targeted_Selectable;
import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.local.ui.algo.Currently_Selectable;
import aleiiioa.components.local.ui.UISelectorFlag;
import aleiiioa.components.core.physics.velocity.VelocityComponent;
import aleiiioa.components.core.physics.velocity.AnalogSpeedComponent;
import hxd.Window;
import aleiiioa.components.local.ui.UIButton;
//import aleiiioa.components.local.ui.InteractiveHeapsComponent;
import aleiiioa.components.local.ui.UIObject;
import h2d.ScaleGrid;
import aleiiioa.components.core.rendering.SpriteExtension;
import aleiiioa.components.core.rendering.SquashComponent;
import aleiiioa.components.core.rendering.SpriteComponent;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.local.dialog.DialogReferenceComponent;
import aleiiioa.components.local.dialog.DialogUIBubble;
import aleiiioa.components.local.dialog.DialogUIOptionLayout;
import aleiiioa.components.local.dialog.UIDialog;

import aleiiioa.components.local.dialog.YarnDialogConponent;
import aleiiioa.components.local.dialog.YarnDialogListener;


import aleiiioa.components.utils.helper.*;

class UIBuilders {
    
    ////////ACTORS////////////////
        public static function slider(label : String, get : Void -> Float, set : Float -> Void, min : Float = 0., max : Float = 1.) {
            var usc = new HelperSliderComponent(label,get,set,min,max);
            new echoes.Entity().add(usc);
        }

        public static function check(label : String, get : Void -> Bool, set : Bool -> Void) {
            var ucc = new HelperCheckComponent(label,get,set);
            new echoes.Entity().add(ucc);
        }
        
        public static function debugfloat(label : String, get : Void -> Float, set : Float -> Void) {
            var udf = new HelperDebugFloat(label,get,set);
            new echoes.Entity().add(udf);
        }

        public static function dialogEntity(_yarnFile:DialogReferenceComponent){
            
            var ydc = new YarnDialogConponent(_yarnFile);
            var ydl = new YarnDialogListener(_yarnFile);

            var ui    = new UIDialog();
            var uiBub = new DialogUIBubble();
            var uiOpt = new DialogUIOptionLayout();

            new echoes.Entity().add(ydc,ydl,ui,uiBub,uiOpt);
        }
    

        
    public static function selector(){
        // Make a basic entity with a position and a sprite 
        var pos = new GridPosition(0,0,0,0);
        var spr = new SpriteComponent(D.tiles.pointer);
        var sq  = new SquashComponent();
        var se  = new SpriteExtension();

        var input = new InputComponent();
        var selector = new UISelectorFlag();


        se.sprScaleX = 4;
        se.sprScaleY = 4;

        //Physics Component
        var vc = new VelocityComponent();
        var vas = new AnalogSpeedComponent(0,0);
        spr.visible = false;

        new echoes.Entity().add(pos,spr,sq,se,vc,vas,input,selector);

    }

    public static function menu(e:Entity_UIWindow) {
            //Physics Component
            selector();
            var pos = new GridPosition(e.cx,e.cy,0,0);
            
            //Rendering Component
            var spr = new SpriteComponent(D.tiles.fxDot0);


            var sq  = new SquashComponent();
            var se  = new SpriteExtension();

            var flow = new dn.heaps.FlowBg(Assets.tiles.getTile(D.tiles.ui_window),3,3);
            Game.ME.scroller.add(flow);
            
            flow.layout = Vertical;
            flow.verticalAlign = Middle;
            flow.horizontalAlign = Middle;
            flow.padding = 40;
            flow.verticalSpacing = 2;
            
            var affiliatedID:Array<String> = [] ;
            
            for (en in e.f_Entity_ref){
                affiliatedID.push(en.entityIid);
            }
            

            for (en in Game.ME.level.data.l_Entities.all_UIButton){
                for(a in affiliatedID)
                    if(a == en.iid){
                       UIBuilders.button(en,flow);
                    }
            }
                       
            flow.reflow();
            flow.bg.visible = false;
  
            new echoes.Entity().add(pos,spr,sq,se,flow);
           
        }

   

        public static function button(e:Entity_UIButton,flow:h2d.Flow){
                      
            var pos = new GridPosition(0,0,0,0);
            var spr = new SpriteComponent(D.tiles.fxDot0);
            var sq  = new SquashComponent();
            var se  = new SpriteExtension();     
            spr.visible = true;
            
            //Rendering Component
            
            var g   = new ScaleGrid(Assets.tiles.getTile(D.tiles.ui_button),2,2,flow);
            var v = hxd.Window.getInstance();
            g.width  = v.width/3;
            g.height = v.height/10;

            var txt = new h2d.Text(hxd.res.DefaultFont.get(), g);
            var obj = new UIObject();
            var sel = new Currently_Selectable();
            var m = new InteractiveMouseComponent();

            txt.text = e.f_Label;
            
            txt.setPosition(g.width/2,g.height/5);
            txt.textAlign = Center;
            txt.scale(3);
        

            //var interactive = new InteractiveHeapsComponent();
            var button      = new UIButton(txt);
            button.event = e.f_UI_Button_Event;

            
            if(!e.f_isFirstTargeted)
                new echoes.Entity().add(m,pos,spr,sq,se,g,button,obj,sel);

            if(e.f_isFirstTargeted){
                var tar = new On_Targeted_Selectable();
                new echoes.Entity().add(m,pos,spr,sq,se,g,button,obj,sel,tar);
            }
        } 

        
 /*        public static function flowButton(e:Entity_UIButton,flow:h2d.Flow){
                      
            var pos = new GridPosition(0,0,0,0);
            var spr = new SpriteComponent(D.tiles.fxDot0);
            var sq  = new SquashComponent();
            var se  = new SpriteExtension();     
            spr.visible = true;
            
            //Rendering Component
            
            //var g   = new ScaleGrid(Assets.tiles.getTile(D.tiles.ui_button),2,2,flow);
            var g = new dn.heaps.FlowBg(Assets.tiles.getTile(D.tiles.ui_button),2,2,flow);
            
            g.paddingHorizontal = 5;
            g.paddingVertical   = 2;
            

            var txt = new h2d.Text(hxd.res.DefaultFont.get(), g);
            var obj = new UIObject();



            txt.text = e.f_Label;
  
            var interactive = new InteractiveHeapsComponent();
            var button      = new UIButton(txt);
            button.event = e.f_UI_Button_Event;
 

            new echoes.Entity().add(pos,spr,sq,se,g,interactive,button,obj);
        }  */
    }