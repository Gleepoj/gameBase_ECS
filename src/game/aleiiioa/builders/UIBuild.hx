package aleiiioa.builders;

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

        public static function option(text : String) {
            var uoc = new UIOptionComponent(text);
            new echoes.Entity().add(uoc);
        }
    }