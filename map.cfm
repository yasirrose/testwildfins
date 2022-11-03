
<style>
#map {
  height: 100%;
}
</style>

    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBZ-VbvSpyS4Mws4Xm8que1DZM80BmA_No"
      defer
    ></script>

<script>
console.log("maap open"); 
  "use strict";

  function initMap() {
    console.log("initMap called");
    const myLatLng = {
      lat: -25.363,
      lng: 131.044
    };
    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 4,
      center: myLatLng
    });
    new google.maps.Marker({
      position: myLatLng,
      map,
      title: "Hello World!"
    });
}
</script>

<h1 onClick="initMap()">Google Maps</h1>
<div id="map"></div>
