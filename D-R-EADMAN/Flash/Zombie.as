package  {
	
	public class Zombie extends GroundEnemy{

		public function Zombie(x:int,y:int,world:World,level:GameLevel) {
			super(x,y,world,level);
			speed = 0.8;
			life = game.options.difficulty +3;
		}

	}
	
}
