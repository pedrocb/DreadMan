package  {
	
	public class LevelManager {
		var game:Game;
		var currentLevel:Level;
		public function LevelManager(game:Game) {
			this.game = game;
		}
		public function loadLevel(level:Level){
			if(currentLevel)currentLevel.dispose();
			level.load();
			game.addChild(level)
			currentLevel = level;
		}
	}
	
}
