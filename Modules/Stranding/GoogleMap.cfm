<style>
#canvas-map {
  height: 100%;
}
 .google-modal-body{
    height: 500px;
  }
</style>


<!--- Google Map Modal  --->
<div id="google_map" class="modal fade" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" onClick="googleMapClose()">&times;</button>
            <h4 class="modal-title">Google Map</h4>
          </div>
          <div class="modal-body google-modal-body" style="overflow:hidden">
            <div id="canvas-map"></div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" onClick="googleMapClose()">Close</button>
          </div>
      </div>
    </div>
</div>

<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBxYI6DN6VquzG8dxWfN04TAK5Rfngn9ug" defer></script>
<script>
function googleMapClose(){
  $('#google_map').removeClass('in');
  $('#google_map').hide();
}
function checkLatLng(){
    var atLatitude = ($('#AtLatitude').val()).trim();
    var atLongitude = ($('#AtLongitude').val()).trim();
    if(atLatitude != "" && atLongitude !=""){
        openGoogleMapModal();
        validateLatLng(parseFloat(atLatitude), parseFloat(atLongitude));
    } else {
      alert("Please set the Latitude and Longitude!");
      return false;
    }
}
function checkLatLngTaged(){
    var atLatitude = ($('#AtLatitudeTaged').val()).trim();
    var atLongitude = ($('#AtLongitudeTaged').val()).trim();
    if(atLatitude != "" && atLongitude !=""){
        openGoogleMapModal();
        validateLatLng(parseFloat(atLatitude), parseFloat(atLongitude));
    } else {
      alert("Please set the Latitude and Longitude!");
      return false;
    }
}
function checkCarcassStatus(){
    var atLatitude = ($('#CarcassStatusLat').val()).trim();
    var atLongitude = ($('#CarcassStatusLon').val()).trim();
    if(atLatitude != "" && atLongitude !=""){
        openGoogleMapModal();
        validateLatLng(parseFloat(atLatitude), parseFloat(atLongitude));
    } else {
      alert("Please set the Latitude and Longitude!");
      return false;
    }
}

function openGoogleMapModal(){
    $('#google_map').addClass('in');
    $('#google_map').show();
}

function validateLatLng(lat,lng){
  var mapCobaltStyles = [{"featureType":"all","elementType":"all","stylers":[{"invert_lightness":true},{"saturation":10},{"lightness":30},{"gamma":0.5},{"hue":"#435158"}]}];
  const myLatLng = {
        lat: lat,
        lng: lng
      };
      const map = new google.maps.Map(document.getElementById("canvas-map"), {
        zoom: 9,
        center: myLatLng
      });
      map.setOptions({styles: mapCobaltStyles});
      new google.maps.Marker({
        position: myLatLng,
        map,
        title: "Location on the google Map"
      });
      return false;
}
</script>
