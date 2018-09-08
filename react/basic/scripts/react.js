(function() {
  const parent = document.getElementById("react-container");
  const child = React.createElement("p", {
    className: "root",
    children: "Hello Rect!!"
  });
  ReactDOM.render(child, parent);
})();
