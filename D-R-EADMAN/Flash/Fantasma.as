package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Shape;
	
	public class Fantasma extends GroundEnemy{
		public function Fantasma(x:int,y:int,world:World,level:GameLevel){
			super(x,y,world,level);
			speed = 1.5;
			life = game.options.difficulty + 2;
		}
	}
	
}
