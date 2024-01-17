import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
    ],
    server: {
        proxy: {
          '/api': {
            target: 'http://localhost:8080', // replace with your Laravel app's URL
            changeOrigin: true,
            rewrite: (path) => path.replace(/^\/api/, '')
          }
        }
    },
});