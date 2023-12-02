/* package aleiiioa.systems.local.ui.selector;;

import echoes.System;
import echoes.View;
import aleiiioa.flags.ui.*;


class SelectorSelectabilitySystem extends echoes.System {
	var SELECTABLE:View<UISelectableFlag>;

	public function new() {}

 	@a function selectorOnCategoryA(en:echoes.Entity, add:UICategory_A, s:UISelectorFlag) {
		
		var head = SELECTABLE.entities.head;

		while (head != null){
			var sel = head.value;
			if(!sel.exists(UICategory_A))
				sel.remove(UIObject);

			head = head.next;
		}
	}

	@a function selectorOnCategoryB(en:echoes.Entity, add:UICategory_B, s:UISelectorFlag) {

		var head = SELECTABLE.entities.head;

		while (head != null){
			var sel = head.value;
			if(!sel.exists(UICategory_B))
				sel.remove(UIObject);

			head = head.next;
		}
	}
 
	@r function onRemoveSelector(rem:UISelectorFlag){
		var head = SELECTABLE.entities.head;
		while (head != null){
			var en = head.value;
				en.remove(UIObject);
			
				head = head.next;
		}
	}
	
	@a function turnCategoryAtoSelectable(en:echoes.Entity, category:UICategory_A, add:UIObject) {
		en.add(new UISelectableFlag());
	}

	@a function turnCategoryBtoSelectable(en:echoes.Entity, category:UICategory_B, add:UIObject) {
		en.add(new UISelectableFlag());
	}

	@r function removeUIObjectFromSelectable(en:echoes.Entity,rem:UIObject){
		en.remove(UISelectableFlag);
	}
}
 */

