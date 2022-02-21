package aleiiioa.systems.collisions;

import aleiiioa.components.flags.EnnemyFlag;
import aleiiioa.components.flags.PlayerFlag;
import aleiiioa.components.InputComponent;
import aleiiioa.components.core.GridPosition;
import echoes.View;
import aleiiioa.components.BulletComponent;
import aleiiioa.components.core.VelocityAnalogSpeed;


class BulletCollisionSystem extends echoes.System {
    var ALL_ENNEMY_BULLETS:View<GridPosition,BulletComponent,EnnemyFlag>;
    public function new() {
        
    }
    @a function onBulletAdded(vas:VelocityAnalogSpeed,bul:BulletComponent) {
        vas.xSpeed = Math.cos(bul.ang)*bul.speed;
        vas.ySpeed = Math.sin(bul.ang)*bul.speed;
    }
    @u function bulletCollideWithPlayer(gp:GridPosition,flag:PlayerFlag) {
        var head = ALL_ENNEMY_BULLETS.entities.head;
        var vecPos = gp.gpToVector();
        while (head != null){
            var bullet = head.value;
            var vecBullet = bullet.get(GridPosition).gpToVector();
            if(vecPos.distance(vecBullet)<20)
                    trace("player collide with ennemy bullet");
            
            head = head.next;
        }
    }
}