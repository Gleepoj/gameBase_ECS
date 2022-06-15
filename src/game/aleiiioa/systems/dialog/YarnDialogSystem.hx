package aleiiioa.systems.dialog;

import aleiiioa.components.dialog.YarnDialogListener;
import aleiiioa.components.dialog.YarnDialogConponent;

class YarnDialogSystem extends echoes.System {
    public function new() {
        
    }

    @a function onDialogAdded(yd:YarnDialogConponent,yl:YarnDialogListener) {
        yd.start();
    }

    @u function updateDialogListener(dt:Float,ydial:YarnDialogConponent,yl:YarnDialogListener) {
        yl.cd.update(dt);
        yl.lastEvent = yl.newEvent;
        yl.newEvent = ydial.currentEvent;
        yl.option = ydial.currentOptions;
        yl.text = ydial.currentText;
       
        if (yl.newEvent!=null && yl.lastEvent != yl.newEvent){
            orderListener(yl);
        }
    }
    
    function orderListener(yl:YarnDialogListener){
        yl.newEvent.send(yl);
        trace(yl.text);
        if(yl.option != null){
            trace(yl.option);
        }
    }
}
