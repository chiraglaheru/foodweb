import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: ['public/assets/js/app.js', 'resources/css/app.css'], // Update these paths if needed
            refresh: true,
        }),
    ],
});
