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
];

const customRoutes = [
	{ path: '/', type: 'website' },
	{ path: '/features/', type: 'website' },
	{ path: '/docs/', type: 'website' },
	{ path: '/blog/', type: 'website' },
];

const removedBlogRoutes = [
	'/blog/docs-that-respect-runtime-boundaries/',
	'/blog/reproducible-terminal-workspace/',
	'/blog/the-shape-of-a-reproducible-workspace/',
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

test('custom pages expose Nova metadata and a keyboard skip link', async ({ page }) => {
	for (const route of customRoutes) {
		await page.goto(route.path);
		const title = await page.title();
		const description = (await page.locator('meta[name="description"]').getAttribute('content')) ?? '';
		const canonical = `https://nova.yazelix.com${route.path}`;
		const image = 'https://nova.yazelix.com/images/nova_workspace.png';

		expect.soft(description, `missing description: ${route.path}`).not.toBe('');
		await expect(page.locator('meta[name="description"]')).toHaveCount(1);
		await expect(page.locator('link[rel="canonical"]')).toHaveCount(1);
		await expect(page.locator('link[rel="canonical"]')).toHaveAttribute('href', canonical);
		await expect(page.locator('meta[property="og:type"]')).toHaveAttribute('content', route.type);
		await expect(page.locator('meta[property="og:title"]')).toHaveAttribute('content', title);
		await expect(page.locator('meta[property="og:description"]')).toHaveAttribute('content', description);
		await expect(page.locator('meta[property="og:url"]')).toHaveAttribute('content', canonical);
		await expect(page.locator('meta[property="og:image"]')).toHaveAttribute('content', image);
		await expect(page.locator('meta[property="og:image:alt"]')).toHaveAttribute('content', /Yazelix Nova workspace/);
		await expect(page.locator('meta[name="twitter:card"]')).toHaveAttribute('content', 'summary_large_image');
		await expect(page.locator('meta[name="twitter:title"]')).toHaveAttribute('content', title);
		await expect(page.locator('meta[name="twitter:description"]')).toHaveAttribute('content', description);
		await expect(page.locator('meta[name="twitter:image"]')).toHaveAttribute('content', image);
		await expect(page.locator('meta[name="twitter:image:alt"]')).toHaveAttribute('content', /Yazelix Nova workspace/);

		const skipLink = page.getByRole('link', { name: 'Skip to content' });
		await page.keyboard.press('Tab');
		await expect(skipLink).toBeFocused();
		await expect(skipLink).toBeVisible();
		await page.keyboard.press('Enter');
		await expect(page.locator('#main-content')).toBeFocused();
	}
});

test('home page exposes product and docs actions', async ({ page }) => {
	await page.goto('/');
	await expect(page.getByRole('heading', { name: 'Yazelix Nova' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Home' })).toHaveAttribute('aria-current', 'page');
	await expect(page.getByRole('link', { name: 'Start with Yazelix' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'See features' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Read docs' })).toBeVisible();
	await expect(page.locator('.feature-preview-grid .feature-media').first()).toBeVisible();
	await expect(page.getByRole('link', { name: 'GitHub (opens in a new tab)' }).first()).toHaveAttribute(
		'target',
		'_blank',
	);
});

test('features page exposes the lean Nova product tour', async ({ page }) => {
	await page.goto('/features/');
	await expect(page.getByRole('heading', { name: 'Yazelix Nova features' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Features' })).toHaveAttribute('aria-current', 'page');
	await expect(page.getByRole('heading', { name: 'One workspace, four useful views' })).toBeVisible();
	await expect(page.locator('.feature-page video')).toHaveCount(0);
	await expect(page.locator('.feature-page img[src$=".gif"]')).toHaveCount(0);
	await expect(page.getByText('Yazelix Nova workspace', { exact: true })).toBeVisible();
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
	await expect(page.locator('[data-docs-rail-link="start-install"]')).toHaveCount(1);
	await expect(page.locator('[data-docs-rail-link="configure-home-manager"]')).toHaveCount(1);
});

test('public Nova contract and internal links stay valid', async ({ page }) => {
	await page.goto('/');
	const homeCopy = await page.locator('body').innerText();
	await page.goto('/docs/');
	const docsCopy = await page.locator('body').innerText();
	const publicCopy = `${homeCopy}\n${docsCopy}`;

	for (const required of [
		'nix profile add --refresh github:luccahuguet/yazelix/stable',
		'nix run github:luccahuguet/yazelix/stable -- launch',
		'nix run github:luccahuguet/yazelix/stable#yazelix-no-mars -- enter',
		'~/.config/yazelix/config.toml',
	]) {
		expect.soft(publicCopy.includes(required), `missing public Nova contract: ${required}`).toBe(true);
	}
	const classicOnly =
		/settings\.jsonc|yazelix_cursors|yzx (?:update|restart|desktop|reset|keys)|doctor --|version-short|right agent sidebar/i;
	expect.soft(classicOnly.test(publicCopy), 'Classic-only public contract returned').toBe(false);

	const externalLinks = await page.locator('a[href^="https://"]').evaluateAll((links) =>
		links.map((link) => (link as HTMLAnchorElement).href),
	);
	for (const required of [
		'https://github.com/luccahuguet/yazelix',
		'https://github.com/luccahuguet/yazelix/blob/stable/docs/installation.md',
		'https://github.com/luccahuguet/yazelix/blob/stable/docs/installation.md#updates',
		'https://github.com/luccahuguet/yazelix/blob/stable/docs/configuration.md',
		'https://github.com/luccahuguet/yazelix/blob/stable/ARCHITECTURE.md',
	]) {
		expect.soft(externalLinks.includes(required), `missing canonical link: ${required}`).toBe(true);
	}

	const origin = new URL(page.url()).origin;
	const pending = ['/'];
	const visited = new Set<string>();
	const anchorTargets = new Map<string, Set<string>>();
	while (pending.length > 0) {
		const route = pending.shift()!;
		if (visited.has(route)) continue;
		visited.add(route);

		const response = await page.goto(route);
		expect.soft(response?.ok(), `broken internal link: ${route}`).toBe(true);
		if (!response?.ok()) continue;

		const hrefs = await page.locator('a[href]').evaluateAll((links) =>
			links.map((link) => (link as HTMLAnchorElement).href),
		);
		for (const href of hrefs) {
			const target = new URL(href);
			if (target.origin !== origin) continue;
			const targetRoute = `${target.pathname}${target.search}`;
			if (target.hash) {
				const ids = anchorTargets.get(targetRoute) ?? new Set<string>();
				ids.add(decodeURIComponent(target.hash.slice(1)));
				anchorTargets.set(targetRoute, ids);
			}
			if (!visited.has(targetRoute) && !pending.includes(targetRoute)) pending.push(targetRoute);
		}
	}

	for (const route of routes) {
		expect.soft(visited.has(route), `representative route is not linked: ${route}`).toBe(true);
	}
	for (const [route, expectedIds] of anchorTargets) {
		await page.goto(route);
		const actualIds = await page.locator('[id]').evaluateAll((elements) => elements.map((element) => element.id));
		for (const id of expectedIds) {
			expect.soft(actualIds.includes(id), `broken internal anchor: ${route}#${id}`).toBe(true);
		}
	}
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

test('blog index exposes the approved empty state', async ({ page }) => {
	await page.goto('/blog/');
	await expect(page.getByRole('link', { name: 'Blog' })).toHaveAttribute('aria-current', 'page');
	await expect(page.getByRole('heading', { name: 'No articles yet' })).toBeVisible();
	await expect(page.getByText('Yazelix Nova v1 will be the first subject.')).toBeVisible();
	await expect(page.getByRole('link', { name: 'Read the Nova docs' })).toBeVisible();
	await expect(page.locator('main article')).toHaveCount(0);
	await expect(page.locator('main a[href^="/blog/"]')).toHaveCount(0);

	for (const route of removedBlogRoutes) {
		const response = await page.goto(route);
		expect(response?.status(), `removed Blog route still resolves: ${route}`).toBe(404);
	}
});
