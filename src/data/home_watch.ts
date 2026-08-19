export type HomeWatchClip = {
	id: string;
	title: string;
	summary: string;
	src: string;
	poster: string;
	label: string;
};

export const homeWatchClips: HomeWatchClip[] = [
	{
		id: 'project-tabs',
		title: 'Project tabs',
		summary: 'Each tab is a project. The Anima tab slides along the bar.',
		src: '/media/watch/project-tabs.mp4',
		poster: '/media/watch/project-tabs-poster.png',
		label: 'Nova project tabs sliding along the bar',
	},
	{
		id: 'stacked-panes',
		title: 'Stacked panes',
		summary: 'Yazi stays on the side. Shells stack, run, then one pane moves through the stack.',
		src: '/media/watch/stacked-panes.mp4',
		poster: '/media/watch/stacked-panes-poster.png',
		label: 'Nova stacked Nushell panes running commands',
	},
	{
		id: 'ratconfig-popup',
		title: 'Live config',
		summary: 'Ratconfig opens over the workspace and rounds the pane corners live.',
		src: '/media/watch/ratconfig-popup.mp4',
		poster: '/media/watch/ratconfig-popup-poster.png',
		label: 'Ratconfig popup changing Zellij pane corners live',
	},
];
