local mason = vim.fn.stdpath("data") .. "/mason"
local jdtls = mason .. "/packages/jdtls/plugins"
local root = vim.fs.root(0, { ".git", "mvnw", "gradlew" })

return {
	cmd = {

		"java", -- or '/path/to/java21_or_newer/bin/java'

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-jar",
		jdtls .. "/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar",

		"-configuration",
		mason .. "/packages/jdtls/config_linux",

		"-data",
		root,
	},
	root_markers = { ".git", "mvnw", "gradlew" },
	filetypes = { "java" },
}
