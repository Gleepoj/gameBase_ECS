package aleiiioa.components.local.dialog;
import haxe.io.Path;
class DialogReferenceComponent {
    public var reference:String;
    public var res:hxd.res.Any;
    public var attachX:Float;
    public var attachY:Float;
    
    public function new(yarnFilePath:String,x:Float,y:Float) {
        
        var dialogName = Path.withoutDirectory(yarnFilePath);
        reference = dialogName;
       
        var path:String = "yarn/"+dialogName;
        
        res = hxd.Res.loader.load(path); 
        attachX = x;
        attachX = y; 
    }
}