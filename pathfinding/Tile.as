package pathfinding {
	
	/**
	 * Generic tile class for Astar3D
	 * @author MSGHero
	 */
	
	public class Tile {
		
		public var row:int;
		public var col:int;
		public var alt:int;
		public var g:Number; //manhattan distance
		public var h:Number; //heuristic
		public var c:Number; //cost
		public var cameFrom:Tile; //previous tile
		
		/**
		 * Creates a new tile
		 * @param	row The tile's row
		 * @param	col The tile's column
		 * @param	alt The tile's altitude
		 */
		public function Tile(row:int = 0, col:int = 0, alt:int = 0) {
			this.row = row;
			this.col = col;
			this.alt = alt;
		}
		
		public function toString():String {
			return "Tile: row=" + row + " col=" + col + " alt=" + alt;
		}
	}
}