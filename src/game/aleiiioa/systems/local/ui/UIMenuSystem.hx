/* package aleiiioa.systems.ui;






class UIMenuSystem extends echoes.System {
    // Load menu and manage UI submenu and UIelements
    var window = hxd.Window.getInstance();
    var current_GS:UI_Button_Event;
    var previous_GS:UI_Button_Event;

    var onNewOver = false;
    var onOverInteractGp:GridPosition = new GridPosition(0,0,0,0);
    
    var mx:Int = 0;
    var my:Int = 0;

    var freeMove:Bool = false;


    public function new(){
        current_GS = GameState_Menu;
    }

    @:a function onAddButton(add:UIButton,interactive:InteractiveHeapsComponent,gp:GridPosition,nine:ScaleGrid) {

        interactive = new Interactive(add.scaleGrid.width,add.scaleGrid.height,add.scaleGrid);

        interactive.onOver = function(_) {
            //add.scaleGrid.alpha = 0.5;
           // add.label.color.r = 0 ;
            onOverInteractGp = gp;
            onNewOver = true;
        }

        interactive.onOut = function(_){
            //add.scaleGrid.alpha = 1;
           // add.label.color.r = 1 ;
           // spr.alpha = 1; 
        }

        interactive.onClick = function (_) {
            //interact(add.event);
            //onOverInteractGp = gp;
            //onNewOver = true;
        }
        
    }

    @:u function updatePos(add:UIObject,nine:ScaleGrid,gp:GridPosition) {
       
        var x = nine.x;
        var y = nine.y;
 
        var xp = nine.parent.getAbsPos().x;
        var yp = nine.parent.getAbsPos().y;
        
 
        gp.setPosPixel(x+xp,y+yp);
        
    }

    @:u function onSelectorOverButton(select:InteractiveHeapsComponent,cl:CollisionsListener,ui:UIButton){
        
        if(cl.overInteractive){
            current_GS = ui.event;
        }
    }



    @:u function cursor_position_update(en:echoes.Entity,gp:GridPosition,selector:UISelectorFlag) {
        
        if(onNewOver && !en.exists(TransformPositionComponent) ){
            var ori = gp.gpToVector();
            var tar = onOverInteractGp.gpToVector();

            en.add(new TransformPositionComponent(ori,tar,0.1,TBurnOut));
            onNewOver = false;
        }

        if(freeMove && !en.exists(TransformPositionComponent)){
            //gp.setPosCase(mx,my);
        }

    }

    @:u function mouse_position_update(dt:Float,m:MouseComponent,gp:GridPosition,spr:SpriteComponent) {
        //spr.visible = true;
        m.cd.update(dt);
        m.setLastPos(m.x,m.y);
        m.x = window.mouseX;
        m.y = window.mouseY;

        if(m.onMove && !m.cd.has("onMove"))
            m.cd.setMs("onMove",100);

        if(m.cd.has("onMove")){
            spr.colorize(0xff0000);
            freeMove = true;
        }

        if(!m.cd.has("onMove")){
            spr.uncolorize(); 
            freeMove = false;
        }
   
        m.x = window.mouseX;
        m.y = window.mouseY;
        gp.setPosPixel(m.x,m.y);
      
        //mx = gp.cx;
        //my = gp.cy;
        
      
    }

    @:u function selectorInteract(inp:InputComponent){
        if(inp.ca.isPressed(ActionX))
            interact(current_GS);
        
    }

    function interact(button_event : UI_Button_Event){
        switch button_event{
            case GameState_Play:Aleiiioa.ME.startPlay();
            case GameState_Load:Aleiiioa.ME.startPlay();
            case GameState_Settings:Aleiiioa.ME.goToSetting();
            case GameState_Quit:App.ME.exit();
            case GameState_Menu:Aleiiioa.ME.goToMenu();
        }
    }

    @:r function removeSc(sc:ScaleGrid){
        //sc.clear();
        sc.remove();
        //trace("clear scale grid");
    }
}
 */

