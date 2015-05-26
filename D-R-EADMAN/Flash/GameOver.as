package  {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class GameOver extends MovieClip{

		var retry:Button1;
		var game:Game;
		var menu:Button1;
		public function GameOver(game:Game) {
			this.game = game;
			this.retry = new Button1(252.35,142.65,140.70,40.85);
			this.menu = new Button1(256.35,186.70,116.55,39.90);
			addChild(retry);
			addChild(menu);
		}
		
		public function gameover(){
			retry.addEventListener(MouseEvent.CLICK,newgame);
			menu.addEventListener(MouseEvent.CLICK,startmenu);
		}
		
		public function newgame(e:MouseEvent){
			game.levelmanager.currentLevel.playsound();
			removebuttons();
			game.levelmanager.loadLevel(new (Object(game.levelmanager.currentLevel).constructor)(game));
		}
		
		public function startmenu(e:MouseEvent){
			game.levelmanager.currentLevel.playsound();
			removebuttons();
			var menu = new StartMenu(game);
			game.levelmanager.loadLevel(menu);
			menu.playmusic();
		}
		
		public function removebuttons(){
			game.stage.frameRate = 60;
			retry.removeEventListener(MouseEvent.CLICK,newgame);
		}
		

	}
	
}
