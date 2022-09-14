package aleiiioa.systems.logic;

import echoes.View;
import aleiiioa.components.flags.BombFlag;
import aleiiioa.components.core.position.MasterGridPosition;
import aleiiioa.components.core.position.GridPositionOffset;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.logic.ActionComponent;
import aleiiioa.components.flags.PlayerFlag;
import aleiiioa.components.flags.hierarchy.*;

import aleiiioa.components.InputComponent;
import aleiiioa.components.core.collision.CollisionsListener;

class InteractivesSystem extends echoes.System {
    var ALL_PLAYERS :View<GridPosition,PlayerFlag>;
    
    public function new() {
        
    }

    @u function playerGrabBomb(cl:CollisionsListener,inp:InputComponent,pl:PlayerFlag,ac:ActionComponent) {
        if(cl.onInteract && inp.ca.isPressed(ShapeWind)){
            ac.query = true;
        }
    }

    @u function BombIsGrabbedByPlayer(en:echoes.Entity,cl:CollisionsListener,b:BombFlag) {
        
        if(cl.onInteract){
            var head = ALL_PLAYERS.entities.head;
        
    
            while (head != null){
                var player = head.value;
                var playerPos:GridPosition = player.get(GridPosition);
                var playerInteract = player.get(ActionComponent).query;
                if(playerInteract){
                    en.add(new GridPositionOffset(0,-1));
                    en.add(new MasterGridPosition(playerPos.cx,playerPos.cy));
                    en.add(new ChildFlag());
                    player.add(new MasterFlag());
                }
                
                head = head.next;
            }
        }
    }
}