module.exports = {
  content: [
    './app/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './lib/**/*.{js,ts,jsx,tsx,mdx}'
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          950: '#020b1c',
          900: '#071d3a',
          800: '#0a2d53',
          700: '#0f5cc7',
          cyan: '#35e2ff',
          blue: '#1f5fff'
        }
      },
      boxShadow: {
        neon: '0 0 30px rgba(53,226,255,0.4)'
      }
    }
  },
  plugins: []
};
