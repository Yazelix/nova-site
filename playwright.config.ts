import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
	webServer: {
		command: 'bun run build && bun run preview -- --host 127.0.0.1 --port 4321',
		env: { ASTRO_PREVIEW_BACKGROUND: '1' },
		url: 'http://127.0.0.1:4321',
		reuseExistingServer: false,
		timeout: 120_000,
	},
	testDir: './tests',
	use: {
		baseURL: 'http://127.0.0.1:4321',
		trace: 'on-first-retry',
	},
	projects: [
		{
			name: 'chromium',
			use: { ...devices['Desktop Chrome'] },
		},
	],
});
