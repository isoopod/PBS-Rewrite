module.exports = {
	extends: [
		"eslint:recommended",
		"plugin:@typescript-eslint/strict",
		"plugin:@typescript-eslint/stylistic",
		"plugin:@prettier/recommended"
	],
	root: true,
	parser: "@typescript-eslint",
	parserOptions: {
		project: "./tsconfig.json",
		tsconfigRootDir: __dirname
	},
	rules: {
		indent: ["off"], // let Prettier handle indentation
		"prettier/prettier": ["error", { useTabs: true, tabWidth: 4 }]
	},
	plugins: ["@typescript-eslint", "prettier"]
};