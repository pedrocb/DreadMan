package  {
	import flash.display.MovieClip;
	import flash.display.Loader;
	import fl.motion.Color;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	
	public class World extends MovieClip{
		var back:MovieClip;
		var WIDTH:Number;
		var HEIGHT:Number;
		var enemies:Array;
		var tiles:Array;
		var TILE_WIDTH:Number;
		var TILE_HEIGHT:Number;
		var level = GameLevel;
		public function World(level:GameLevel) {
			this.level = level;
			this.HEIGHT = Game.SCREEN_HEIGHT;
			TILE_WIDTH = 64;
			TILE_HEIGHT = 64;
		}
		
		public function load(){
			back.x = 0;
			back.y = 3*TILE_HEIGHT/4;
			addChild(back);
			for(y=0;y<tiles.length;y++){
				for(x=0;x<tiles[0].length;x++){
					var tile;
					if(tiles[y][x] == 1){
						tile = new Chao;
						tile.width = TILE_WIDTH;
						tile.height = TILE_HEIGHT;
						tile.x = x*tile.width;						tile.y = tile.height*y;						
						addChild(tile);
					}
					else if(tiles[y][x] == 3){
						tile = new Potion;
						tile.x = (x*TILE_WIDTH)+TILE_WIDTH/2;
						tile.y = TILE_HEIGHT*y +TILE_HEIGHT;
						level.potions.push(tile);
						addChild(tile);
					}
					else if(tiles[y][x] == 4){
						tile = new Fantasma((x*TILE_WIDTH)+TILE_WIDTH/2,TILE_HEIGHT*(y-1) + TILE_HEIGHT,this,level);
						level.enemies.push(tile);
						addChild(tile);
					}
					else if(tiles[y][x]==2){
						tile = new Key;
						tile.gotoAndStop(2);
						tile.x = x*TILE_WIDTH + TILE_WIDTH/2;
						tile.y = TILE_HEIGHT*y + TILE_HEIGHT;
						level.keys.push(tile);
						addChild(tile);
					}
					else if(tiles[y][x]==5){
						tile = new Door;
						tile.gotoAndStop(2);
						tile.x = TILE_WIDTH*x + TILE_WIDTH/2;
						tile.y = TILE_HEIGHT*y + TILE_HEIGHT;
						level.door = tile;
						addChild(tile);
					}
					else if(tiles[y][x] == 6){
						tile = new Bat(TILE_WIDTH*x + TILE_WIDTH/2,TILE_HEIGHT*y + TILE_HEIGHT,this,level);						
						level.enemies.push(tile);
						addChild(tile);
					}
					else if(tiles[y][x] == 7){
						tile = new Zombie((x*TILE_WIDTH)+TILE_WIDTH/2,TILE_HEIGHT*y -2 + TILE_HEIGHT,this,level);
						level.enemies.push(tile);
						addChild(tile);

					}
					/*else{
						tile = new Tile2;
						tile.width = TILE_WIDTH;
						tile.height = TILE_HEIGHT;
						tile.x = x*tile.width;
						tile.y = y*tile.height;
						addChild(tile);

					}*/
				}
			}
			this.y = -Game.SCREEN_HEIGHT-3*TILE_HEIGHT/4; 
			this.x = 0;
		}

	}
	
}
