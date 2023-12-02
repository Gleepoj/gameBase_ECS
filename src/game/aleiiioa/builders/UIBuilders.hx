package aleiiioa.builders;

import aleiiioa.components.local.ui.UIButton;
import aleiiioa.components.local.ui.InteractiveHeapsComponent;
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

    public static function menu(e:Entity_UIWindow) {
            //Physics Component
            
            var pos = new GridPosition(e.cx,e.cy,0,0);
            
            //Rendering Component
            var spr = new SpriteComponent(D.tiles.fxDot0);


            var sq  = new SquashComponent();
            var se  = new SpriteExtension();

            var flow = new dn.heaps.FlowBg(Assets.tiles.getTile(D.tiles.ui_window),3,3);
            Game.ME.scroller.add(flow);
       
            //flow.debug = true;
            
            flow.layout = Vertical;
            flow.verticalAlign = Middle;
            flow.horizontalAlign = Middle;
            flow.padding = 60;
            flow.verticalSpacing = 20;
            
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
           

            //var affiliatedID:Array<String> = [] ;

 /*            for (en in e.f_menu ){
                affiliatedID.push(en.entityIid);
            }

            for (en in Game.ME.level.data.l_Entities.all_UISlider){
                for(a in affiliatedID)
                    if(a == en.iid){
                       // trace("slider");
                       UIBuilders.uiSettingSlider(en,flow);
                    }
            }
            
      
 */

            
            flow.reflow();
            //flow.debug = true;
           // flow.visible = false;
            new echoes.Entity().add(pos,spr,sq,se,flow);
        } 

        public static function button(e:Entity_UIButton,flow:h2d.Flow){
                      
            var pos = new GridPosition(0,0,0,0);
            var spr = new SpriteComponent(D.tiles.fxDot0);
            var sq  = new SquashComponent();
            var se  = new SpriteExtension();     
            spr.visible = true;
            
            //Rendering Component
            
            //var g   = new ScaleGrid(Assets.tiles.getTile(D.tiles.ui_button),2,2,flow);
            var g = new dn.heaps.FlowBg(Assets.tiles.getTile(D.tiles.ui_button),2,2,flow);
            
         /*    g.borderBottom = 10;
            g.borderHeight = 10;
            g.borderLeft = 20;
            g.borderRight = 20; */
           
       
            g.paddingHorizontal = 30;
            g.paddingVertical   = 10;
            //g.innerWidth   = 200;

            var txt = new h2d.Text(hxd.res.DefaultFont.get(), g);
            var obj = new UIObject();



            txt.text = e.f_Label;
            //trace(txt.text);

            //g.ignoreScale = true;
            //g.tileBorders = true;
            
            //g.height = e.height;
            //g.width  = txt.calcTextWidth(txt.text)+30;
            
            //txt.setPosition(g.width/2,g.height/4);
            //txt.textAlign = Center;
            
            //g.scaleX = 2;
            //g.scaleY = 2;

            var interactive = new InteractiveHeapsComponent();
            var button      = new UIButton(txt);
            button.event = e.f_UI_Button_Event;
 

            new echoes.Entity().add(pos,spr,sq,se,g,interactive,button,obj);
        } 
    }