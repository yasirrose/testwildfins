
$(document).ready(function() {
	$(".search-box").select2();

	setTimeout(function() {
		$('.alert-danger').hide();
	}, 5000);
})


 handleGoogleMap = function() {

    var mapCobalt;
    var mapCobaltStyles = [{"featureType":"all","elementType":"all","stylers":[{"invert_lightness":true},{"saturation":10},{"lightness":30},{"gamma":0.5},{"hue":"#435158"}]}];

    function initialize() {
	   if (obj.length > 0) {
			var highest_lat= 0;
			var highest_long= -100;
			for (i = 0; i < obj.length; i++) {
				if(highest_lat < parseFloat(obj[i].AtLatitude)){
					highest_lat = obj[i].AtLatitude;
				}
				if(highest_long < parseFloat(obj[i].AtLongitude)){
					highest_long = obj[i].AtLongitude;
				}	
			}
		}

		 ///zoom centered
		 if (obj.length > 0){
			var	mapOptions = {
				   zoom: 9,
				   center: new google.maps.LatLng(parseFloat(highest_lat), parseFloat(highest_long)),
				   mapTypeId: google.maps.MapTypeId.ROADMAP
				   };
		   
	   }else{
		   var mapOptions = {
			       zoom: 9,
				   center: new google.maps.LatLng(27, -80),
				   mapTypeId: google.maps.MapTypeId.ROADMAP
			   };
		   }


	  mapCobalt = new google.maps.Map(document.getElementById('google-map-cobalt'), mapOptions);
	  mapCobalt.setOptions({styles: mapCobaltStyles});
  
	if(obj.length > 0) {
	  	var infowindow = new google.maps.InfoWindow();
	  	var marker, i;
		for (i = 0; i < obj.length; i++) {
			if(obj[i].AtLatitude != "" && obj[i].AtLongitude != ""){   
				marker = new google.maps.Marker({
					position: new google.maps.LatLng( parseFloat(obj[i].AtLatitude), parseFloat(obj[i].AtLongitude) ),
					map: mapCobalt
				});

				google.maps.event.addListener(marker, 'click', (function(marker, i) {
					return function() {
					infowindow.setContent('Date : '+obj[i].DateSeen+' <br> Survey Sighting ID: '+obj[i].Sighting_ID);
					infowindow.open(mapCobalt, marker);
					}
				})(marker, i));
			}
		}
	}
}
    initialize();
    google.maps.event.addDomListener(window, 'load', initialize);
};

/* Application Controller
------------------------------------------------ */
handleGoogleMap();
