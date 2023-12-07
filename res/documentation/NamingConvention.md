:: Convention de nommage et d'utilisation des composants :: 
- core component    : Something.hx 

- données dynamique : SomethingComponent.hx
- données statique  : SomethingStaticComponent.hx
                    : SomethingSettingComponent.hx

- composant implicite   : Alg_Something_Component.hx On_Something.hx // 
the underscore signal that main use is implicit that mean that programmer shouldn't add or remove component 
without good knowledge of the algorythm. 


- données partagés      : SomethingSharedComponent.hx

- drapeaux statique     : SomethingStaticFlag.hx
- drapeaux dynamique    : SomethingFlag.hx

- calques : SomeSystemLayers_A.hx

- drapeaux ability - subject  : CanCatch.hx
- drapeaux ability - object   : IsCatchable.hx 

- événement d'ajout : OnAction.hx
- composant implicite lié a un algorythme precis : Adjective_Something.hx, Verb_Something.hx for example. 

:: Convention de nommage et d'utilisation des system :: 

- La ordre d'ecriture d'un system suis du mieux ce schema : 
    
    - @add entity creation or adding component event,
    - local system update (if needed/possible), 
    - @u entity updt
    - @r entity remove or component remove event 
    - local function needed by the local sys 

:: Convention de nommage des entités :: 

:: Convention de nommage variable :: 

- temporary variable inside a system : camelCase
- component variable float/int value : old_school_x 

