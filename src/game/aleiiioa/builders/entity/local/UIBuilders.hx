package aleiiioa.builders.entity.local;

import h2d.ScaleGrid;

import aleiiioa.components.local.ui.setting.SettingVolume;
import aleiiioa.components.local.ui.setting.SettingWindowMode;
import aleiiioa.components.local.ui.setting.SettingSfx;
import aleiiioa.components.local.ui.setting.ISettingComponent;
import aleiiioa.components.local.ui.setting.SettingResolution;
import aleiiioa.components.local.ui.UIModalSetting;

import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.core.rendering.SpriteExtension;
import aleiiioa.components.core.rendering.SquashComponent;
import aleiiioa.components.core.rendering.SpriteComponent;

import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.core.physics.velocity.VelocityComponent;
import aleiiioa.components.core.physics.velocity.AnalogSpeedComponent;

import aleiiioa.components.local.dialog.DialogReferenceComponent;
import aleiiioa.components.local.dialog.DialogUIBubble;
import aleiiioa.components.local.dialog.DialogUIOptionLayout;
import aleiiioa.components.local.dialog.UIDialog;
import aleiiioa.components.local.dialog.YarnDialogConponent;
import aleiiioa.components.local.dialog.YarnDialogListener;

import aleiiioa.components.local.ui.UIButton;
import aleiiioa.components.local.ui.UISelectorFlag;
import aleiiioa.components.local.ui.algo.On_Targeted_Selectable;
import aleiiioa.components.local.ui.algo.Currently_Selectable;

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

        spr.visible = false;

        //Physics Component
        var vc  = new VelocityComponent();
        var vas = new AnalogSpeedComponent(0,0);
        
        var input    = new InputComponent();
        var selector = new UISelectorFlag();

        new echoes.Entity().add(pos,spr,sq,se,vc,vas,input,selector);
    }

    public static function menu(e:Entity_UIWindow) {
            //Physics Component
            selector();

            var pos = new GridPosition(e.cx,e.cy,0,0);
            var spr = new SpriteComponent(D.tiles.fxDot0);
            var sq  = new SquashComponent();
            var se  = new SpriteExtension();

           /*  var flow = new dn.heaps.FlowBg(Assets.tiles.getTile(D.tiles.ui_window),3,3);
            Game.ME.root.add(flow,Const.DP_UI); */
            var w = hxd.Window.getInstance();
            
            var viewport = new dn.heaps.FlowBg(Assets.tiles.getTile(D.tiles.ui_window),3,3);
            Game.ME.ui_layer.add(viewport);
            viewport.bg.alpha = 0;
            viewport.fillHeight = true;
            viewport.fillWidth = true;

            viewport.verticalAlign = Middle;
            viewport.horizontalAlign = Middle;
           
            
            var flow = new dn.heaps.FlowBg(Assets.tiles.getTile(D.tiles.ui_window),3,3);
           
            flow.paddingHorizontal = M.floor(200/Const.UI_SCALE);
            flow.paddingVertical   = M.floor(200/Const.UI_SCALE);

            flow.layout = Vertical;
            flow.verticalAlign = Middle;
            flow.horizontalAlign = Middle;
            flow.bg.alpha = 0;
            viewport.addChild(flow);


            var affiliatedID:Array<String> = [] ;
            
            for (en in e.f_Entity_ref){
                affiliatedID.push(en.entityIid);
            }
        

            for (en in Game.ME.level.data.l_Entities.all_UISetting){
                for(a in affiliatedID)
                    if(a == en.iid){
                       UIBuilders.ldtk_UISetting(en,flow);
                    }
            } 

            for (en in Game.ME.level.data.l_Entities.all_UIButton){
                for(a in affiliatedID)
                    if(a == en.iid){
                       UIBuilders.ldtk_UIbutton(en,flow);
                    }
            }
                       
            viewport.reflow();
            new echoes.Entity().add(viewport);
           
        }

        public static function ldtk_UIbutton(e:Entity_UIButton,flow:h2d.Flow){
                      
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
         
            txt.text = e.f_Label;
            txt.setPosition(g.width/2,g.height/5);
            txt.textAlign = Center;
            txt.scale(3);
        
            var button   = new UIButton(txt);
            button.event = e.f_UI_Button_Event;

            var sel = new Currently_Selectable();

            if(!e.f_isFirstTargeted)
                new echoes.Entity().add(pos,spr,sq,se,g,button,sel);

            if(e.f_isFirstTargeted){
                var tar = new On_Targeted_Selectable();
                new echoes.Entity().add(pos,spr,sq,se,g,button,sel,tar);
            }
        } 
        
        public static function ldtk_UISetting(e:Entity_UISetting,flow:h2d.Flow){

            var subflow = new dn.heaps.FlowBg(Assets.tiles.getTile(D.tiles.ui_window),3,3);
            flow.addChild(subflow);
            
            subflow.layout = Horizontal;
            subflow.verticalAlign = Middle;
            subflow.horizontalAlign = Middle;
            subflow.padding = 4;
            subflow.verticalSpacing = 2;

            var lab = e.f_UI_Setting_Type;
            var shared = new UIModalSetting();
            var setter:ISettingComponent;

            switch(e.f_UI_Setting_Type){
                case Window_Size:
                    setter = new SettingResolution();
                case Window_Mode:
                    setter = new SettingWindowMode();
                case Volume_Music:
                    setter = new SettingVolume();
                case Volume_SFX:
                    setter = new SettingSfx();
            }

            label(subflow,lab.getName());
            value(e,subflow,shared,setter);
            prev_button(subflow,shared,setter);
            next_button(subflow,shared,setter);
            
            subflow.reflow();

        }

        public static function next_button(flow:h2d.Flow,shared:UIModalSetting,comp:ISettingComponent){
            var pos = new GridPosition(0,0,0,0);
            var spr = new SpriteComponent(D.tiles.fxDot0);
            var sq  = new SquashComponent();
            var se  = new SpriteExtension();     
            spr.visible = true;
            
            //Rendering Component
            
            var g   = new ScaleGrid(Assets.tiles.getTile(D.tiles.ui_button),2,2,flow);
            
            g.width  = 50;
            g.height = 40;

            var txt = new h2d.Text(hxd.res.DefaultFont.get(), g);
         
            txt.text = ">>";
            txt.setPosition(g.width/2,g.height/5);
            txt.textAlign = Center;
            txt.scale(2);
        
            var button   = new UIButton(txt);
            button.event = Order_Next;

            var sel = new Currently_Selectable();

         
            new echoes.Entity().add(pos,spr,sq,se,g,button,sel,shared,comp);
        }

        public static function prev_button(flow:h2d.Flow,isFirstTargeted:Bool = false,shared:UIModalSetting,comp:ISettingComponent){
            var pos = new GridPosition(0,0,0,0);
            var spr = new SpriteComponent(D.tiles.fxDot0);
            var sq  = new SquashComponent();
            var se  = new SpriteExtension();     
            spr.visible = true;
            
            //Rendering Component
            
            var g   = new ScaleGrid(Assets.tiles.getTile(D.tiles.ui_button),2,2,flow);
           
            g.width  = 50;
            g.height = 40;

            var txt = new h2d.Text(hxd.res.DefaultFont.get(), g);
         
            txt.text = "<<";
            txt.setPosition(g.width/2,g.height/5);
            txt.textAlign = Center;
            txt.scale(2);
        
            var button   = new UIButton(txt);
            button.event = Order_Previous;

            var sel = new Currently_Selectable();

            if(!isFirstTargeted)
                new echoes.Entity().add(pos,spr,sq,se,g,button,sel,shared,comp);

            if(isFirstTargeted){
                var tar = new On_Targeted_Selectable();
                new echoes.Entity().add(pos,spr,sq,se,g,button,sel,tar,shared,comp);
            }
        }

        public static function label(flow:h2d.Flow,label:String){
            var pos = new GridPosition(0,0,0,0);
            var spr = new SpriteComponent(D.tiles.fxDot0);
            var sq  = new SquashComponent();
            var se  = new SpriteExtension();     
            spr.visible = true;
            
            //Rendering Component
            
            var g   = new ScaleGrid(Assets.tiles.getTile(D.tiles.ui_button),2,2,flow);
            var v = hxd.Window.getInstance();
            g.width  = v.width/4;
            g.height = 40;

            var txt = new h2d.Text(hxd.res.DefaultFont.get(), g);
         
            txt.text = label;
            txt.setPosition(g.width/2,g.height/5);
            txt.textAlign = Center;
            txt.scale(2);
 
            new echoes.Entity().add(pos,spr,sq,se,g);

        }

        public static function value(e:Entity_UISetting,flow:h2d.Flow,shared:UIModalSetting,comp:ISettingComponent){
            
            var pos = new GridPosition(0,0,0,0);
            var spr = new SpriteComponent(D.tiles.fxDot0);
            var sq  = new SquashComponent();
            var se  = new SpriteExtension();     
            spr.visible = true;
            
            //Rendering Component
            
            var g   = new ScaleGrid(Assets.tiles.getTile(D.tiles.ui_button),2,2,flow);
            var v = hxd.Window.getInstance();
            g.width  = v.width/5;
            g.height = 40;

            shared.text = new h2d.Text(hxd.res.DefaultFont.get(), g);
            var txt = shared.text;
            txt.text = "<...>";
            txt.setPosition(g.width/2,g.height/5);
            txt.textAlign = Center;
            txt.scale(2);

            
            new echoes.Entity().add(pos,spr,sq,se,g,shared,comp);
            //var value = new UIValue(txt);
 

        }


    }