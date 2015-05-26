package 
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.display.Shape;

	import flash.sampler.Sample;

	public class Player extends MovieClip
	{
		var speed = 5;
		var jumpxspeed = 7;
		var game:Game;
		var world:World;
		var level:GameLevel;
		var WIDTH:Number;
		var HEIGHT:Number;
		var jumpspeed = 17;
		var attacking = 0;
		
		var diff:Number;

		var vY:Number;
		var vX:Number;

		var keys = 0;

		var gravity = 1;

		var dead:Boolean;
		var deadbar:Number;

		var canmoveright = true;
		var canmoveleft = true;
		var canmoveup = true;
		var canmovedown = true;

		var upkey = false;
		var downkey = false;
		var leftkey = false;
		var rightkey = false;

		public function Player(x:int,y:int,game:Game,world:World,level:GameLevel)
		{
			gotoAndStop(1);
			this.x = x;
			this.y = y;
			this.game = game;
			this.world = world;
			this.level = level;
			this.deadbar = 0;
			this.HEIGHT = this.height;
			this.WIDTH = this.width;
			this.diff = game.options.difficulty*.25/3 + 0.25; 
			/*var rectangle:Shape = new Shape  ;
			rectangle.graphics.beginFill(0x00FFFF);
			rectangle.graphics.drawRect(-this.width/2,-this.height,this.width,this.height);
			rectangle.graphics.endFill();
			addChild(rectangle);*/
			load();

		}

		public function load()
		{
			game.stage.addEventListener(KeyboardEvent.KEY_DOWN,keydown);
			game.stage.addEventListener(KeyboardEvent.KEY_UP,keyup);
			game.stage.addEventListener(Event.ENTER_FRAME,update);

		}

		public function dispose()
		{
			game.stage.removeEventListener(KeyboardEvent.KEY_DOWN,keydown);
			game.stage.removeEventListener(KeyboardEvent.KEY_UP,keyup);
			game.stage.removeEventListener(Event.ENTER_FRAME,update);
		}

		public function update(e:Event)
		{
			if (attacking>0)
			{
				attacking--;
				if (attacking==0)
				{
					if(!dead){
						gotoAndStop(1);
					}
				}
			}
			if (deadbar>0)
			{
				if (dead)
				{
					updatedeadbar(-diff);
				}
				if (deadbar <= 0)
				{
					deadbar = 0;
					dead = false;
					level.grey.alpha = 0;
					gotoAndStop(1);
				}

			}
			if (rightkey)
			{
				if (vY!=0)
				{
					vX = jumpxspeed;
				}
				else
				{
					vX = speed;
				}
			}
			if (leftkey)
			{
				if (vY!=0)
				{
					vX =  -  jumpxspeed;
				}
				else
				{
					vX =  -  speed;
				}
			}
			if (rightkey == leftkey)
			{
				vX = 0;
			}
			if (upkey)
			{
				if (dead)
				{
					vY =  -  jumpspeed / 2;
				}
				else
				{
					if (! canmovedown)
					{
						vY =  -  jumpspeed;
					}
				}
			}
			vY +=  gravity;
			if (vX <0)
			{
				rotationY = 180;
			}
			else if (vX >0)
			{
				rotationY = 0;
			}
			checkCollisions();
			checkAnimations();
			if (this.x > Game.SCREEN_WIDTH / 2 && vX > 0)
			{
				if (world.x-vX<(-world.tiles[0].length * world.TILE_WIDTH + Game.SCREEN_WIDTH))
				{
					this.x +=vX - (-world.tiles[0].length * world.TILE_WIDTH + Game.SCREEN_WIDTH  - world.x);
					world.x = (-world.tiles[0].length * world.TILE_WIDTH) + Game.SCREEN_WIDTH;
				}
				else
				{
					world.x -=  vX;
				}
			}
			else if (this.x < Game.SCREEN_WIDTH/2 && vX <0)
			{
				if (world.x - vX < 0)
				{
					world.x -=  vX;
				}
				else
				{
					this.x +=  vX + world.x;
					world.x = 0;
				}
			}
			else
			{
				this.x +=  vX;
			}
			if (this.y < Game.SCREEN_HEIGHT / 2 && vY < 0)
			{
				if (world.y - vY < -3*world.TILE_HEIGHT/4)
				{
					world.y -=  vY;
				}
				else
				{
					this.y +=  vY;
				}
			}
			else if (this.y > Game.SCREEN_HEIGHT/2 && vY >0)
			{
				if ( world.y - vY > -Game.SCREEN_HEIGHT - 3 * world.TILE_HEIGHT / 4)
				{
					world.y -=  vY;
				}
				else
				{
					this.y +=  vY+((-  Game.SCREEN_HEIGHT - 3 * world.TILE_HEIGHT / 4) - world.y);
					world.y =  -  Game.SCREEN_HEIGHT - 3 * world.TILE_HEIGHT / 4;
				}
			}
			else
			{
				this.y +=  vY;
			}



		}

		public function checkAnimations()
		{
			if (! dead)
			{
				if (canmovedown)
				{
					if (attacking>0)
					{
						gotoAndStop(5);
					}
					else
					{
						gotoAndStop(4);
					}
				}
				else
				{
					if (vX == 0)
					{
						if (attacking>0)
						{
							gotoAndStop(5);
						}
						else
						{
							gotoAndStop(1);
						}
					}
					else
					{
						if (attacking>0)
						{
							gotoAndStop(5);
						}
						else
						{
							gotoAndStop(3);
						}
					}
				}
			}
		}

		public function keydown(e:KeyboardEvent)
		{
			if (e.keyCode == Keyboard.RIGHT)
			{
				rightkey = true;
			}
			if (e.keyCode == Keyboard.LEFT)
			{
				leftkey = true;
			}
			if (e.keyCode == Keyboard.DOWN)
			{
				downkey = true;
			}
			if (e.keyCode == Keyboard.UP)
			{
				upkey = true;
			}
			if (e.keyCode == Keyboard.Q)
			{
				if (dead)
				{
					dead = false;
					level.grey.alpha = 0;
					gotoAndStop(1);
				}
				else
				{
					if (deadbar>0)
					{
						dead = true;
						level.grey.alpha = 0.3;
						gotoAndStop(2);
					}
				}
			}
			if (e.keyCode == Keyboard.W)
			{
				if (! dead)
				{
					gotoAndStop(5);
					attacking = 14;
				}
			}
		}

		public function keyup(e:KeyboardEvent)
		{
			if (e.keyCode == Keyboard.RIGHT)
			{
				rightkey = false;
			}
			if (e.keyCode == Keyboard.LEFT)
			{
				leftkey = false;
			}
			if (e.keyCode == Keyboard.DOWN)
			{
				downkey = false;
			}
			if (e.keyCode == Keyboard.UP)
			{
				upkey = false;
			}
		}

		public function checkCollisions()
		{
			var foundleft = false;
			var foundright = false;
			var foundup = false;
			var founddown = false;

			var leftTileX = (int)((this.x-world.x+vX-WIDTH/2 )/world.TILE_WIDTH);
			if (this.x - world.x + vX - WIDTH / 2 < 0)
			{
				leftTileX = -1;
			}
			var rightTileX = (int)((1+this.x-world.x+ vX+WIDTH/2)/world.TILE_WIDTH);
			if (1+this.x+ vX+WIDTH/2>Game.SCREEN_WIDTH)
			{
				rightTileX = -1;
			}
			var upTileY = (int)((this.y-world.y-HEIGHT)/world.TILE_HEIGHT);
			var downTileY = (int)((1-world.y+this.y)/world.TILE_HEIGHT);
			for (var y=upTileY; y<=downTileY; y++)
			{
				if (! foundleft)
				{
					if (getTile(y,leftTileX) == 1)
					{
						foundleft = true;
					}
				}
				if (! foundright)
				{
					if (getTile(y,rightTileX) == 1 || (getTile(y,rightTileX) == 5 && keys<level.keysGUI.length))
					{
						foundright = true;
					}
				}
			}
			if (! foundright)
			{
				rightTileX = (int)((1+this.x+vX-world.x+WIDTH/2)/world.TILE_WIDTH);
			}
			else
			{
				rightTileX = (int)((1+this.x-world.x+WIDTH/2)/world.TILE_WIDTH);
			}
			if (! foundleft)
			{
				leftTileX = (int)((this.x+vX-world.x-WIDTH/2 )/world.TILE_WIDTH);
			}
			else
			{
				leftTileX = (int)((this.x-world.x-WIDTH/2 )/world.TILE_WIDTH);
			}
			upTileY = (int)((this.y+vY-world.y-HEIGHT)/world.TILE_HEIGHT);
			if ((this.y+vY-world.y-HEIGHT)<0)
			{
				upTileY = -1;
			}
			downTileY = (int)((1+this.y-world.y+vY)/world.TILE_HEIGHT);
			for (var x=leftTileX; x<=rightTileX; x++)
			{
				if (! foundup)
				{

					if (getTile(upTileY,x) == 1)
					{
						foundup = true;
					}
				}
				if (! founddown)
				{
					if (getTile(downTileY,x) == 1)
					{
						founddown = true;
					}
				}
			}
			if (foundleft)
			{
				if (canmoveleft && vX <0)
				{
					if (((this.x-world.x-this.WIDTH/2)%world.TILE_WIDTH) < world.TILE_WIDTH/2)
					{
						vX = 2- ((this.x-world.x-this.WIDTH/2)%world.TILE_WIDTH);
					}
					canmoveleft = false;
				}
				else
				{
					vX = 0;
				}
			}
			else
			{
				if (! canmoveleft)
				{
					canmoveleft = true;
				}
			}
			if (foundright)
			{
				if (canmoveright && vX>0)
				{
					if ((world.TILE_WIDTH - ((this.x-world.x+this.WIDTH/2)%world.TILE_WIDTH)) < world.TILE_WIDTH/2)
					{
						vX = -2+(world.TILE_WIDTH - ((this.x-world.x+this.WIDTH/2)%world.TILE_WIDTH));
					}
					else
					{
						vX = (this.x-world.x+this.WIDTH/2)%world.TILE_WIDTH;
					}
					canmoveright = false;
				}
				else
				{
					vX = 0;
					//gotoAndStop(1);
				}
			}
			else
			{
				if (! canmoveright)
				{
					canmoveright = true;
				}
			}
			if (founddown)
			{
				if (canmovedown && vY >0)
				{
					vY = -2 + (world.TILE_HEIGHT - (this.y-world.y)%world.TILE_HEIGHT);
					canmovedown = false;
				}
				else
				{
					vY = 0;
				}
			}
			else
			{
				canmovedown = true;
			}
			if (foundup)
			{
				if (canmoveup && vY <0)
				{
					vY = -((this.y-this.HEIGHT-world.y)%world.TILE_HEIGHT) + 2;
					canmoveup = false;
				}
				else
				{
					vY = 0;
				}
			}
			else
			{
				if (! canmoveup)
				{
					canmoveup = true;
				}
			}
		}
		
		public function updatedeadbar(i:Number){
			deadbar += i;
			if(deadbar >100){
				deadbar = 100;
			}
			level.deadBar.Bar.width = deadbar/100 * level.deadBar.width;
			level.percentage.text = (int(deadbar)).toString()+"%";		
		}

		public function getTile(y:int,x:int):int
		{
			if (x<0 || x>world.tiles[0].length)
			{
				return 1;
			}
			if (y<0 || y>world.tiles.length-1)
			{
				return 1;
			}
			else
			{
				return world.tiles[y][x];
			}
		}
	}
}