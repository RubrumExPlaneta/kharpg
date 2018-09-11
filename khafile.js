let project = new Project('New Project');
project.addAssets('Assets/**', {
	nameBaseDir: 'Assets',
	destination: '{dir}/{name}',
	name: '{dir}/{name}'
});
project.addSources('Sources');

project.windowOptions.width = 640;
project.windowOptions.height = 480;

resolve(project);
