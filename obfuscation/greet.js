function greet() {
  var greet1 = "Hello, "; //comment
  var greet2 = "! Nice seeing you around.";
  var name = prompt("What is your name? ", null);
  var message = greet1 + name + greet2; //comment
  //document.write(message);
  alert(message)
  //console.log(message);
}

greet()
