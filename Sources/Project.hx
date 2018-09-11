package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.input.*;
import kha.Assets;
import kha.LoaderImpl;
import kha.Font;

class Project {
	/// CONSTANTS
	public static var PROJECT:Project; // Reference to Project instance
	
	public static inline var GRID_SIZE = 16; // Player/NPC movement grid size, HAS TO BE A FACTOR OF TILE_SIZE!
	public static inline var TILE_SIZE = 32; // Map tile size

	public var player:Player;
	public var map:TileMap;

	var font:Font;

	public function new() {
		Assets.loadEverything(init);

		Keyboard.get(0).notify(keyDown, keyUp);

		Project.PROJECT = this;
	}

	function init() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);

		player = new Player(64, 64);
		//map = new TileMap(new TileSet(Assets.images.Tilesets_grasslands));
		map = TileMap.loadTMX(Assets.blobs.Maps_test_tmx.toString());
		font = Assets.fonts.unifont;
	}

	function keyDown(key:KeyCode) {
		player.keyDown(key);
	}

	function keyUp(key:KeyCode) {
		player.keyUp(key);
	}

	function update(): Void {
		player.update();
	}

	function render(framebuffer: Framebuffer): Void {
		var g:kha.graphics2.Graphics = framebuffer.g2;
		g.begin();
		g.font = font;
		g.fontSize = 12;
		map.render(g);
		player.render(g);
		g.end();
	}
}
