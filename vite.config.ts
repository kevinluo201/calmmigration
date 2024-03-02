import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig({
  plugins: [
    RubyPlugin(),
  ],
  esbuild: {
    loader: "tsx",
    include: [
      "app/**/*.jsx",
      "app/**/*.tsx",
      "node_modules/**/*.jsx",
      "node_modules/**/*.tsx",
    ],
  }
})
