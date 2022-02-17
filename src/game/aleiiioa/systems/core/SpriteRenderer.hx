package aleiiioa.systems.core;

import aleiiioa.components.solver.ModifierComponent;
import h3d.Vector;
import echoes.System;
import aleiiioa.components.core.*;

class SpriteRenderer extends echoes.System {
	var gameScroller:h2d.Layers;
	var game:Game;


	public function new(scroller:h2d.Layers,_game:Game) {
		this.gameScroller = scroller;
		this.game = _game;
	}


	// There are @a, @u and @r shortcuts for @added, @update and @removed metas;
	// @added/@removed-functions are callbacks that are called when an entity is added/removed from the view;
	@a function onEntityAdded(spr:SpriteComponent) {
		this.gameScroller.add(spr,Const.DP_FRONT);
		spr.set(D.tiles.fxCircle15);
		spr.setCenterRatio(0.5,1);
		spr.alpha = 1;
		spr.x = 0;
		spr.y = 20;
	}


	@u inline function updateSpritePosition(dt:Float,spr:SpriteComponent,gp:GridPosition,se:SpriteExtension) {
		this.renderSprite(dt,spr,gp,se);
	  }

	@r function onEntityRemoved(spr:SpriteComponent) {
		spr.remove();
	}
	public function interpolateSpritePosition(gp:GridPosition){
		var _x = M.lerp(gp.lastFixedUpdateX, (gp.cx+gp.xr)*Const.GRID, game.getFixedUpdateAccuRatio());
		var _y = M.lerp(gp.lastFixedUpdateY, (gp.cy+gp.yr)*Const.GRID, game.getFixedUpdateAccuRatio()); 
		return new Vector(_x,_y);
	}

	public function setPivots(se:SpriteExtension,spr:SpriteComponent, x:Float, ?y:Float) {
		se.pivotX = x;
		se.pivotY = y!=null ? y : x;
	
		spr.setCenterRatio(se.pivotX, se.pivotY);
	}

    
    /* var screenAttachX(get,never) : Float;
        inline function get_screenAttachX() return game!=null && !game.destroyed ? sprX*Const.SCALE + game.scroller.x : sprX*Const.SCALE;

    var screenAttachY(get,never) : Float;
        inline function get_screenAttachY() return game!=null && !game.destroyed ? sprY*Const.SCALE + game.scroller.y : sprY*Const.SCALE;
     */
	/** Briefly squash sprite on X (Y changes accordingly). "1.0" means no distorsion. **/
	public function setSquash(se:SpriteExtension,spr:SpriteComponent) {
		se.squashX = spr.scaleX;
		se.squashY = 2 - spr.scaleX;
		
		se.squashX = 2 - spr.scaleY;
		se.squashY = spr.scaleY;
	}

	public function renderSprite(dt:Float,spr:SpriteComponent,gp:GridPosition,se:SpriteExtension) {
		if (se.interpolateSprPos){
			var interpolatePos = this.interpolateSpritePosition(gp);
			spr.x = interpolatePos.x;
			spr.y = interpolatePos.y;
		}
		if (!se.interpolateSprPos){
			spr.x = gp.attachX;
			spr.y = gp.attachY;
		}

		spr.scaleX = se.dir * se.sprScaleX * se.squashX;
		spr.scaleY = se.sprScaleY * se.squashY;
		//spr.visible = entityVisible;

		se.squashX += (1 - se.squashX) * M.fmin(1, 0.2 * dt);
		se.squashY += (1 - se.squashY) * M.fmin(1, 0.2 * dt);		
	}
}