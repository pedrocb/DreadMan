package 
{
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.system.fscommand;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundTransform;


	public class StartMenu extends Level
	{
		var player:MovieClip;
		var speed = 3;		
		var grey:Shape;
		var playin;
		var creditsbutton = new Button1(611,441,175,42);
		var exitbutton = new Button1(626,486,94,39);
		var newgamebutton = new Button1(622,310,113,39);
		var optionsbutton = new Button1(610.30,398.30,175.60,39);
		var helpbutton = new Button1(621.15,355.80,114.20,41.50);
	
	
		public function StartMenu(game:Game)
		{
			super(game);
		}
		override public function load()
		{
			grey = new Shape  ;
			grey.graphics.beginFill(0xE0E0E0);
			grey.graphics.drawRect(0,0,Game.SCREEN_WIDTH,Game.SCREEN_HEIGHT);
			grey.graphics.endFill();
			grey.alpha = 0;
			player = new PlayerS;
			player.x = Game.SCREEN_WIDTH/2;
			player.y = Game.SCREEN_HEIGHT-64/4;
			player.gotoAndStop(3);
			var background = new Menu1();
			addChild(background);
			creditsbutton.addEventListener(MouseEvent.CLICK, creditsbuttonpressed);
			exitbutton.addEventListener(MouseEvent.CLICK, quit);
			newgamebutton.addEventListener(MouseEvent.CLICK, startgame);
			game.stage.addEventListener(Event.ENTER_FRAME,update);
			optionsbutton.addEventListener(MouseEvent.CLICK,options);
			helpbutton.addEventListener(MouseEvent.CLICK,help);
			addChild(newgamebutton);
			addChild(creditsbutton);
			addChild(exitbutton);
			addChild(helpbutton);
			addChild(grey);
			addChild(optionsbutton);
			addChild(player);
		}
		
		public function help(e:MouseEvent){
			playsound();
			game.levelmanager.loadLevel(new Help(game));
		}
		
		public function creditsbuttonpressed(e: MouseEvent)
		{
			playsound();
			game.levelmanager.loadLevel(new CreditsMenu(game));
		}
		public function startgame(e:MouseEvent){
			playsound();
			game.levelmanager.loadLevel(new LevelMenu(game));
		}
		
		override public function dispose(){
			super.dispose();
			creditsbutton.removeEventListener(MouseEvent.CLICK, creditsbuttonpressed);
			exitbutton.removeEventListener(MouseEvent.CLICK, quit);
			newgamebutton.removeEventListener(MouseEvent.CLICK, startgame);
			game.stage.removeEventListener(Event.ENTER_FRAME,update);
			optionsbutton.removeEventListener(MouseEvent.CLICK,options);
		}
		
		public function options(e:MouseEvent){
			playsound();
			game.levelmanager.loadLevel(new OptionsMenu(game));
		}
		
		public function update(e:Event){
			if((player.x-player.width/2) > Game.SCREEN_WIDTH+20){
				player.gotoAndStop(2);
				grey.alpha = 0.3;
				player.x = Game.SCREEN_WIDTH+player.width/2;
				speed*=-1;
			}
			else if(player.x+player.width/2 < -20){
				player.gotoAndStop(3);
				grey.alpha = 0;
				player.x = -player.width/2;
				speed*=-1;
			}
			if (speed <0)
			{
				player.rotationY = 180;

			}
			else if (speed >0)
			{
				player.rotationY = 0;
			}			
			player.x+=speed;
		}
		
		public function playmusic(){
			game.soundtransformm = new SoundTransform(game.options.vol);
			game.music =new MenuMusic;
			game.channel = game.music.play(0,9999,game.soundtransformm);
		}
		
		public function quit(e:MouseEvent){
			playsound();
			fscommand("quit");
		}
	}
}