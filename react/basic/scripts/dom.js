(function() {
  const parent = document.getElementById("dom-container");
  const child = document.createElement("p");
  child.textContent = "Hello Dom!!";
  child.className = "root";
  parent.appendChild(child);
})();
