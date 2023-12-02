package aleiiioa.builders;

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

            var flow = new h2d.Flow(spr);

            flow.backgroundTile = Assets.tiles.getTile(D.tiles.ui_window);
            flow.borderWidth =16;
            flow.borderHeight=16;
            //flow.debug = true;
            
            flow.layout = Vertical;
            flow.verticalAlign = Middle;
            flow.horizontalAlign = Middle;
            flow.padding = 60;
            flow.verticalSpacing = 20;

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
            
            for (en in Game.ME.level.data.l_Entities.all_UIButton){
                for(a in affiliatedID)
                    if(a == en.iid){
                       UIBuilders.button(en,flow);
                    }
            }
 */

            
            flow.reflow();
           // flow.visible = false;
            new echoes.Entity().add(pos,spr,sq,se,flow);
        } 

        public static function button(e:Entity_UIButton,flow:h2d.Flow){
                      
/*             var pos = new GridPosition(0,0,0,0);
            
            //Rendering Component
            
            var g   = new ScaleGrid(Assets.tiles.getTile(D.tiles.button),7,7,flow);
            
            var spr = new SpriteComponent(D.tiles.fxDot0);
            var sq  = new SquashComponent();
            var se  = new SpriteExtension();     

            var cl  = new CollisionsListener();

            var txt = new h2d.Text(hxd.res.DefaultFont.get(), g);
            //var cat = new UICategory_A();
            var obj = new UIObject();

            txt.text= e.f_button_label;

            g.ignoreScale = true;
            g.tileBorders = true;
            
            g.height = e.height;
            g.width  = txt.calcTextWidth(txt.text)+30;
            
            txt.setPosition(g.width/2,g.height/4);
            txt.textAlign = Center;
            
            g.scaleX = 2;
            g.scaleY = 2;

            var interactive = new InteractiveHeapsComponent();
            var button      = new UIButton(txt,g);
            button.event = e.f_UI_Button_Event;
 

            new echoes.Entity().add(pos,spr,sq,se,g,interactive,button,cat,obj,cl); */
        } 
    }