package ;

import kha.Assets;

class TileMap {
	var layers:Array<TileLayer> = new Array<TileLayer>();
	var tileset:TileSet;

	public var width:Int; public var height:Int;

	public var solid:Array<Array<Bool>>;

	public function new(width:Int, height:Int, tileset:TileSet) {
		this.tileset = tileset;
		this.width = width;
		this.height = height;
		solid = [for (x in 0...width) [for (y in 0...height) false]];
	}
	
	public function addLayer(layer:TileLayer) {
		layers.push(layer);
	}

	public function render(g:kha.graphics2.Graphics) {
		for (layer in layers) {
			layer.render(g, tileset);
		}

		for (x in 0...width) {
			for (y in 0...height) {
				if (solid[x][y]) {
					g.color = kha.Color.fromString("#3fff0000");
					g.fillRect(x*Project.TILE_SIZE, y*Project.TILE_SIZE, Project.TILE_SIZE, Project.TILE_SIZE);
				}
			}
		}
	}

	public static function loadTMX(xml:String) {
		var map:haxe.xml.Fast = new haxe.xml.Fast(Xml.parse(xml));
		var tileset:TileSet = new TileSet(Reflect.field(Assets.images, "Maps_" + map.node.map.node.tileset.node.image.att.source.split(".")[0]));
		var tilemap:TileMap = new TileMap(Std.parseInt(map.node.map.att.width), Std.parseInt(map.node.map.att.height), tileset);
		var input:Array<String>;
		var output:Array<Int>;
		for (layer in map.node.map.nodes.layer) {
			input = layer.node.data.innerData.split(",");
			
			if (layer.att.name == "collisions") {
				for (x in 0...Std.parseInt(layer.att.width)) {
					for (y in 0...Std.parseInt(layer.att.height)) {
						if (Std.parseInt(input[y*Std.parseInt(layer.att.width)+x]) != 0) {
							tilemap.solid[x][y] = true;
						}
					}
				}
				continue;
			}

			output = new Array<Int>();
			for (data in input) {
				output.push(Std.parseInt(data) - 1);
			}
			tilemap.addLayer(new TileLayer(Std.parseInt(layer.att.width), Std.parseInt(layer.att.height), tileset, output));
		}

		return tilemap;
	}
}