// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	site: 'https://yazelix.com',
	devToolbar: {
		enabled: false,
	},
	integrations: [
		starlight({
			title: 'Yazelix',
			description: 'A reproducible terminal workspace built around Zellij, Yazi, Helix, and a fixed runtime toolset.',
			logo: {
				src: './public/favicon.png',
				alt: 'Yazelix logo',
			},
			favicon: '/favicon.png',
			components: {
				ThemeProvider: './src/components/starlight/ThemeProvider.astro',
			},
			customCss: ['./src/styles/starlight.css'],
			social: [
				{ icon: 'github', label: 'GitHub', href: 'https://github.com/luccahuguet/yazelix' },
			],
			sidebar: [
				{
					label: 'Start',
					items: [
						{ label: 'Start with Yazelix', slug: 'start' },
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
						{ label: 'Customization surfaces', slug: 'docs/customization-surfaces' },
						{ label: 'Troubleshooting checklist', slug: 'docs/troubleshooting-checklist' },
					],
				},
			],
		}),
	],
});
