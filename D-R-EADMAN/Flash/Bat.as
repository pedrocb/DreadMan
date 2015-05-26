package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Bat extends Enemy{
		var speed = 3;		
		var vX,vY;
		
		var canmoveright = true;
		var canmoveleft = true;
		var canmoveup = true;
		var canmovedown = true;
		
		
		public function Bat(x,y,world:World,level:GameLevel) {
			this.x = x;
			this.y = y;
			super(world,level);
			game.stage.addEventListener(Event.ENTER_FRAME,update);
			rotationY = 180;
			life = game.options.difficulty+1;
		}
		
		public function update(e:Event)
		{
			if(blink.running){
				this.alpha+=aux;
				if(this.alpha>=100){
					aux*-1;
				}
				if(this.alpha==0){
					aux*-1;
				}
			}
			if(!canmoveright && speed > 0){
				speed*=-1;
			}
			else if(!canmoveleft && speed <0){
				speed*=-1;
			}
			vX = speed;
			if (vX <0)
			{
				rotationY = 0;
			}
			else if (vX >0)
			{
				rotationY = 180;
			}
			checkCollisions();
			this.x+=vX;
		}
		
		public function checkCollisions()
		{
			var foundleft = false;
			var foundright = false;
			var foundup = false;
			var founddown = false;

			var leftTileX = (int)((this.x+vX-width/2 )/world.TILE_WIDTH);
			var rightTileX = (int)((1+this.x+ vX+width/2)/world.TILE_WIDTH);
			var upTileY = (int)((this.y-height)/world.TILE_HEIGHT);
			var downTileY = (int)((1+this.y)/world.TILE_HEIGHT);
			for (var y=upTileY; y<=downTileY; y++)
			{
				if (! foundleft)
				{
					if (world.tiles[y][leftTileX] == 1)
					{
						foundleft = true;
					}
				}
				if (! foundright)
				{
					if (world.tiles[y][rightTileX] == 1)
					{
						foundright = true;
					}
				}
			}
			leftTileX = (int)((this.x-width/2 )/world.TILE_WIDTH);
			rightTileX = (int)((1+this.x+width/2)/world.TILE_WIDTH);
			upTileY = (int)((this.y+vY-height)/world.TILE_HEIGHT);
			downTileY = (int)((1+this.y+vY)/world.TILE_HEIGHT);
			for (var x=leftTileX; x<=rightTileX; x++)
			{
				if (! foundup)
				{
					if (world.tiles[upTileY][x] == 1)
					{
						foundup = true;
					}
				}
				if (! founddown)
				{
					if (world.tiles[downTileY][x] == 1)
					{
						founddown = true;
					}
				}
			}
			if(foundleft){
				if(canmoveleft && vX <0){
					if(((this.x-this.width/2)%world.TILE_WIDTH) < world.TILE_WIDTH/2){
						vX = 2- ((this.x-this.width/2)%world.TILE_WIDTH); 
						speed*=-1;
					}
					canmoveleft = false;
				}
				else{
					vX = 0;
				}
			}
			else{
				if(!canmoveleft){
					canmoveleft = true;
				}
			}
			if(foundright){
				if(canmoveright && vX>0){
					if((world.TILE_WIDTH - ((this.x+this.width/2)%world.TILE_WIDTH)) < world.TILE_WIDTH/2){
						vX = -2+(world.TILE_WIDTH - ((this.x+this.width/2)%world.TILE_WIDTH));
						speed*=-1;
					}
					canmoveright = false;
				}
				else{
					vX = 0;			
				}
			}
			else{
				if(!canmoveright){
					canmoveright = true;
				}
			}
			if(founddown){
				if(canmovedown && vY >0){
					if((world.TILE_HEIGHT - this.y%world.TILE_HEIGHT) <this.height/3){
						vY = -2 + (world.TILE_HEIGHT - this.y%world.TILE_HEIGHT); 
					}
					canmovedown = false;
				}
				else{
					vY = 0;	
				}
			}
			else{
				if(!canmovedown){
					canmovedown = true;
				}
			}
			if(foundup){
				if(canmoveup && vY <0){
					if((this.y-this.height)%world.TILE_HEIGHT <this.height/3){
						vY = 2 + (this.y-this.height)%world.TILE_HEIGHT;
					}
					canmoveup = false;
				}
				else{
					vY = 0;				
				}
			}
			else{
				if(!canmoveup){
					canmoveup = true;
				}
			}
		}
		
		override public function dispose(){
			super.dispose();
			game.stage.removeEventListener(Event.ENTER_FRAME,update);
		}
	}
	
}
