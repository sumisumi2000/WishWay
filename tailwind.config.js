module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  theme: {
    fontFamily: {
      kiwimaru: ["Kiwi Maru"],
    },
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["retro", "dark"],
  },
};
