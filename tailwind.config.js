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
        'login': '#EADFB4'
      }
    }
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["retro"],
  },
}
