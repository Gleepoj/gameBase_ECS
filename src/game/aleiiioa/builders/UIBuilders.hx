package aleiiioa.builders;

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

        public static function dialogEntity(_yarnFile:DialogReferenceComponent){
            
            var ydc = new YarnDialogConponent(_yarnFile);
            var ydl = new YarnDialogListener(_yarnFile);

            var ui    = new UIDialog();
            var uiBub = new DialogUIBubble();
            var uiOpt = new DialogUIOptionLayout();

            new echoes.Entity().add(ydc,ydl,ui,uiBub,uiOpt);
        }
    }