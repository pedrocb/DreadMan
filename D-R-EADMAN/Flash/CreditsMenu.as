package  {
	
	public class CreditsMenu extends Level{
		import flash.events.MouseEvent;
		var startlevel;
		public function CreditsMenu(game:Game) {
			super(game);

		}
		override public function load(){
			var background = new Background5;
			background.x = 0;
			background.y = 0;
			game.addChild(background);
			var quitbutton = new Button1(1101,670,177,80);
			game.addChild(quitbutton);
			quitbutton.addEventListener(MouseEvent.CLICK, buttonpressed);
		}
		public function buttonpressed(e:MouseEvent){
			game.levelmanager.loadLevel(new StartMenu(game));
		}
	}
	
}
