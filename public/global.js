function insertAfter(newNode, referenceNode) {
  referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling);
}

var req = new XMLHttpRequest();
req.open("get", "/api/assignments");

req.addEventListener("load", function(){
  for(var i = 0; i < this.response.length; i++){
    // var container = document.getElementById("main");
    var container_ul = document.getElementById("listhere");
    // container.innerHTML = this.response[i];
    var descript_li=this.response[i].description;
    var my_id=this.response[i].id;
    add_li = document.createElement("li");
    add_li.innerHTML=descript_li;
    add_li.setAttribute("data-id", my_id)

    add_li.addEventListener('click', function() {
      var req2 = new XMLHttpRequest();
      var str = "/api/assignment_collabs/" + this.getAttribute("data-id");
      var clicked_li = this;

      req2.open("get", str);

      req2.addEventListener("load", function(){
        var collab_name = this.response.join(", ");
        add_div = document.createElement("div");
        add_div.innerHTML=collab_name;
        insertAfter(add_div, clicked_li);

      });
      req2.responseType = "json";
      req2.send();
    });

    insertAfter(add_li, container_ul);
  }
});

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
