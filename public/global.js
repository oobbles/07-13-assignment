function insertAfter(newNode, referenceNode) {
  referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling);
}
var req = new XMLHttpRequest();
req.open("get", "/api/assignments");

req.addEventListener("load", function(){
  for(var i = 0; i < this.response.length; i++){
    var container = document.getElementById("main");
    var container_ul = document.getElementById("listhere");

    // container.innerHTML = this.response[i];
    descript_li=this.response[i].description
    add_li = document.createElement("li");
    add_li.innerHTML=descript_li;
    insertAfter(add_li, container_ul);
  }
})

req.responseType = "json";
req.send();

//
// for (var key in p) {
//   if (p.hasOwnProperty(key)) {
//     alert(key + " -> " + p[key]);
//   }
// }
//
// var obj = {a: 1, b: 2};
// for (var key in obj) {
//   if (obj.hasOwnProperty(key)) {
//     var val = obj[key];
//     console.log(val);
//   }
// }
