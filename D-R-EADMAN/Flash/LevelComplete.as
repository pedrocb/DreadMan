package  {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class LevelComplete extends MovieClip{
		var level:GameLevel;
		var game:Game;
		
		var nextlevel:Button1;
		var restart:Button1;
		
		public function LevelComplete(level:GameLevel) {
			this.level = level;
			this.game = level.game;
			nextlevel = new Button1(381.35,142.30,281.95,38.10);
			restart = new Button1(394.30,190.25,192.45,40.75);
			addChild(nextlevel);
			addChild(restart);
		}
		
		public function finish(){
			nextlevel.addEventListener(MouseEvent.CLICK,newlevel);
			restart.addEventListener(MouseEvent.CLICK,reset);
		}
		
		public function reset(){
			removebuttons();
			stage.frameRate = 60;
			var startmenu = new StartMenu(game);
			game.levelmanager.loadLevel(startmenu);
			startmenu.playmusic();
		}
		
		public function newlevel(e:MouseEvent){
			removebuttons();
			stage.frameRate = 60;
			if(game.currentlevel+1<game.levels.length){
				game.levelmanager.loadLevel(new (Object(game.levels[game.currentlevel+1]).constructor)(game));
			}
			else{
				var startmenu = new StartMenu(game);
				game.levelmanager.loadLevel(startmenu);
				startmenu.playmusic();			
			}
		}

		public function removebuttons(){
			nextlevel.removeEventListener(MouseEvent.CLICK,newlevel);
			restart.removeEventListener(MouseEvent.CLICK,reset);			
		}
	}
	
}
