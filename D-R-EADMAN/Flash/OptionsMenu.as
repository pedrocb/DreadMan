package 
{
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.Shape;

	public class OptionsMenu extends Level
	{
		var difficulties;
		var box,onoffbox;
		var voolume:DeadBar;
		var onoff;
		var quitbutton:Button1;
		public function OptionsMenu(game:Game)
		{
			super(game);
			var back = new OptionsTablet  ;
			addChild(back);
			difficulties = [new Button2(441.75,304.35,110.00,43.00),new Button2(566.75,304.35,149.00,43.00),new Button2(730.75,307.35,110,39)];
			onoff = [new Button2(558.75,492.25,61.40,37.05),new Button2(637.75,492.25,82.40,37.05)];
			box = new Barra;
			onoffbox = new Barra;
			for (var i=0; i<difficulties.length; i++)
			{
				if (i!= game.options.difficulty)
				{
					addChild(difficulties[i]);
					difficulties[i].addEventListener(MouseEvent.CLICK,changedifficulty);
				}
				else
				{
					box.x = difficulties[i].x-2;
					box.y = difficulties[i].y-2;
					box.width = difficulties[i].width+4;
					box.height = difficulties[i].height+4;
					trace(difficulties[i].x);
					addChild(box);
				}
			}
			voolume = new DeadBar;
			voolume.x = 640.25;
			voolume.y = 437.25;
			voolume.width = 313.95;
			voolume.height = 32;
			voolume.Bar.width = game.options.vol* voolume.width;
			addChild(voolume);
			voolume.addEventListener(MouseEvent.CLICK,updatevolume);
			quitbutton = new Button1(624.30,570.30,116,37.90);
			quitbutton.addEventListener(MouseEvent.CLICK,quit);
			addChild(quitbutton);
			if(game.options.vol>0){
				addChild(onoffbox);
				onoffbox.x = onoff[0].x-2;
				onoffbox.y = onoff[0].y-2;
				onoffbox.width = onoff[0].width+4;
				onoffbox.height = onoff[0].height+4;
				addChild(onoff[1]);
				onoff[1].addEventListener(MouseEvent.CLICK,mute);
			}
			else{
				onoff[0].addEventListener(MouseEvent.CLICK,turnup);
				onoffbox.x = onoff[1].x-2;
				onoffbox.y = onoff[1].y-2;
				onoffbox.width = onoff[1].width+4;
				onoffbox.height = onoff[1].height+4;
				addChild(onoffbox);
				addChild(onoff[0]);
			}
		}

		public function quit(e:MouseEvent){
			game.levelmanager.loadLevel(new StartMenu(game));
			
		}
		
		override public function dispose(){
			voolume.removeEventListener(MouseEvent.CLICK,updatevolume);
			if(game.options.vol>0){
				onoff[1].removeEventListener(MouseEvent.CLICK,mute);
			}
			else{
				onoff[0].removeEventListener(MouseEvent.CLICK,turnup);
			}
			for(var i=0;i<difficulties.length;i++){
				if(i!=game.options.difficulty){
					difficulties[i].removeEventListener(MouseEvent.CLICK,changedifficulty);
				}
			}
		}
		
		public function updatevolume(e:MouseEvent){
			if(game.options.vol == 0){
				onoff[1].addEventListener(MouseEvent.CLICK,mute);
				onoffbox.x = onoff[0].x-2;
				onoffbox.y = onoff[0].y-2;
				onoffbox.width = onoff[0].width+4;
				onoffbox.height = onoff[0].height+4;
				addChild(onoff[1]);
				removeChild(onoff[0]);
				onoff[0].removeEventListener(MouseEvent.CLICK,turnup);
			}
			voolume.Bar.width = e.stageX  - voolume.x+voolume.width/2;
			game.soundtransformm.volume = voolume.Bar.width/voolume.width;
			game.options.vol = game.soundtransformm.volume;
			game.channel.soundTransform = game.soundtransformm;
			game.options.lastvol = game.options.vol;
			
		}
		
		public function turnup(e:MouseEvent){
			voolume.Bar.width = game.options.lastvol* voolume.width;
			game.soundtransformm.volume = voolume.Bar.width/voolume.width;
			game.options.vol = game.soundtransformm.volume;
			game.channel.soundTransform = game.soundtransformm;
			game.options.lastvol = game.options.vol;
			onoffbox.x = onoff[0].x-2;
			onoffbox.y =onoff[0].y-2;
			onoffbox.width = onoff[0].width+4;
			onoffbox.height = onoff[0].height+4;
			removeChild(onoff[0]);
			addChild(onoff[1]);
			onoff[1].addEventListener(MouseEvent.CLICK,mute);
			onoff[0].removeEventListener(MouseEvent.CLICK,turnup);
		}
		
		public function mute(e:MouseEvent){
			game.options.lastvol = game.options.vol;
			voolume.Bar.width = 0;
			game.soundtransformm.volume = 0;
			game.options.vol = 0;
			game.channel.soundTransform = game.soundtransformm;
			onoffbox.x = onoff[1].x -2;
			onoffbox.y = onoff[1].y - 2;
			onoffbox.width = onoff[1].width +4;
			onoffbox.height = onoff[1].height+4;
			addChild(onoff[0]);
			onoff[0].addEventListener(MouseEvent.CLICK,turnup);
			removeChild(onoff[1]);
			onoff[1].removeEventListener(MouseEvent.CLICK,mute);
			

		}
		
		public function changedifficulty(e:MouseEvent)
		{
			for (var i=0; i<difficulties.length; i++)
			{
				if (e.target == difficulties[i])
				{
					if (e.target != game.options.difficulty)
					{
						box.x = difficulties[i].x-2;
						box.y = difficulties[i].y-2;
						box.width = difficulties[i].width+4;
						box.height = difficulties[i].height+4;
						removeChild(difficulties[i]);
						difficulties[i].removeEventListener(MouseEvent.CLICK,changedifficulty);
						addChild(difficulties[game.options.difficulty]);
						difficulties[game.options.difficulty].addEventListener(MouseEvent.CLICK,changedifficulty);
						game.options.difficulty = i;
					}
				}
			}
		}
	}

}