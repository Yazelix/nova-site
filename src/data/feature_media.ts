export type FeatureMediaFocus = 'full' | 'files' | 'status' | 'keys';

export type FeatureMediaItem = {
	id: string;
	title: string;
	summary: string;
	focus: FeatureMediaFocus;
	docsHref: string;
};

export type FeatureMediaGroup = {
	id: string;
	title: string;
	summary: string;
	items: FeatureMediaItem[];
};

export const novaWorkspaceAsset = '/images/nova_workspace.png';

export const featureMediaGroups: FeatureMediaGroup[] = [
	{
		id: 'nova_workspace',
		title: 'One workspace, four useful views',
		summary: 'A maintained Nova workspace image, focused on the parts that explain the product at a glance.',
		items: [
			{
				id: 'workspace-overview',
				title: 'Yazelix Nova workspace',
				summary: 'Yazi, the managed editor, shell, tabs, and runtime status share one keyboard-driven workspace.',
				focus: 'full',
				docsHref: '/docs/runtime-model/',
			},
			{
				id: 'file-first-navigation',
				title: 'Files beside the editor',
				summary: 'The Yazi sidebar keeps project navigation visible without taking over the editing surface.',
				focus: 'files',
				docsHref: '/keybindings/',
			},
			{
				id: 'runtime-status',
				title: 'Runtime status at a glance',
				summary: 'The top bar exposes active tools, resource usage, and the Nova channel identity in the workspace.',
				focus: 'status',
				docsHref: '/docs/runtime-model/',
			},
			{
				id: 'keyboard-map',
				title: 'Keyboard map in view',
				summary: 'The bottom bar keeps the pane, tab, resize, focus, and session controls discoverable while you work.',
				focus: 'keys',
				docsHref: '/keybindings/',
			},
		],
	},
];

