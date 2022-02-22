package aleiiioa.systems.collisions;

import echoes.View;

import aleiiioa.systems.collisions.CollisionEvent.InstancedCollisionEvent;

import aleiiioa.components.flags.*;
import aleiiioa.components.BulletComponent;
import aleiiioa.components.CollisionsListener;
import aleiiioa.components.core.GridPosition;


class EntityCollisionsSystem extends echoes.System {
    var ALL_ENNEMY_BULLETS:View<GridPosition,BulletComponent,EnnemyFlag>;
    var ALL_PLAYER_BULLETS:View<GridPosition,BulletComponent,FriendlyFlag>;
    var ALL_VESSELS:View<GridPosition,VesselFlag>;

    var events:InstancedCollisionEvent;

    public function new() {
        events = new InstancedCollisionEvent();
    }

    @u function bulletCollideWithPlayer(gp:GridPosition,flag:PlayerFlag,cl:CollisionsListener) {
        var head = ALL_ENNEMY_BULLETS.entities.head;
        var vecPos = gp.gpToVector();
        while (head != null){
            var bullet = head.value;
            var vecBullet = bullet.get(GridPosition).gpToVector();
            if(vecPos.distance(vecBullet)<20){
                cl.lastEvent = events.bulletInpact;
                orderListener(cl);
                bullet.destroy();
            }
            head = head.next;
        }
    }

    @u function bulletCollideWithVessels(gp:GridPosition,flag:VesselFlag,cl:CollisionsListener) {
        var head = ALL_PLAYER_BULLETS.entities.head;
        var vecPos = gp.gpToVector();
        while (head != null){
            var bullet = head.value;
            var vecBullet = bullet.get(GridPosition).gpToVector();
            if(vecPos.distance(vecBullet)<20){
                cl.lastEvent = events.bulletInpact;
                orderListener(cl);
                bullet.destroy();
            }
            head = head.next;
        }
    }

    @u function playerCollideWithVessels(gp:GridPosition,flag:PlayerFlag,cl:CollisionsListener) {
        var head = ALL_VESSELS.entities.head;
        var vecPos = gp.gpToVector();
        while (head != null){
            var vessel = head.value;
            var vecVessel = vessel.get(GridPosition).gpToVector();
            if(vecPos.distance(vecVessel)<40){
                cl.lastEvent = events.vesselInpact;
                orderListener(cl);
            }
            head = head.next;
        }
    }

    function orderListener(cl:CollisionsListener){
        if (cl.lastEvent!=null)
            cl.lastEvent.send(cl);
    }
}