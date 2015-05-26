package 
{
	import flashx.textLayout.accessibility.TextAccImpl;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;

	public class GameLevel extends Level
	{
		var player:Player;
		var world:World;
		var Backgrounds:Array;
		var enemies:Array;
		var potions:Array;
		var deadBar:MovieClip;
		var barra:MovieClip;
		var percentage:TextField;
		var grey:Shape;
		var keysGUI:Array;
		var keys:Array;
		var paused:Boolean;
		var door:MovieClip;
		
		var pause:Pause;
		var gameover:GameOver;
		var levelcomplete:LevelComplete;

		public function GameLevel(game:Game)
		{
			super(game);
			game.stage.focus = game.stage;
			percentage = new TextField;
			barra = new MovieClip;
			barra.graphics.beginFill(0x000000);
			barra.graphics.drawRect(0,0,Game.SCREEN_WIDTH,50);
			barra.graphics.endFill();
			deadBar = new DeadBar;
			deadBar.x = barra.width/2;
			deadBar.y = barra.height/2 + deadBar.height/2;
			deadBar.Bar.width = 0;
			percentage.y =-deadBar.height/2 - 10 ;
			percentage.text = "0%";
			deadBar.addChild(percentage);
			keysGUI = new Array;
			for(var i=0;i<5;i++){
				var key = new Key;
				key.x = key.width + i*(key.width+5);
				key.y = barra.height/2 + key.height/2;
				key.gotoAndStop(1);
				keysGUI[i] = key;
				barra.addChild(key);
			}
			barra.addChild(deadBar);
			grey = new Shape  ;
			grey.graphics.beginFill(0xE0E0E0);
			grey.graphics.drawRect(0,0,Game.SCREEN_WIDTH,Game.SCREEN_HEIGHT);
			grey.graphics.endFill();
			grey.alpha = 0;
			enemies = new Array  ;
			potions = new Array  ;
			keys = new Array;
			pause = new Pause(this);
			pause.x = Game.SCREEN_WIDTH/2 - pause.width/2;
			pause.y = Game.SCREEN_HEIGHT/2 -pause.height/2;
			gameover = new GameOver(game);
			gameover.x = Game.SCREEN_WIDTH/2 - gameover.width/2;
			gameover.y = Game.SCREEN_HEIGHT/2 -gameover.height/2;
			levelcomplete = new LevelComplete(this);
			levelcomplete.x = Game.SCREEN_WIDTH/2 - levelcomplete.width/2;
			levelcomplete.y = Game.SCREEN_HEIGHT/2 - levelcomplete.height/2;
					}
		override public function load()
		{
			game.stage.addEventListener(Event.ENTER_FRAME,update);
			game.stage.addEventListener(KeyboardEvent.KEY_DOWN,checkkey);
			game.channel.stop();

		}
		
		public function checkkey(e:KeyboardEvent){
			if(e.keyCode == Keyboard.P){
				if(paused){
					unpause();
				}
				else{
					lepause();
				}
			}
			if(e.keyCode == Keyboard.R){
				if(!paused){
					stage.frameRate = 60;
					game.levelmanager.loadLevel(new (Object(game.levelmanager.currentLevel).constructor)(game));
				}
			}
		}
	
		public function update(e:Event)
		{
			//trace(stage.frameRate);
			if(player.hitTestObject(door) && player.keys == keysGUI.length){
				door.gotoAndStop(2);
				completed();
			}
			else{
				door.gotoAndStop(1);
			}
			for (var i=0; i<potions.length; i++)
			{
				if (player.hitTestObject(potions[i]) && player.deadbar<100)
				{
					world.removeChild(potions[i]);
					potions[i] = potions[potions.length - 1];
					potions.pop();
					player.updatedeadbar(25);
					break;
				}
			}
			for (i=0; i<keys.length; i++)
			{
				if (player.hitTestObject(keys[i]))
				{
					world.removeChild(keys[i]);
					keys[i] = keys[keys.length - 1];
					keys.pop();
					player.keys++;
					keysGUI[player.keys-1].gotoAndStop(2); 
					break;
				}
			}
			for(i=0;i<enemies.length;i++)
			{
				var enemy = enemies[i];
				if (player.hitTestObject(enemy))
				{
					if(!player.attacking){
						if (player.deadbar !=0)
						{
							if (! player.dead)
							{
								player.updatedeadbar(-((game.options.difficulty+1)/10)*player.deadbar);
								player.dead = true;
								player.gotoAndStop(2);
								grey.alpha = 0.3;
								break;
							}
						
						}
						else
						{
							game.stage.frameRate = 0;
							end();
							return;
						}
					}
					else{
						if(player.attack.pa.hitTestObject(enemy)){
							if(!enemy.blink.running){
								enemy.life--;
								if(enemy.life == 0){
									world.removeChild(enemy);
									enemy.dispose();
									enemies[i] = enemies[enemies.length - 1];
									enemies.pop();
									player.updatedeadbar(10);
								}
								else{											
									enemy.startBlinking();	
								}
							}
						}
					}
				}
			}
		}
		
		public function completed(){
			stage.frameRate = 0;
			addChild(levelcomplete);
			if(game.currentlevel==game.lastlevel){
				game.lastlevel++;
				if(game.lastlevel>=game.levels.length){
					game.lastlevel=game.levels.length-1;
				}
			}
			trace(game.lastlevel);
			levelcomplete.finish();
		}
		
		public function end(){
			addChild(gameover);
			gameover.gameover();
		}
		
		public function lepause(){
			grey.alpha = 0.3;
			game.stage.frameRate = 0;
			game.stage.addChild(pause);
			pause.pause();
			paused = true;
			
		}
		
		public function unpause(){
			if(!player.dead){
				grey.alpha=0;
			}
			pause.removebuttons();
			game.stage.frameRate = 60;
			game.stage.removeChild(pause);
			paused = false;
		}
		
		override public function dispose(){
			super.dispose();
			game.stage.removeEventListener(Event.ENTER_FRAME,update);
			game.stage.removeEventListener(KeyboardEvent.KEY_DOWN,checkkey);
			player.dispose();
		}
	}

}