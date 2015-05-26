package  {
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	
	public class VictoryMenu extends Level{
		var player;
		var back;
		var timer = new Timer(5000,0);
		public function VictoryMenu(game) {
			super(game);
			game.channel.stop();
			back = new VictoryBackground;
			addChild(back);
			player = new Victory;
			player.x = 673.95;
			player.y = 515.40;
			back.addChild(player);
			timer.addEventListener(TimerEvent.TIMER,addevent);
			timer.start();
		}
		
		override public function load(){
			game.soundtransformm = new SoundTransform(game.options.vol);
			game.music =new VictoryMusic;
			game.channel = game.music.play(0,9999,game.soundtransformm);
		}
		
		public function addevent(e:TimerEvent){
			game.stage.addEventListener(MouseEvent.CLICK,leave);
		}
		
		public function leave(e:MouseEvent){
			game.channel.stop();
			game.stage.removeEventListener(MouseEvent.CLICK,leave);
			var newgame = new StartMenu(game);
			game.levelmanager.loadLevel(newgame);
			newgame.playmusic();
		}

	}
	
}
