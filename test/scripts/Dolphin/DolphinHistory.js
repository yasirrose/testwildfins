$(".search-box").select2();


 handleGoogleMap = function() {

    var mapCobalt;

    var mapLightDreamStyles = [{"featureType":"landscape","stylers":[{"hue":"#FFBB00"},{"saturation":43.400000000000006},{"lightness":37.599999999999994},{"gamma":1}]},{"featureType":"road.highway","stylers":[{"hue":"#FFC200"},{"saturation":-61.8},{"lightness":45.599999999999994},{"gamma":1}]},{"featureType":"road.arterial","stylers":[{"hue":"#FF0300"},{"saturation":-100},{"lightness":51.19999999999999},{"gamma":1}]},{"featureType":"road.local","stylers":[{"hue":"#FF0300"},{"saturation":-100},{"lightness":52},{"gamma":1}]},{"featureType":"water","stylers":[{"hue":"#0078FF"},{"saturation":-13.200000000000003},{"lightness":2.4000000000000057},{"gamma":1}]},{"featureType":"poi","stylers":[{"hue":"#00FF6A"},{"saturation":-1.0989010989011234},{"lightness":11.200000000000017},{"gamma":1}]}];
    var mapEsqueStyles = [{"featureType":"landscape.man_made","elementType":"geometry","stylers":[{"color":"#f7f1df"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#d0e3b4"}]},{"featureType":"landscape.natural.terrain","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"poi.medical","elementType":"geometry","stylers":[{"color":"#fbd3da"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#bde6ab"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#ffe15f"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#efd151"}]},{"featureType":"road.arterial","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]},{"featureType":"road.local","elementType":"geometry.fill","stylers":[{"color":"black"}]},{"featureType":"transit.station.airport","elementType":"geometry.fill","stylers":[{"color":"#cfb2db"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#a2daf2"}]}];
    var mapCobaltStyles = [{"featureType":"all","elementType":"all","stylers":[{"invert_lightness":true},{"saturation":10},{"lightness":30},{"gamma":0.5},{"hue":"#435158"}]}];
    var mapGreyStyles = [{"featureType":"all","elementType":"labels.text.fill","stylers":[{"saturation":36},{"color":"#000000"},{"lightness":40}]},{"featureType":"all","elementType":"labels.text.stroke","stylers":[{"visibility":"on"},{"color":"#000000"},{"lightness":16}]},{"featureType":"all","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"administrative","elementType":"geometry.fill","stylers":[{"color":"#000000"},{"lightness":20}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#000000"},{"lightness":17},{"weight":1.2}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":20}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":21}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#000000"},{"lightness":17}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#000000"},{"lightness":29},{"weight":0.2}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":18}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":16}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":19}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":17}]}];
    var mapBlueStyles = [{"featureType":"all","stylers":[{"hue":"#0000b0"},{"invert_lightness":"true"},{"saturation":-30}]}];

    function initialize() {
       
	   
	   
	   	if (obj.length > 0) {
			
			var highest_lat=0;
			var highest_long= -100;
			
		for (i = 0; i < obj.length; i++) {

			if(highest_lat < obj[i].Begin_LAT_Dec){
				highest_lat=obj[i].Begin_LAT_Dec;
				}
			
			if(highest_long < obj[i].Begin_LON_Dec){
				highest_long=obj[i].Begin_LON_Dec;
				}
				
		}}
	   
	   ///zoom centered
		if (obj.length > 0){
 			var	mapOptions = {
					zoom: 8,
					center: new google.maps.LatLng(27, -80),
					mapTypeId: google.maps.MapTypeId.ROADMAP
						};
			
		}else{
			var mapOptions = {
					zoom: 6,
					center: new google.maps.LatLng(27, -80),
					mapTypeId: google.maps.MapTypeId.ROADMAP
        		};
			}
			
	   
		var infowindow = new google.maps.InfoWindow();
		var marker, i;

        mapCobalt = new google.maps.Map(document.getElementById('google-map-cobalt'), mapOptions);
        mapCobalt.setOptions({styles: mapCobaltStyles});

		
		if (obj.length > 0) {
			
			for (i = 0; i < obj.length; i++) {
				 
				Easting  = obj[i].Easting_X.toString().length;
				Northing = obj[i].Northing_Y.toString().length;
				lat      = "";
				lng      = "";
				if (Easting >= 6  && Northing >=7) {
		
					//var utm1 = new UTMRef(Easting_X, Northing_Y, "N", 17);
					var utm1 = new UTMRef(obj[i].Easting_X, obj[i].Northing_Y, "N", 17);
					
					var ll3 = utm1.toLatLng();
					lat = ll3.lat;
					lat=decimalPlaces(lat,5);
					//lat = parseFloat(lat.toFixed(5));
					lng = ll3.lng;
					lng=decimalPlaces(lng,5);
				}
				else{
					lat = obj[i].Begin_LAT_Dec;
					lng	= obj[i].Begin_LON_Dec;	
				}

				marker = new google.maps.Marker({
				position: new google.maps.LatLng(lat , lng),
				map: mapCobalt
				 });
			
			
				 google.maps.event.addListener(marker, 'click', (function(marker, i) {
				return function() {
				  infowindow.setContent('Date : '+obj[i].DateSeen+' <br> Project Sighting Id: '+obj[i].SightingNo+'<br> Photo Id:');
				  infowindow.open(mapCobalt, marker);
				}
				})(marker, i));
			 
			 }
		}

				
 
    }
    initialize();
    google.maps.event.addDomListener(window, 'load', initialize);
};


/* Application Controller
------------------------------------------------ */
handleGoogleMap();

function sendForm() {
	if ($('#dolphin_dscore').val() =='') {
		 bootbox.alert('Please select dolphin'); return false;
		}
	else {
		$('#dolphin_id').val($('#dolphin_dscore').val());
		document.getElementById("detailform").submit();
	}
}
$("#image").on("click", function() {
	$('#imagepreview').attr('src', $('#imageresource').attr('src'));  
	$('#imagemodal').modal('show'); 
});
function decimalPlaces(float,length) {
	ret = "";
	str = float.toString();
	array = str.split(".");
	if(array.length==2) {
		ret += array[0] + ".";
		for(i=0;i<length;i++) {
			if(i>=array[1].length) ret += '0';
			else ret+= array[1][i];
		}
	}
	else if(array.length == 1) {
		ret += array[0] + ".";
		for(i=0;i<length;i++) {
			ret += '0'
		}
	}

	return ret;
}