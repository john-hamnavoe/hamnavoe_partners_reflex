module.exports = {
  purge: {
    // enabled: true, //comment this in to see purge in development
    content: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/**/*.vue']
    // Add any other JS files here (i.e. .jsx, .ts, etc...)
    },
    darkMode: false, // or 'media' or 'class'
    theme: {
      fontSize: {
        'xxs': '.60rem',
        'xs': '.75rem',
        'sm': '.875rem',
        'tiny': '.875rem',
         'base': '1rem',
         'lg': '1.125rem',
         'xl': '1.25rem',
         '2xl': '1.5rem',
        '3xl': '1.875rem',
        '4xl': '2.25rem',
         '5xl': '3rem',
         '6xl': '4rem',
        '7xl': '5rem',
       },
      extend: {height: {
        "10v": "10vh",
        "20v": "20vh",
        "30v": "30vh",
        "40v": "40vh",
        "50v": "50vh",
        "60v": "60vh",
        "70v": "70vh",
        "80v": "80vh",
        "90v": "90vh",
        "100v": "100vh",
      },
      colors: {
        brand: {
          light: "#EA5656",
          DEFAULT: "#D61215",
          dark: "#152452",
        }
      },    
      tableLayout: ['hover', 'focus']},
    },
    variants: {    extend: {
      opacity: ['disabled'],
    }},
    plugins: [],
  }
  




