package aleiiioa.systems.solver;


import h3d.Vector;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.core.camera.FluidScrollerComponent;
import dn.Bresenham;
import echoes.System;
import aleiiioa.builders.Builders;

import aleiiioa.components.core.position.FluidPosition;
import aleiiioa.components.core.velocity.VelocityAnalogSpeed;

import aleiiioa.components.solver.SolverUVComponent;
import aleiiioa.components.solver.CellComponent;
import aleiiioa.components.solver.ModifierComponent;




class SolverSystem extends echoes.System {
    // move all maximum to const // 
    var game(get,never) : Game; inline function get_game() return Game.ME;
    var level(get,never) : Level; inline function get_level() return Game.ME.level;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);

    var isw(get,never): Float; inline function get_isw() return 1 / width;
    var ish(get,never): Float; inline function get_ish() return 1 / height;

	var aspectRatio(get,never):Float ;inline function get_aspectRatio() return width * ish;
	var aspectRatio2(get,never):Float;inline function get_aspectRatio2() return aspectRatio * aspectRatio;

    
    var FLUID_WIDTH(get,never) : Int; inline function get_FLUID_WIDTH()  return level.cWid;
    var FLUID_HEIGHT(get,never): Int; inline function get_FLUID_HEIGHT() return Const.FLUID_MAX_HEIGHT;
    
    var solver: FluidSolver;
    var topFluidScroll : Int;

    public function new() {
        solver = new FluidSolver(FLUID_WIDTH,FLUID_HEIGHT);
        createCellsComponents();
    }

    @a function onModifierAdded(mod:ModifierComponent,fpos:FluidPosition) {
        reinitModifiedCellsList(mod,fpos);
    }
    @u function getFluidScrollerPosition(scr:FluidScrollerComponent,gpos:GridPosition){
        topFluidScroll = gpos.cy;
    }

    @u function cellUpdate(cc:CellComponent,vas:VelocityAnalogSpeed){
        cc.u = solver.getUatIndex(cc.index);
        cc.v = solver.getVatIndex(cc.index);
    } 

    @u function updateSolverUVComponent(suv:SolverUVComponent,fpos:FluidPosition){
        var index = solver.getIndexForCellPosition(fpos.cx,fpos.cy);
        if(solver.checkIfIndexIsInArray(index)){
            suv.uv = solver.getUVVectorForIndexPosition(index);
        }
    }


    @u function pullModifierInput(mod:ModifierComponent,fpos:FluidPosition){
        if(mod.isBlowing){
            for( c in mod.informedCells){
               setUVatIndex(c.u,c.v,c.index);
            }
        }

        reinitModifiedCellsList(mod,fpos);
    }
    
    @u function globalSolverUpdate(){
       
        solver.update();
        setLevelCollisionObstacles();
    }

    private function setLevelCollisionObstacles(){


        var bottomFluidScroll = topFluidScroll + Const.FLUID_MAX_HEIGHT;
        var walls:Array<{x:Int,y:Int,n:Vector}> = [];

        for (cx in 0...level.cWid){
            for (cy in topFluidScroll...bottomFluidScroll){
                if(level.hasCollision(cx,cy)){
                    var cyFluid = cy-topFluidScroll;
                    var norm = getWallNormal(cx,cy);
                    walls.push({x:cx,y:cyFluid,n:norm});
                }
            }
        }

        for (w in walls){
            var index = solver.getIndexForCellPosition(w.x,w.y);
            setUVatIndex(w.n.x,w.n.y,index);
        }
        
    }

    private function reinitModifiedCellsList(mod:ModifierComponent,fpos:FluidPosition) {
        
        var list = Bresenham.getDisc(fpos.cx,fpos.cy, mod.areaRadius);
    	mod.informedCells = [];
		for(c in list){
			if(solver.checkIfCellIsInGrid(c.x,c.y)){
				var i = solver.getIndexForCellPosition(c.x,c.y);
				mod.informedCells.push({index: i,x:c.x,y:c.y,abx: 0,aby: 0,u: 0,v: 0,dist:0});
			}
		}
    }
    

    private function createCellsComponents() {
        for(j in 0...solver.height) {
			for(i in 0...solver.width) {
                var index = solver.getIndexForCellPosition(i,j);
                Builders.solverCell(i,j,index);
            }
        } 
    }


    private function addForce(cx:Int, cy:Int, dx:Float, dy:Float):Void {
		var speed:Float = dx * dx  + dy * dy * aspectRatio2;
		if(speed > 0) {
			var velocityMult:Float = 1;
			var index:Int = solver.getIndexForCellPosition(cx,cy);

			solver.uOld[index] += dx * velocityMult;
			solver.vOld[index] += dy * velocityMult;
		}
	}
    private function setUVatIndex(u:Float,v:Float,index:Int){
        solver.u[index] = u;
        solver.v[index] = v;
        solver.uOld[index] = u;
        solver.vOld[index] = v;
    }


    private function getWallNormal(cx:Int,cy:Int){
        var dir = new Vector();

        if(!level.hasCollision(cx,cy-1))
            dir.y -= 1;// reduce counter stream instead of 1
        
        if(!level.hasCollision(cx,cy+1))
            dir.y += 0.4;

        if(!level.hasCollision(cx-1,cy))
            dir.x -= 1;

        if(!level.hasCollision(cx+1,cy))
            dir.x += 1;
        
        //dir.normalize();
        
        return dir.multiply(1);
    }

}