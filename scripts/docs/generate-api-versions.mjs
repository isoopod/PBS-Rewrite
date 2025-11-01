// scripts/generate-api-versions.mjs
import fs from 'fs'
import path from 'path'

const apiDir = path.resolve('docs/api')
const outFile = path.resolve('docs/.vitepress/api-versions.json')

// Collect all subdirectories in /docs/api that have a sidebar.ts file
const versions = fs
    .readdirSync(apiDir, { withFileTypes: true })
    .filter(entry => entry.isDirectory())
    .filter(entry =>
        fs.existsSync(path.join(apiDir, entry.name, 'sidebar.ts'))
    )
    .map(entry => entry.name)

// Ensure output folder exists
fs.mkdirSync(path.dirname(outFile), { recursive: true })

// Write the manifest
fs.writeFileSync(outFile, JSON.stringify(versions, null, 2))

console.log(`✅ Generated API version manifest: [${versions.join(', ')}]`)
