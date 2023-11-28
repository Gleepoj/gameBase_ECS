package aleiiioa.systems.collisions;

import aleiiioa.components.logic.ability.CatchableFlag;
import aleiiioa.components.logic.InteractiveComponent;
import aleiiioa.components.logic.qualia.PlayerFlag;
import aleiiioa.components.flags.logic.*;
import aleiiioa.components.dialog.flag.*;

import echoes.View;

import aleiiioa.systems.collisions.CollisionEvent.InstancedCollisionEvent;
import aleiiioa.components.core.collision.CollisionsListener;
import aleiiioa.components.core.position.GridPosition;


class EntityCollisionsSystem extends echoes.System {
    
    var ALL_CATCHABLE:View<CatchableFlag,InteractiveComponent>;
    var PLAYER :View<GridPosition,PlayerFlag>;
    var events:InstancedCollisionEvent;

    public function new() {
        events = new InstancedCollisionEvent();
    }

    @u function playerInInteractArea(gp:GridPosition,flag:PlayerFlag,cl:CollisionsListener) {
        var head = ALL_CATCHABLE.entities.head;
        var playerPos = gp.gpToVector();

        while (head != null){
            var obj = head.value;
            var objPos = obj.get(GridPosition).gpToVector();
            if(playerPos.distance(objPos)<10){
                cl.lastEvent = events.allowInteract;
                orderListener(cl);
            }
            head = head.next;
        }
    }

    
    @u function CatchableInInteractArea(catchable:CatchableFlag,gp:GridPosition,cl:CollisionsListener) {
        var player = PLAYER.entities.head.value;
        var pgp = player.get(GridPosition);
        var playerPos = pgp.gpToVector();
        var objPos = gp.gpToVector();

        if(playerPos.distance(objPos)<10){
            cl.lastEvent = events.allowInteract;
            orderListener(cl);
        }
        
    }


    function orderListener(cl:CollisionsListener){
        if (cl.lastEvent!=null)
            cl.lastEvent.send(cl);
    }
}