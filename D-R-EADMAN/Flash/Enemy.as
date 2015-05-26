package  {
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Enemy extends MovieClip{

		var world:World;
		var game:Game;
		var level:Level;
		var life;
		var blink:Timer;
		var aux = -20;
		public function Enemy(world:World,level:Level) {
			this.world = world;
			this.game = level.game;
			blink = new Timer(800,0);
		}
		
		public function startBlinking(){
			blink.addEventListener(TimerEvent.TIMER,stopBlinking);
			blink.start();
		}
		
		public function stopBlinking(e:TimerEvent){
			blink.removeEventListener(TimerEvent.TIMER,stopBlinking);
			this.alpha = 1;
			blink = new Timer(1000,0);
		}
		
		public function dispose(){
			if(blink.running){
				blink.removeEventListener(TimerEvent.TIMER,stopBlinking);
			}
		}

	}
	
}
