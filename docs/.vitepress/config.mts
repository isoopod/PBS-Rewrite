import { defineConfig } from 'vitepress'
import versions from './api-versions.json' assert { type: 'json' }

// Autoload api sidebar configs
const sidebar: Record<string, any> = {}
const versionLinks: { text: string; link: string }[] = []

for (const version of versions) {
	const mod = await import(`../api/${version}/sidebar.ts`)
	const items = mod.default
	sidebar[`/api/${version}/`] = items

	// Find the first valid link in the sidebar (depth-first)
	const findFirstLink = (entries: any[]): string | undefined => {
		for (const entry of entries) {
			if (entry.link) return entry.link
			if (entry.items) {
				const found = findFirstLink(entry.items)
				if (found) return found
			}
		}
		return undefined
	}

	const firstLink = findFirstLink(items)
	if (firstLink) {
		versionLinks.push({ text: version.toUpperCase(), link: firstLink })
	}
}

// https://vitepress.dev/reference/site-config
export default defineConfig({
	title: "PBS Rewrite",
	description: "Documentation for the PBS Rewrite tools and ecosystem.",
	themeConfig: {
		// https://vitepress.dev/reference/default-theme-config
		search: {
			provider: 'local'
		},

		nav: [
			{ text: 'Home', link: '/' },
			{ text: 'API', items: versionLinks }
		],

		sidebar: sidebar,

		socialLinks: [
			{ icon: 'github', link: 'https://github.com/isoopod/PBS-Rewrite' },
			{ icon: 'discord', link: "https://discord.gg/bJJ8cfCc6b" }
		]
	}
})
