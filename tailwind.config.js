import daisyui from 'daisyui';

export default {
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: { extend: {} },
  plugins: [daisyui],
  daisyui: {
    themes: [
      {
        awLight: {
          "primary": "#2563eb",
          "secondary": "#06b6d4",
          "accent": "#22c55e",
          "neutral": "#0f172a",
          "base-100": "#f8fafc",
          "base-200": "#f1f5f9",
          "base-300": "#e2e8f0",
          "base-content": "#0f172a",
          "info": "#3b82f6",
          "success": "#22c55e",
          "warning": "#f59e0b",
          "error": "#ef4444",
        },
      },
      {
        awDark: {
          "primary": "#60a5fa",
          "secondary": "#22d3ee",
          "accent": "#34d399",
          "neutral": "#0b1220",
          "base-100": "#020617",
          "base-200": "#0b1220",
          "base-300": "#111827",
          "base-content": "#e5e7eb",
          "info": "#60a5fa",
          "success": "#34d399",
          "warning": "#fbbf24",
          "error": "#fb7185",
        },
      },
    ],
  },
};
