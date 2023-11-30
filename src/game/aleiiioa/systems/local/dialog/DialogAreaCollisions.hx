package aleiiioa.systems.local.dialog;

import aleiiioa.components.logic.interaction.InteractionEvent.InstancedInteractionEvent;
import aleiiioa.components.logic.interaction.InteractionListener;
import aleiiioa.components.flags.logic.*;
import aleiiioa.components.local.dialog.flag.*;

import echoes.View;

import aleiiioa.components.core.collision.CollisionsListener;
import aleiiioa.components.core.position.GridPosition;

class DialogAreaCollisions extends echoes.System {
    
    var ALL_PNJ:View<GridPosition,PNJDialogFlag>;
    var PLAYER_SPEAKER:View<GridPosition,PlayerDialogFlag>;

    var events:InstancedInteractionEvent;

    public function new() {
        events = new InstancedInteractionEvent();
    }

    @u function playerInDialogArea(gp:GridPosition,flag:PlayerDialogFlag,il:InteractionListener) {
        var head = ALL_PNJ.entities.head;
        var playerPos = gp.gpToVector();

        while (head != null){
            var pnj = head.value;
            var pnjPos = pnj.get(GridPosition).gpToVector();
            if(playerPos.distance(pnjPos)<30){
                il.lastEvent = events.allowDialog;
                il.order();
            }
            head = head.next;
        }
    }

    @u function pnjInDialogArea(gp:GridPosition,flag:PNJDialogFlag,il:InteractionListener) {
        var player = PLAYER_SPEAKER.entities.head.value;
        var pgp = player.get(GridPosition);
        var playerPos = pgp.gpToVector();
        var pnjPos = gp.gpToVector();

        if(playerPos.distance(pnjPos)<30){
            il.lastEvent = events.allowDialog;
            il.order();
        }
        
    }
    
/*     function orderListener(cl:CollisionsListener){
        if (cl.lastEvent!=null)
            cl.lastEvent.send(cl);
    } */
}
