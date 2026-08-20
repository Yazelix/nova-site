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

export const paneClips = homeWatchClips.filter((clip) => clip.id !== 'ratconfig-popup');

const ratconfig = homeWatchClips.find((clip) => clip.id === 'ratconfig-popup');
if (!ratconfig) throw new Error('ratconfig-popup is missing from homeWatchClips');

export const popupClips: HomeWatchClip[] = [
	{
		id: 'yazi-popup',
		title: 'Yazi popup',
		summary: 'The full file manager opens over the workspace, then hides.',
		src: '/media/watch/yazi-popup.mp4',
		poster: '/media/watch/yazi-popup-poster.png',
		label: 'Nova Yazi popup opening over the workspace',
	},
	{
		id: 'git-popup',
		title: 'Git popup',
		summary: 'lazygit opens over the workspace, then hides.',
		src: '/media/watch/git-popup.mp4',
		poster: '/media/watch/git-popup-poster.png',
		label: 'Nova git popup opening lazygit over the workspace',
	},
	{
		id: 'agent-popup',
		title: 'Agent popup',
		summary: 'Codex opens on the Nova tab and the question is typed in place.',
		src: '/media/watch/agent-popup.mp4',
		poster: '/media/watch/agent-popup-poster.png',
		label: 'Nova agent popup asking Codex about Yazelix Nova',
	},
	ratconfig,
];
