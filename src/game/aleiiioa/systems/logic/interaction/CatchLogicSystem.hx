package aleiiioa.systems.logic.interaction;

import aleiiioa.components.logic.interaction.InteractionListener;
import aleiiioa.components.logic.interaction.InteractionEvent.InstancedInteractionEvent;
import aleiiioa.components.logic.qualia.PlayerFlag;
import aleiiioa.components.logic.interaction.catching.*;

import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.core.physics.velocity.*;
import aleiiioa.components.core.physics.position.*;
import aleiiioa.components.core.physics.position.flags.*;

import echoes.View;


class CatchLogicSystem extends echoes.System {
    
    var ALL_CATCHER  :View<Catcher,GridPosition,InteractionListener> = getLinkedView(Catcher,GridPosition,InteractionListener);
    var ALL_CATCHABLE:View<CatchableCollection,GridPosition,InteractionListener> = getLinkedView(CatchableCollection,GridPosition,InteractionListener);
    var ALL_CATCHED  :View<IsCatched,MasterGridPosition,GridPositionOffset,ChildPositionFlag> = getLinkedView(IsCatched,MasterGridPosition,GridPositionOffset,ChildPositionFlag);

    var events:InstancedInteractionEvent;

    public function new() {
        events = new InstancedInteractionEvent();
    }

    @:u function updateListener(dt:Float,il:InteractionListener){
        //il.cd.update(dt);
        il.updateCooldown(dt);
    }
    // Input logic could be move to another system
    @:u function playerRequireCatching(en:echoes.Entity,pl:PlayerFlag,il:InteractionListener,inp:InputComponent) {
        
        if(il.onInteract && inp.ca.isPressed(ActionX) && !en.exists(IsOnCatch)){
            en.add(new OnQueryCatch());
        } 

        if(inp.ca.isPressed(ActionX) && en.exists(IsOnCatch)){
            en.add(new OnQueryThrow());
        }
    }
    

    @:u function CatcherInInteractArea(catcher:Catcher,gp:GridPosition,il:InteractionListener) {
        var catchable = ALL_CATCHABLE.entities;
        var playerPos = gp.gpToVector();

        //for(head in catchable){
        var i = 0;
        while (i < catchable.length) {
            var obj = catchable[i];
            var objPos = obj.get(GridPosition).gpToVector();
            if(playerPos.distance(objPos)<10){
                il.lastEvent = events.allowInteract;
                il.order();
            }
            i++;
        }
    }

    
    @:u function CatchableInInteractArea(catchable:CatchableCollection,gp:GridPosition,il:InteractionListener) {
        var list_catcher = ALL_CATCHER.entities;
        var objPos = gp.gpToVector();

        var i = 0;
        while (i < list_catcher.length) {
            var catcher = list_catcher[i];
            var catcherPos = catcher.get(GridPosition).gpToVector();
            if(catcherPos.distance(objPos)<10){
                il.lastEvent = events.allowInteract;
                il.order();
            }
            i++;
        }
       
           
            //head = head.next;
           
    }


    @:u function onAddQueryCatch(en:echoes.Entity,add:OnQueryCatch,catcher:Catcher,mgp:MasterGridPosition){
        var all_catchable = ALL_CATCHABLE.entities;
        
        for (head in all_catchable){
            var catchable = head;
            var ocl = catchable.get(InteractionListener);
            if(ocl.onInteract){
                linkObject(catchable,mgp);
                en.add(new IsOnCatch());
            }
            //head = head.next;
        }
        en.remove(OnQueryCatch);
    }

    @:u function onAddQueryThrow(en:echoes.Entity,add:OnQueryThrow,catcher:Catcher,mgp:MasterGridPosition,vc:VelocityComponent){
        var all_catched = ALL_CATCHED.entities;
        
        for (head in all_catched){
            var catched = head;
            unlinkObject(catched);
            throwObject(catched,vc);
            //head = head.next;
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
        en.get(AnalogSpeedComponent).xSpeed = vc.dx * 20;
        en.get(AnalogSpeedComponent).ySpeed = -2;
    }

}