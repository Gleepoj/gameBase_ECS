package aleiiioa.systems.local.dialog;

import aleiiioa.components.logic.interaction.InteractionEvent.InstancedInteractionEvent;
import aleiiioa.components.logic.interaction.InteractionListener;
import aleiiioa.components.flags.logic.*;
import aleiiioa.components.local.dialog.flag.*;

import echoes.View;

import aleiiioa.components.core.physics.position.GridPosition;

class DialogAreaCollisions extends echoes.System {
    
    var ALL_PNJ:View<GridPosition,PNJDialogFlag> = getLinkedView(GridPosition,PNJDialogFlag);
    var PLAYER_SPEAKER:View<GridPosition,PlayerDialogFlag> = getLinkedView(GridPosition,PlayerDialogFlag);

    var events:InstancedInteractionEvent;

    public function new() {
        events = new InstancedInteractionEvent();
    }

    @:u function playerInDialogArea(gp:GridPosition,flag:PlayerDialogFlag,il:InteractionListener) {
        var playerPos = gp.gpToVector();

        for (head in ALL_PNJ.entities){
            var pnj = head;
            var pnjPos = pnj.get(GridPosition).gpToVector();
            if(playerPos.distance(pnjPos)<30){
                il.lastEvent = events.allowDialog;
                il.order();
            }
        }
    }

    @:u function pnjInDialogArea(gp:GridPosition,flag:PNJDialogFlag,il:InteractionListener) {
        var speakers = PLAYER_SPEAKER.entities;

            for (player in speakers) {
                var playerPos = player.get(GridPosition).gpToVector();
                var pnjPos = gp.gpToVector();
    
                if(playerPos.distance(pnjPos)<30){
                    il.lastEvent = events.allowDialog;
                    il.order();
            }
        }
        
    }
}
    
/*     function orderListener(cl:CollisionSensor){
        if (cl.lastEvent!=null)
            cl.lastEvent.send(cl);
    } */

