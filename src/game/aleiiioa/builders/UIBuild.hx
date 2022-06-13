package aleiiioa.builders;

import aleiiioa.components.dialog.UIBubble;
import aleiiioa.components.dialog.UIOption;
import aleiiioa.components.dialog.YarnDialogListener;
import aleiiioa.components.dialog.UIDialog;
import aleiiioa.components.dialog.YarnDialogConponent;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.ui.DialogComponent;
import aleiiioa.components.ui.UIOptionComponent;
import aleiiioa.components.ui.UIDialogComponent;
import aleiiioa.components.ui.UICheckComponent;
import aleiiioa.components.ui.UISliderComponent;

class UIBuild {
    
    ////////ACTORS////////////////
        public static function slider(label : String, get : Void -> Float, set : Float -> Void, min : Float = 0., max : Float = 1.) {
            var usc = new UISliderComponent(label,get,set,min,max);
            new echoes.Entity().add(usc);
        }

        public static function check(label : String, get : Void -> Bool, set : Bool -> Void) {
            var ucc = new UICheckComponent(label,get,set);
            new echoes.Entity().add(ucc);
        }

        public static function dialog(text : String,character:Int) {
            var udc = new UIDialogComponent(text,character);
            new echoes.Entity().add(udc);
        }

        public static function option(text : String,id:Int) {
            var uoc = new UIOptionComponent(text,id);
            new echoes.Entity().add(uoc);
        }

        public static function textDialog(_yarnFile:String){
            var dc = new DialogComponent(_yarnFile);
            //var gp = new GridPosition(_cx,_cy);
            //var udc = new UIDialogComponent(text,character);

            new echoes.Entity().add(dc);
        }

        public static function dialogEntity(_yarnFile:String){
            
            var ydc = new YarnDialogConponent(_yarnFile);
            var ydl = new YarnDialogListener();

            
           // new echoes.Entity().add(ydc,ydl);
            var ui    = new UIDialog();
            var uiBub = new UIBubble();
            var uiOpt = new UIOption();

            new echoes.Entity().add(ydc,ydl,ui,uiBub,uiOpt);
        }
    }