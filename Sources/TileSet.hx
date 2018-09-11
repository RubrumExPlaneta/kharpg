package ;

import kha.Image;

class TileSet {
	var image:Image; // The tileset image resource.

	var tilesetWidth:Int; // The tileset's width in tiles. Automatically calculated from the width of the image in the constructor.
	var tileWidth:Int; var tileHeight:Int;

	public function new(image:Image, ?tileWidth=Project.TILE_SIZE, ?tileHeight=Project.TILE_SIZE) {
		this.image = image;
		this.tileWidth = tileWidth;
		this.tileHeight = tileHeight;
		tilesetWidth = Math.round(image.realWidth/tileWidth); // If the image's width is not a factor of the tileWidth, it might result in unexpected results.

	}

	public function render(g:kha.graphics2.Graphics, tile:Int, x:Int, y:Int) {
		// x and y parameters are not in pixels but rather tiles.
		if (tile != -1) {
			g.drawSubImage(image, x*tileWidth, y*tileHeight, tile%tilesetWidth * tileWidth, Math.floor(tile/tilesetWidth)*tileHeight, tileWidth, tileHeight);
		}
	}
}