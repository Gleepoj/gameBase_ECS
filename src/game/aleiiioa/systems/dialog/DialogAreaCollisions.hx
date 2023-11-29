package aleiiioa.systems.dialog;

import aleiiioa.components.flags.logic.*;
import aleiiioa.components.local.dialog.flag.*;

import echoes.View;

import aleiiioa.systems.collisions.CollisionEvent.InstancedCollisionEvent;
import aleiiioa.components.core.collision.CollisionsListener;
import aleiiioa.components.core.position.GridPosition;

class DialogAreaCollisions extends echoes.System {
    
    var ALL_PNJ:View<GridPosition,PNJDialogFlag>;
    var PLAYER_SPEAKER:View<GridPosition,PlayerDialogFlag>;

    var events:InstancedCollisionEvent;

    public function new() {
        events = new InstancedCollisionEvent();
    }

    @u function playerInDialogArea(gp:GridPosition,flag:PlayerDialogFlag,cl:CollisionsListener) {
        var head = ALL_PNJ.entities.head;
        var playerPos = gp.gpToVector();

        while (head != null){
            var pnj = head.value;
            var pnjPos = pnj.get(GridPosition).gpToVector();
            if(playerPos.distance(pnjPos)<30){
                cl.lastEvent = events.allowDialog;
                orderListener(cl);
            }
            head = head.next;
        }
    }

    @u function pnjInDialogArea(gp:GridPosition,flag:PNJDialogFlag,cl:CollisionsListener) {
        var player = PLAYER_SPEAKER.entities.head.value;
        var pgp = player.get(GridPosition);
        var playerPos = pgp.gpToVector();
        var pnjPos = gp.gpToVector();

        if(playerPos.distance(pnjPos)<30){
            cl.lastEvent = events.allowDialog;
            orderListener(cl);
        }
        
    }
    
    function orderListener(cl:CollisionsListener){
        if (cl.lastEvent!=null)
            cl.lastEvent.send(cl);
    }
}
