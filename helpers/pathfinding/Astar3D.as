package pathfinding {
	
	/**
	 * ...
	 * @author Nadim Jahangir
	 * edited by MSGHero
	 */
	
	public class Astar3D {
		
		/**
		 * Finds the shortest manhattan path between two tiles using A*. For use with normalized positions (int(obj.x / TILE_SIZE), etc).
		 * @param	start The starting tile
		 * @param	end The ending tile
		 * @param	numRows Boundary condition: number of rows of the entire grid
		 * @param	numCols Boundary condition: number of columns of the entire grid
		 * @param	cost A vec.vec.uint of the cost heuristic, aka the obstacle array
		 * @param   maxHeight Boundary condition: maximum height difference of a tile that will not be ignored (maxHeight + 1 will be ignored)
		 * @param   maxManh Boundary condition: the maximum length the path is allowed to be (maximum 2D displacement from start to finish)
		 * @return An array of tiles from the starting tile to the ending tile including the starting tile, or null if no path is found
		 */
		
		public static function aStar(start:Tile, end:Tile, numRows:int, numCols:int, cost:Vector.<Vector.<uint>>, maxHeight:int = 99, maxManh:int = int.MAX_VALUE):Array {
			
			var i:int;
			var j:int;
			var k:int;
			
			var openedList:Array = new Array();
			var closedList:Array = new Array();
			
			start.g = 0;	// path cost
			start.h = manhattan(start, end);	// heuristic
			
			openedList.push(start);
			var pathFound:Boolean = false;
			
			while (openedList.length > 0) {
				
				// picks the tile with minimum cost from openedList
				var minI:int;
				var minCost:Number = Number.MAX_VALUE;
				for (i = 0; i < openedList.length; i++) {
					
					var n:Tile = openedList[i];
					
					var curCost:Number = n.g + n.h;
					if (minCost > curCost) {
						minI = i;
						minCost = curCost;
					}
				}
				
				// moves the tile with minimum cost from openedList to closedList
				var curTile:Tile = openedList[minI];
				openedList.splice(minI, 1);
				closedList.push(curTile);
				
				// if finished
				if (sameTiles(end, curTile)) {
					end.cameFrom = curTile.cameFrom;
					pathFound = true;
					break;
				}
				
				// checks the neighbourhood
				for (i = -1; i < 2; i++) {
					
					for (j = -1; j < 2; j++) {
						
						if (i ==  j || i == -j) continue;
						
						var row:int = curTile.row + i;
						var col:int = curTile.col + j;
						var alt:int = curTile.alt;
						
						// off boundary conditions
						if (row < 0 || col < 0 || row >= numRows || col >= numCols) continue;
						
						alt = cost[col][row];
						if (Math.abs(alt - curTile.alt) > maxHeight) continue;
						
						var tile2check:Tile = new Tile();
						
						tile2check.row = row;
						tile2check.col = col;
						tile2check.alt = alt;
						
						// if already checked
						if (containsTile(openedList, tile2check) || containsTile(closedList, tile2check) || manhattan2D(start, tile2check) > maxManh) continue;
						
						// calculates cost
						tile2check.g = curTile.g + manhattan(tile2check, curTile);
						tile2check.h = manhattan(tile2check, end);
						
						// keeps track of path
						tile2check.cameFrom = curTile;
						openedList.push(tile2check);
					}
				}
			}
			
			if (!pathFound) return null;
			
			// tile array for shortest  path
			var path:Array = new Array();

			// construct path
			path.push(end);
			
			var pTile:Tile = end;
			
			while (!sameTiles(start, pTile)) {
				pTile = pTile.cameFrom;
				path.push(pTile);
			}
			
			if (path.length > maxManh) return null;
			return path.reverse();
		}
		
		// city block distance between tile1 and tile2 with altitude
		private static function manhattan(tile1:Tile, tile2:Tile):Number {
			return Math.abs(tile1.row - tile2.row) + Math.abs(tile1.col - tile2.col) + Math.abs(tile1.alt - tile2.alt);
		}
		
		// city block distance between tile1 and tile2 without altitude
		private static function manhattan2D(tile1:Tile, tile2:Tile):Number {
			return Math.abs(tile1.row - tile2.row) + Math.abs(tile1.col - tile2.col);
		}
		
		// checks if tile1 and tile2 belongs to same grid-cell
		private static function sameTiles(tile1:Tile, tile2:Tile):Boolean {
			return ((tile1.row == tile2.row) && (tile1.col == tile2.col));
		}
		
		// checks if the given tile array contains the given tile
		private static function containsTile(tileArray:Array, tile:Tile):Boolean {
			
			for (var i:int = 0; i < tileArray.length; i++) {
				if (sameTiles(tileArray[i], tile)) return true;
			}
			
			return false;
		}
	}
}