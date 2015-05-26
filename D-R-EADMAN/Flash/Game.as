package  {
	import flash.display.MovieClip;
	import flashx.textLayout.formats.BackgroundColor;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class Game extends MovieClip{
		var levelmanager:LevelManager;
		static var SCREEN_WIDTH = 1280;
		static var SCREEN_HEIGHT = 720;
		var options:Options;
		var music:Sound;
		var channel:SoundChannel;
		var soundtransformm:SoundTransform;
		var lastlevel = 0;
		var currentlevel =0;
		var levels;
 		public function Game() {
			levelmanager = new LevelManager(this);
			options = new Options(1,0);
			var aux = new StartMenu(this);
			levelmanager.loadLevel(aux);
			aux.playmusic();
			levels = [new Level1(this), new Level2(this), new Level3(this),new Level4(this),new Level5(this)];
			channel.soundTransform = soundtransformm;
		}

	}
	
}
