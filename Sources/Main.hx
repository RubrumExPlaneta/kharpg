package;

import kha.System;

class Main {
	public static function main() {
		System.init({title: "Project", width: 640, height: 480}, function () {
			new Project();
		});
	}
}
