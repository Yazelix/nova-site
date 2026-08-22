export type FeatureMediaFocus = 'full';

export type FeatureMediaItem = {
	id: string;
	title: string;
	summary: string;
	focus: FeatureMediaFocus;
	docsHref: string;
};

export const novaWorkspaceAsset = '/images/nova_workspace.png';

export const workspaceStill: FeatureMediaItem = {
	id: 'workspace-overview',
	title: 'Yazelix Nova workspace',
	summary: 'Yazi, the managed editor, shell, tabs, and runtime status share one keyboard-driven workspace',
	focus: 'full',
	docsHref: '/docs/runtime-model/',
};
