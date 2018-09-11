package ;

import kha.Assets;

class TileLayer {
	var width:Int; var height:Int;

	var tiles:Array<Int>;

	public function new(?width=20, ?height=15, tileset:TileSet, ?fill:Array<Int>) {
		this.width = width;
		this.height = height;

		if (fill != null) {
			tiles = fill;
		} else {
			tiles = [for (i in 0...width*height) -1];
		}
	}

	public function render(g:kha.graphics2.Graphics, tileset:TileSet) {
		for (i in 0...width) {
			for (j in 0...height) {
				tileset.render(g, tiles[j*width+i], i, j);
			}
		}
	}



}