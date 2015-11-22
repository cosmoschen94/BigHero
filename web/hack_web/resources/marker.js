
var container = [];

function loadJSON(callback) {   

    var xobj = new XMLHttpRequest();
        xobj.overrideMimeType("application/json");
    xobj.open('GET', 'data.json', true); 
    xobj.onreadystatechange = function () {
          if (xobj.readyState == 4 && xobj.status == "200") {
            // Required use of an anonymous callback as .open will NOT return a value but simply returns undefined in asynchronous mode
            callback(xobj.responseText);
          }
    };
    xobj.send(null);  
 }




	function initMap(){


		loadJSON(function(response) {
	    	var actual_JSON = JSON.parse(response);
   	    	var map = new google.maps.Map(document.getElementById('map'), {
	   			 zoom: 12,
	   			 center: {lat: 37.7833, lng: -122.4167}
			});


   	    var markers = [];
		for (i = 0 ; i < actual_JSON.length; i++)
		{
			var ob = actual_JSON[i];
			var latt = ob["Latitude"];
			var longi = ob["Longitude"];
			var num_rooms = ob["Number of Bedrooms"];
			var price = ob["Rent Price"];

			var marker = new google.maps.Marker({
	    		position: {lat: latt, lng: longi},
	   			map: map,
	    		title: 'Hello World!'
	 		 });

			container.push(actual_JSON[i]);
			markers.push(marker);
	attachSecretMessage(marker,"Price: "+price.toString()+"   Number of Bedrooms"+num_rooms.toString());
   		 }


   		 

	});
}

function attachSecretMessage(marker, secretMessage) {
  var infowindow = new google.maps.InfoWindow({
    content: secretMessage
  });

  marker.addListener('click', function() {
    infowindow.open(marker.get('map'), marker);
  });
}



