package  {
	import flash.events.MouseEvent;
	public class Help extends Level{
		var exit;
		public function Help(game) {
			super(game);
			exit = new Button1(1122.35,667.10,126,55.60);
			addChild(exit);
			exit.addEventListener(MouseEvent.CLICK,leave);
		}
		
		override public function dispose(){
			exit.removeEventListener(MouseEvent.CLICK,leave);
		}
		
		public function leave(e:MouseEvent){
			playsound();
			game.levelmanager.loadLevel(new StartMenu(game));
		}

	}
	
}
