package aleiiioa.systems.local.ui.pad;


import aleiiioa.components.local.ui.algo.Currently_Hovered;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.local.ui.algo.Nearest_Selectable;
import aleiiioa.components.local.ui.algo.Currently_Selectable;
import aleiiioa.components.local.ui.UISelectorFlag;
import aleiiioa.components.local.ui.algo.On_Targeted_Selectable;
import aleiiioa.components.local.ui.signal.UISignalArrowMove;
import aleiiioa.components.core.physics.position.TransformPositionComponent;

import echoes.System;
import echoes.View;

class UIPadNavigationSystem extends echoes.System {
	
	var SELECTOR:View<UISelectorFlag>         = getLinkedView(UISelectorFlag);
	var SELECTABLE:View<Currently_Selectable> = getLinkedView(Currently_Selectable);

	var dist_to_selector:Float = 500;
	var current_category:UISelectableType = Category_None;

	var lowest_cy :Int = 30;
	var highest_cy:Int = 0;
	var lowest_cx :Int = 50;
	var highest_cx:Int = 0;

	var onChangeSelect:Bool;

	public function new() {}

	@:u function initDistance() {
		dist_to_selector = 5000.;
		current_category = Category_None;
	}

	@:a function setMinMax(sel:Currently_Selectable,gp:GridPosition){
		if(gp.cy < lowest_cy)
			lowest_cy = gp.cy;
		if(gp.cy > highest_cy)
			highest_cy = gp.cy;

		if(gp.cx < lowest_cx)
			lowest_cx = gp.cx;
		if(gp.cx > highest_cx)
			highest_cx = gp.cx;
		
	//	trace(':::high : ' + highest_cy +':::: low : '+ lowest_cy + '' );
	}

	@:u function preCastNearestInSelectorIntent(en:echoes.Entity, s:Currently_Selectable, gp:GridPosition) {
		
		var dist = 10000.;
		var select = false;
		var selector_i = SELECTOR.entities;
		var nearestSelectable = new Nearest_Selectable(dist);
		//var selectors = SELECTOR.entities;
		var i = 0;
		while (i < selector_i.length) {
			var selector = selector_i[i];
			if (selector.exists(UISignalArrowMove) && !selector.exists(TransformPositionComponent)) {
				en.remove(Currently_Hovered);
				var select_int = selector.get(UISignalArrowMove);
				var select_gp  = selector.get(GridPosition);
				
				if (select_int.y < 0 && (en.exists(Currently_Hovered) && lowest_cy == select_gp.cy || gp.cy+1 < select_gp.cy)) {
					select = true;
				}
			
				if (select_int.y > 0 && (en.exists(Currently_Hovered) && highest_cy == select_gp.cy || gp.cy -1 > select_gp.cy)) {
					select = true;
				}
	
				if (select_int.x < 0 && (en.exists(Currently_Hovered) && lowest_cx == select_gp.cx || gp.cx < select_gp.cx)) {
					select = true;
				}
	
				if (select_int.x > 0 && (en.exists(Currently_Hovered) && highest_cx == select_gp.cx || gp.cx > select_gp.cx)) {
					select = true;
				}
	
				if (select) {
					dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
				}
	
				//en.remove(Currently_Hovered);
			}
	
			if(select){
				//en.add(new Nearest_Selectable(dist));
				nearestSelectable.distance = dist; // Update the distance
                en.add(nearestSelectable);
				onChangeSelect = true;
				if (dist < dist_to_selector)
					dist_to_selector = dist;
			}
			i++;
		}

	}

	@:u function onChangeSelectItem(en:echoes.Entity,u:Currently_Hovered){
		if(onChangeSelect){
			onChangeSelect = false;
		}
	}

	@:u function removeNoneNearest(en:echoes.Entity, near:Nearest_Selectable) {
		if (near.distance > dist_to_selector) {
			en.remove(Nearest_Selectable);
		}
	}

	@:u function convertNearestToTargeted(en:echoes.Entity, near:Nearest_Selectable){
		
		en.add(new On_Targeted_Selectable());
		en.remove(Nearest_Selectable);
	}

	@:a function updateNearest(en:echoes.Entity, add:On_Targeted_Selectable, s:Currently_Selectable, gp:GridPosition) {
		//trace("On Add");
		var selectors = SELECTOR.entities;
		var i = 0;
		while (i < selectors.length) {
			var selector = selectors[i];
			if(!selector.exists(TransformPositionComponent)){
				var duration:Float = 0.1;
				var tar = gp.gpToVector();
				var ori = selector.get(GridPosition).gpToVector();
				selector.remove(UISignalArrowMove);
				selector.add(new TransformPositionComponent(ori,tar,duration,TBurnOut));
				
			}
			i++;
		}
		
		en.add(new Currently_Hovered());
		en.remove(On_Targeted_Selectable);
	}

}

/* 
	@:u function preCastNearestInSelectorIntent(en:echoes.Entity, s:Currently_Selectable, gp:GridPosition) {
		var dist = 10000.;
		var select = false;
		var selector_i = SELECTOR.entities;
		
		if (selector_i.length > 0 ) {
			var selector = selector_i[1];
			

			if (selector.exists(UISignalArrowMove) && !selector.exists(TransformPositionComponent)) {
				
				var select_int = selector.get(UISignalArrowMove);
				var select_gp  = selector.get(GridPosition);
				
				if (select_int.y < 0 ) {
					if(en.exists(Currently_Hovered) && lowest_cy == select_gp.cy){
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
					if (gp.cy+1 < select_gp.cy) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}
			
				if (select_int.y > 0 ) {
					if(en.exists(Currently_Hovered) && highest_cy == select_gp.cy){
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
					if (gp.cy -1 > select_gp.cy) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}

				if (select_int.x < 0) {
					if(en.exists(Currently_Hovered) && lowest_cx == select_gp.cx){
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
					if (gp.cx < select_gp.cx) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}

				if (select_int.x > 0) {
					if(en.exists(Currently_Hovered) && highest_cx == select_gp.cx){
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
					if (gp.cx > select_gp.cx) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}
				en.remove(Currently_Hovered);
			}

			if(select){
				en.add(new Nearest_Selectable(dist));
				onChangeSelect = true;
				if (dist < dist_to_selector)
					dist_to_selector = dist;
			}
		}
	}
 */
