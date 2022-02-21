package aleiiioa.systems.collisions;


import echoes.View;
import aleiiioa.components.flags.*;
import aleiiioa.components.BulletComponent;
import aleiiioa.components.core.GridPosition;


class BulletCollisionSystem extends echoes.System {
    var ALL_ENNEMY_BULLETS:View<GridPosition,BulletComponent,EnnemyFlag>;
    var ALL_PLAYER_BULLETS:View<GridPosition,BulletComponent,FriendlyFlag>;
    var ALL_VESSELS:View<GridPosition,VesselFlag>;

    public function new() {
        
    }

    @u function bulletCollideWithPlayer(gp:GridPosition,flag:PlayerFlag) {
        var head = ALL_ENNEMY_BULLETS.entities.head;
        var vecPos = gp.gpToVector();
        while (head != null){
            var bullet = head.value;
            var vecBullet = bullet.get(GridPosition).gpToVector();
            if(vecPos.distance(vecBullet)<20)
                    trace("P collide w enmy bullet");

            head = head.next;
        }
    }

    @u function bulletCollideWithVessels(gp:GridPosition,flag:VesselFlag) {
        var head = ALL_PLAYER_BULLETS.entities.head;
        var vecPos = gp.gpToVector();
        while (head != null){
            var bullet = head.value;
            var vecBullet = bullet.get(GridPosition).gpToVector();
            if(vecPos.distance(vecBullet)<20)
                    trace("V collide w Pl bullet");
            
            head = head.next;
        }
    }

    @u function playerCollideWithVessels(gp:GridPosition,flag:PlayerFlag) {
        var head = ALL_VESSELS.entities.head;
        var vecPos = gp.gpToVector();
        while (head != null){
            var vessel = head.value;
            var vecVessel = vessel.get(GridPosition).gpToVector();
            if(vecPos.distance(vecVessel)<40)
                    trace("Pl collide w Vessel");
            
            head = head.next;
        }
    }
}