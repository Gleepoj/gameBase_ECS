package aleiiioa.systems.logic.interaction;

import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.core.qualia.PlayerFlag;
import aleiiioa.components.logic.interaction.catching.*;
import aleiiioa.components.logic.*;
import aleiiioa.components.core.physics.*;
import aleiiioa.components.core.collision.CollisionsListener;
import aleiiioa.components.core.position.*;
import aleiiioa.components.core.position.flags.*;
import echoes.View;
import aleiiioa.systems.collisions.CollisionEvent.InstancedCollisionEvent;

class CatchLogicSystem extends echoes.System {
    
    var ALL_CATCHER  :View<Catcher,GridPosition,CollisionsListener>;
    var ALL_CATCHABLE:View<CatchableCollection,GridPosition,CollisionsListener>;
    var ALL_CATCHED  :View<IsCatched,MasterGridPosition,GridPositionOffset,ChildPositionFlag>;

    var events:InstancedCollisionEvent;

    public function new() {
        events = new InstancedCollisionEvent();
    }

    
    // Input logic could be move to another system
    @u function playerRequireCatching(en:echoes.Entity,pl:PlayerFlag,cl:CollisionsListener,inp:InputComponent) {
        
        if(cl.onInteract && inp.ca.isPressed(ActionX) && !en.exists(IsOnCatch)){
            en.add(new OnQueryCatch());
        }

        if(inp.ca.isPressed(ActionX) && en.exists(IsOnCatch)){
            en.add(new OnQueryThrow());
        }
    }
    

    @u function CatcherInInteractArea(catcher:Catcher,gp:GridPosition,cl:CollisionsListener) {
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

    
    @u function CatchableInInteractArea(catchable:CatchableCollection,gp:GridPosition,cl:CollisionsListener) {
        var head = ALL_CATCHER.entities.head;
        var objPos = gp.gpToVector();

        while (head != null){
            var catcher = head.value;
            var catcherPos = catcher.get(GridPosition).gpToVector();
            if(catcherPos.distance(objPos)<10){
                cl.lastEvent = events.allowInteract;
                orderListener(cl);
            }
            head = head.next;
        }    
    }


    @u function onAddQueryCatch(en:echoes.Entity,add:OnQueryCatch,catcher:Catcher,mgp:MasterGridPosition){
        var head = ALL_CATCHABLE.entities.head;
        
        while (head != null){
            var catchable = head.value;
            var ocl = catchable.get(CollisionsListener);
            if(ocl.onInteract){
                linkObject(catchable,mgp);
                en.add(new IsOnCatch());
            }
            head = head.next;
        }
        en.remove(OnQueryCatch);
    }

    @u function onAddQueryThrow(en:echoes.Entity,add:OnQueryThrow,catcher:Catcher,mgp:MasterGridPosition,vc:VelocityComponent){
        var head = ALL_CATCHED.entities.head;
        
        while (head != null){
            var catched = head.value;
            unlinkObject(catched);
            throwObject(catched,vc);
            head = head.next;
            }
            
            en.remove(IsOnCatch);
            en.remove(OnQueryThrow);
    }


    function linkObject(en:echoes.Entity,mgp:MasterGridPosition) {
        en.add(new GridPositionOffset(0,-1));
        en.add(mgp);
        en.add(new ChildPositionFlag());
        en.add(new IsCatched());    
    }

    function unlinkObject(en:echoes.Entity) {
        en.remove(MasterGridPosition);
        en.remove(GridPositionOffset);
        en.remove(ChildPositionFlag);
        en.remove(IsCatched);
    }

    function throwObject(en:echoes.Entity,vc:VelocityComponent){ 
        en.get(VelocityAnalogSpeed).xSpeed = vc.dx * 20;
        en.get(VelocityAnalogSpeed).ySpeed = -2;
    }

    
    function orderListener(cl:CollisionsListener){
        if (cl.lastEvent!=null)
            cl.lastEvent.send(cl);
    }

}