import { expect, test } from '@playwright/test';

const routes = [
	'/',
	'/start/',
	'/configure/',
	'/update/',
	'/recover/',
	'/keybindings/',
	'/docs/',
	'/features/',
	'/blog/',
	'/blog/docs-that-respect-runtime-boundaries/',
];

for (const route of routes) {
	test(`${route} renders without horizontal overflow`, async ({ page }) => {
		await page.goto(route);
		await expect(page.locator('body')).toBeVisible();
		await expect(page).toHaveTitle(/Yazelix/);
		const overflow = await page.evaluate(() => document.documentElement.scrollWidth > window.innerWidth + 1);
		expect(overflow).toBe(false);
	});
}

test('home page exposes product and docs actions', async ({ page }) => {
	await page.goto('/');
	await expect(page.getByRole('heading', { name: 'Yazelix Nova' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Home' })).toHaveAttribute('aria-current', 'page');
	await expect(page.getByRole('link', { name: 'Start with Yazelix' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'See features' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Read docs' })).toBeVisible();
	await expect(page.locator('.feature-preview-grid .feature-media')).toHaveCount(3);
	await expect(page.getByRole('link', { name: 'GitHub (opens in a new tab)' }).first()).toHaveAttribute(
		'target',
		'_blank',
	);
});

test('features page exposes the lean Nova product tour', async ({ page }) => {
	await page.goto('/features/');
	await expect(page.getByRole('heading', { name: 'Yazelix Nova features' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Features' })).toHaveAttribute('aria-current', 'page');
	await expect(page.getByText('4 visual demos')).toBeVisible();
	await expect(page.getByRole('heading', { name: 'One workspace, four useful views' })).toBeVisible();
	await expect(page.locator('.feature-page .feature-media img')).toHaveCount(4);
	await expect(page.locator('.feature-page video')).toHaveCount(0);
	await expect(page.locator('.feature-page img[src$=".gif"]')).toHaveCount(0);
	await expect(page.getByText('Files beside the editor')).toBeVisible();
	await expect(page.getByText('Runtime status at a glance')).toBeVisible();
	await expect(page.getByText('Keyboard map in view')).toBeVisible();
	const mediaSources = await page.locator('.feature-page .feature-media img').evaluateAll((images) =>
		images.map((image) => image.getAttribute('src')),
	);
	expect(new Set(mediaSources)).toEqual(new Set(['/images/nova_workspace.png']));
	await expect(page.getByRole('link', { name: 'Docs' }).first()).toBeVisible();
});

test('docs page exposes the docs index stream', async ({ page }) => {
	await page.goto('/docs/');
	await expect(page.getByRole('heading', { name: 'Yazelix Nova docs' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Docs' })).toHaveAttribute('aria-current', 'page');
	await expect(page.getByRole('heading', { name: 'Start with Yazelix Nova' })).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Configure Yazelix Nova' })).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Nova Troubleshooting Checklist' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Standalone page' })).toHaveCount(8);
	await expect(page.locator('[data-docs-rail-link="start-install"]')).toHaveCount(1);
	await expect(page.locator('[data-docs-rail-link="configure-home-manager"]')).toHaveCount(1);
});

test('docs sidebar highlights the current section', async ({ page }) => {
	await page.goto('/docs/');
	await page.evaluate(() => {
		document.documentElement.style.scrollBehavior = 'auto';
	});
	await page.locator('#recover').evaluate((element) => element.scrollIntoView({ block: 'start' }));
	await expect(page.locator('[data-docs-rail-link="recover"]')).toHaveClass(/is-active/);
	const deepTargetTop = await page
		.locator('#docs-troubleshooting-checklist-6-report-precise-failures')
		.evaluate((element) => element.getBoundingClientRect().top + window.scrollY);
	await page.evaluate((top) => window.scrollTo(0, top), deepTargetTop);
	await expect(
		page.locator('[data-docs-rail-link="docs-troubleshooting-checklist-6-report-precise-failures"]'),
	).toHaveClass(/is-active/);
	await expect(page.locator('[data-docs-rail-link="docs-troubleshooting-checklist"]')).toHaveClass(/is-parent-active/);
});

test('blog index exposes multiple dated posts', async ({ page }) => {
	await page.goto('/blog/');
	await expect(page.getByRole('link', { name: 'Blog' })).toHaveAttribute('aria-current', 'page');
	await expect(page.getByRole('link', { name: 'Read post' })).toHaveCount(3);
	await expect(page.getByRole('heading', { name: 'Docs that respect runtime boundaries' })).toBeVisible();
	await expect(page.getByRole('heading', { name: 'A reproducible terminal workspace' })).toBeVisible();
});
