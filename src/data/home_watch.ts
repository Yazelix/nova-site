export type HomeWatchClip = {
	id: string;
	title: string;
	summary: string;
	src: string;
	poster: string;
	label: string;
};

export const paneClips: HomeWatchClip[] = [
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
		title: 'Panes and sidebar',
		summary: 'The sidebar hides and comes back. Shells stack, then one pane moves through the stack.',
		src: '/media/watch/stacked-panes.mp4',
		poster: '/media/watch/stacked-panes-poster.png',
		label: 'Nova sidebar toggling and stacked shell panes',
	},
];

export const popupClips: HomeWatchClip[] = [
	{
		id: 'yazi-popup',
		title: 'Yazi popup',
		summary: 'Helix reveals the current file in Yazi. Another file opens back in the editor.',
		src: '/media/watch/yazi-popup.mp4',
		poster: '/media/watch/yazi-popup-poster.png',
		label: 'Nova Yazi popup revealing a Helix file then opening another',
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
	{
		id: 'ratconfig-popup',
		title: 'Live config',
		summary: 'Ratconfig restyles the session to Dracula, then back to ansi.',
		src: '/media/watch/ratconfig-popup.mp4',
		poster: '/media/watch/ratconfig-popup-poster.png',
		label: 'Ratconfig popup switching the Zellij dark theme from ansi to Dracula',
	},
	{
		id: 'anima-popup',
		title: 'Anima',
		summary: 'yzx anima opens Mandelbrot, then boids_predator.',
		src: '/media/watch/anima-popup.mp4',
		poster: '/media/watch/anima-popup-poster.png',
		label: 'Nova Anima switching from Mandelbrot to boids_predator',
	},
];

export const homeWatchClips = popupClips.filter(
	(clip) => clip.id === 'yazi-popup' || clip.id === 'git-popup' || clip.id === 'agent-popup',
);

const stackedPanes = paneClips.find((clip) => clip.id === 'stacked-panes');
const liveConfig = popupClips.find((clip) => clip.id === 'ratconfig-popup');
const animaPopup = popupClips.find((clip) => clip.id === 'anima-popup');
if (!stackedPanes || !liveConfig || !animaPopup) {
	throw new Error('home live clips are missing');
}

export const homeLiveClips = [stackedPanes, liveConfig, animaPopup];
