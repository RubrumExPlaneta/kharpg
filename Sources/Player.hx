package ;

import kha.input.KeyCode;

class Player {
	var x:Float; var y:Float;
	var xMove:Float = 0; var yMove:Float = 0;
	var speed:Float = 2;
	var movementKeys:Array<KeyCode> = new Array<KeyCode>();

	public function new(x:Float, y:Float) {
		this.x = x;
		this.y = y;
	}

	public function keyDown(key:KeyCode) {
		if (movementKeys.indexOf(key) == -1 && (key == KeyCode.Up || key == KeyCode.Down || key == KeyCode.Left || key == KeyCode.Right)) {
			movementKeys.insert(0, key);
		}
	}

	public function keyUp(key:KeyCode) {
		movementKeys.remove(key);
	}

	public function update() {
		if (x%Project.GRID_SIZE == 0 && y%Project.GRID_SIZE == 0) {
			if (movementKeys.length > 0) {
				switch (movementKeys[0]) {
					case KeyCode.Up: yMove = -speed; xMove = 0;
					case KeyCode.Down: yMove = speed; xMove = 0;
					case KeyCode.Right: yMove = 0; xMove = speed;
					case KeyCode.Left: yMove = 0; xMove = -speed;
					default:
				}

				if (x >= Project.TILE_SIZE && y >= Project.TILE_SIZE && x <= Project.PROJECT.map.width*Project.TILE_SIZE - Project.TILE_SIZE && y <= Project.PROJECT.map.height*Project.TILE_SIZE - Project.TILE_SIZE) {
					if (y%Project.TILE_SIZE == 0) {
						var tempX = x/Project.TILE_SIZE;
						var tempY = y/Project.TILE_SIZE;
						if (Project.PROJECT.map.solid[Math.floor(tempX)][Math.round(tempY + (yMove/speed))] || Project.PROJECT.map.solid[Math.ceil(tempX)][Math.round(tempY + (yMove/speed))]) {
							xMove = 0;
							yMove = 0;
						}
					}
					if (x%Project.TILE_SIZE == 0) {
						var tempX = x/Project.TILE_SIZE;
						var tempY = y/Project.TILE_SIZE;
						if (Project.PROJECT.map.solid[Math.round(tempX + (xMove/speed))][Math.floor(tempY)] || Project.PROJECT.map.solid[Math.round(tempX + (xMove/speed))][Math.ceil(tempY)]) {
							xMove = 0;
							yMove = 0;
						}
					}
				}
			} else {
				yMove = 0;
				xMove = 0;
			}
		}
		x += xMove;
		y += yMove;
	}

	public function render(g:kha.graphics2.Graphics): Void {
		g.color = kha.Color.White;
		g.fillRect(x, y, 32, 32);
	}
}