package aleiiioa.systems.local.ui.selector;


import aleiiioa.components.local.ui.On_UICurrentlySelected;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.local.ui.On_UINearestFlag;
import aleiiioa.components.local.ui.layers.UISelectableFlag;
import aleiiioa.components.local.ui.UISelectorFlag;
import aleiiioa.components.local.ui.On_UITargetedObject;
import aleiiioa.components.local.ui.On_UIPadMove;
import aleiiioa.components.core.physics.position.TransformPositionComponent;

import echoes.System;
import echoes.View;

class SelectorNavigationSystem extends echoes.System {
	var SELECTOR:View<UISelectorFlag>;
	var SELECTABLE:View<UISelectableFlag>;

	var dist_to_player:Float = 500;
	var current_category:UISelectableType = Category_None;

	var lowest_cy :Int = 30;
	var highest_cy:Int = 0;
	var lowest_cx :Int = 50;
	var highest_cx:Int = 0;

	var onChangeSelect:Bool;

	public function new() {}

	@u function initDistance() {
		dist_to_player = 5000.;
		current_category = Category_None;
	}

	@a function setMinMax(sel:UISelectableFlag,gp:GridPosition){
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

	
	@u function preCastNearestInSelectorIntent(en:echoes.Entity, s:UISelectableFlag, gp:GridPosition) {
		var dist = 10000.;
		var select = false;
		var selector_i = SELECTOR.entities.head;
		
		if (selector_i != null) {
			var selector = selector_i.value;
			

			if (selector.exists(On_UIPadMove) && !selector.exists(TransformPositionComponent)) {
				
				var select_int = selector.get(On_UIPadMove);
				var select_gp  = selector.get(GridPosition);
				
				if (select_int.y < 0 ) {
					if(en.exists(On_UICurrentlySelected) && lowest_cy == select_gp.cy){
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
					if (gp.cy+1 < select_gp.cy) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}
				//&& select_gp.cy != highest_cy
				if (select_int.y > 0 ) {
					if(en.exists(On_UICurrentlySelected) && highest_cy == select_gp.cy){
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
					if (gp.cy -1 > select_gp.cy) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}

				if (select_int.x < 0) {
					if(en.exists(On_UICurrentlySelected) && lowest_cx == select_gp.cx){
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
					if (gp.cx < select_gp.cx) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}

				if (select_int.x > 0) {
					if(en.exists(On_UICurrentlySelected) && highest_cx == select_gp.cx){
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
					if (gp.cx > select_gp.cx) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}
				en.remove(On_UICurrentlySelected);
			}

			if (select) {
				en.add(new On_UINearestFlag(dist));
				onChangeSelect = true;
				if (dist < dist_to_player)
					dist_to_player = dist;
			}
		}
	}

	@u function onChangeSelectItem(en:echoes.Entity,u:On_UICurrentlySelected){
		if(onChangeSelect){
			//en.remove(On_UICurrentlySelected);
			onChangeSelect = false;
		}
	}

	@u function removeNoneNearest(en:echoes.Entity, near:On_UINearestFlag) {
		if (near.distance > dist_to_player) {
			en.remove(On_UINearestFlag);
		}
	}

	@u function convertNearestToTargeted(en:echoes.Entity, near:On_UINearestFlag){
		
		en.add(new On_UITargetedObject());
		en.remove(On_UINearestFlag);
	}

	@a function updateNearest(en:echoes.Entity, add:On_UITargetedObject, s:UISelectableFlag, gp:GridPosition) {

		var selector = SELECTOR.entities.head.value;
		
		if(!selector.exists(TransformPositionComponent)){
			var duration:Float = 0.1;
			var tar = gp.gpToVector();
			var ori = selector.get(GridPosition).gpToVector();
			selector.remove(On_UIPadMove);
			selector.add(new TransformPositionComponent(ori,tar,duration,TBurnOut));
			
		}

		en.add(new On_UICurrentlySelected());
		en.remove(On_UITargetedObject);
	}

}
