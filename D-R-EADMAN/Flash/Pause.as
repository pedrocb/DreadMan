package 
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.fscommand;
	import flash.net.URLRequest;
	import flash.media.Sound;

	public class Pause extends MovieClip
	{
		var resumebutton:Button1;
		var menubutton:Button1;
		var quitbutton:Button1;
		var level:GameLevel;
		var game:Game;

		public function Pause(level:GameLevel)
		{
			this.level = level;
			this.game = level.game;
			resumebutton = new Button1(123.15,150.50,173.05,40.30);
			menubutton = new Button1(117.15,194.70,236.70,40.15);
			quitbutton = new Button1(139.55,283.90,92.55,41.50);
			addChild(resumebutton);
			addChild(menubutton);
			addChild(quitbutton);
		}

		public function pause()
		{
			resumebutton.addEventListener(MouseEvent.CLICK, resume);
			menubutton.addEventListener(MouseEvent.CLICK,menu);
			quitbutton.addEventListener(MouseEvent.CLICK,quit);
		}
		
		public function menu(e:MouseEvent){
			removebuttons();
			game.stage.frameRate = 60;
			game.stage.removeChild(this);
			var menu = new StartMenu(game);
			game.levelmanager.loadLevel(menu);
			menu.playmusic();
		}

		public function resume(e:MouseEvent)
		{
			level.unpause();
			level.game.stage.focus = stage;
		}
		
		public function quit(e:MouseEvent){
			removebuttons();
			fscommand("quit");
		}
		
		public function removebuttons()
		{
			resumebutton.removeEventListener(MouseEvent.CLICK, resume);
			menubutton.removeEventListener(MouseEvent.CLICK,menu);
			quitbutton.removeEventListener(MouseEvent.CLICK,quit);
		}

	}

}