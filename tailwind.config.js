module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    fontFamily: {
      kiwimaru: ['Kiwi Maru']
    },
    extend: {
      colors: {
        'login': '#EADFB4',
        'test': '#F9DBBB',
        'dot': '#D8D9CF'
      }
    }
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["retro"],
  },
}
