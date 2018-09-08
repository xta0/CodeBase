module.exports = {
  env: {
    browser: true,
    node: true
  },
  extends: "airbnb",
  plugins: ["react", "jsx-a11y", "import"],
  rules: {
    "no-console": 0,
    "class-methods-use-this": 0,
    "react/prop-types": 0,
    "react/jsx-filename-extension": [1, { extensions: [".js", ".jsx"] }]
  }
};
