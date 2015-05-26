package  {
	import flash.display.MovieClip;
	
	public class Level extends MovieClip{
		var game:Game;
 		var clicksound;
		public function Level(game:Game) {
			this.game = game;
			this.clicksound = new Click;
		}
		public function dispose(){
			while(game.numChildren>0){
				game.removeChildAt(0);
			}
		}
		
		public function playsound(){
			clicksound.play(0,1,game.soundtransformm);
		}
		
		public function load(){
			
		}
	}
	
}
