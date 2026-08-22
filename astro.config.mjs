// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	site: 'https://nova.yazelix.com',
	redirects: {
		'/start': '/docs/#start',
	},
	devToolbar: {
		enabled: false,
	},
	integrations: [
		starlight({
			title: 'Yazelix Nova',
			description: 'A Nix-packaged terminal workspace with Mars, Yazelix Zellij, Yazi, managed Helix, and yzx.',
			logo: {
				src: './public/favicon.png',
				alt: 'Yazelix logo',
			},
			favicon: '/favicon.png',
			components: {
				ThemeProvider: './src/components/starlight/ThemeProvider.astro',
				ThemeSelect: './src/components/starlight/ThemeProvider.astro',
			},
			customCss: ['./src/styles/starlight.css'],
			social: [
				{ icon: 'github', label: 'GitHub', href: 'https://github.com/Yazelix/nova' },
			],
			sidebar: [
				{
					label: 'Start',
					items: [
						{ label: 'Start with Yazelix', link: '/docs/#start' },
						{ label: 'Configure the workspace', slug: 'configure' },
						{ label: 'Update safely', slug: 'update' },
						{ label: 'Recover a broken launch', slug: 'recover' },
						{ label: 'Keybindings', slug: 'keybindings' },
					],
				},
				{
					label: 'Reference',
					items: [
						{ label: 'All docs', link: '/docs/' },
						{ label: 'Runtime model', slug: 'docs/runtime-model' },
						{ label: 'Nova and Zellij', slug: 'docs/nova-and-zellij' },
						{ label: 'Customization surfaces', slug: 'docs/customization-surfaces' },
						{ label: 'Troubleshooting checklist', slug: 'docs/troubleshooting-checklist' },
					],
				},
			],
		}),
	],
});
