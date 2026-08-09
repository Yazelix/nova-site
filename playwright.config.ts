import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
	webServer: {
		command: 'bun run dev -- --host 127.0.0.1 --port 4321',
		env: { ASTRO_DEV_BACKGROUND: '1' },
		url: 'http://127.0.0.1:4321',
		reuseExistingServer: !process.env.CI,
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
		{
			name: 'mobile',
			use: { ...devices['Pixel 7'] },
		},
	],
});
