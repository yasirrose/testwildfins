<meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no">
<script src='https://api.mapbox.com/mapbox-gl-js/v2.11.0/mapbox-gl.js'></script>
<link href='https://api.mapbox.com/mapbox-gl-js/v2.11.0/mapbox-gl.css' rel='stylesheet' />


<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
<!--- <cfif isDefined('form.PROJECT_ID') and form.PROJECT_ID neq ''>    

    <cfquery name="qProject" datasource="#application.dsn#">
        SELECT Surveys.* FROM Surveys
    </cfquery>

    <cfquery name="query" datasource="#application.dsn#">
    SELECT * from Survey_Sightings 
    </cfquery>

</cfif>
<cfquery name="query" datasource="#application.dsn#">
    SELECT * from Survey_Sightings 
    </cfquery> --->

<cfoutput>
    <div id="content" class="content">
        <div id="menu">
            <input id="satellite-v9" name="flexRadioDefault" type="radio"  onclick="saveMapStyle('satellite-v9')" value="mapbox://styles/mapbox/satellite-v9" >
            <label class="map-label" for="satellite-v9">Satellite</label>
            <input id="light-v10" name="flexRadioDefault" class="ml-2" type="radio" onclick="saveMapStyle('light-v10')" value="mapbox://styles/mapbox/light-v10" >
            <label class="map-label" for="light-v10"></label>Light</label>
            <input id="dark-v10" name="flexRadioDefault" type="radio" class="ml-2" onclick="saveMapStyle('dark-v10')" value="mapbox://styles/mapbox/dark-v10">
            <label class="map-label" for="dark-v10">Dark</label>
            <input id="outdoors-v11" name="flexRadioDefault" type="radio" class="ml-2" onclick="saveMapStyle('outdoors-v11')" value="mapbox://styles/mapbox/outdoors-v11" >
            <label class="map-label" for="outdoors-v11">Outdoors</label>
            <input id="heat-map" name="flexRadioDefault" type="radio" class="ml-2" onclick="saveMapStyle('light-v10')" value="mapbox://styles/mapbox/satellite-v9" :checked="is_heatMap">
            <label class="map-label" for="heat-map">Heat Map</label>
            <LanguageSwitcher class="spotter-lang-select" />
        </div>

    </div>
</cfoutput>
<script>
    // TO MAKE THE MAP APPEAR YOU MUST
    // ADD YOUR ACCESS TOKEN FROM
    // https://account.mapbox.com
    mapboxgl.accessToken = 'pk.eyJ1Ijoid2F0Y2hzcG90dGVyIiwiYSI6ImNsMmY0OTgxdzA3MW0zYm1jMmY5MGY5OG4ifQ.vEle7r52YhgPJ8D-MVlZ2A';
    const map = new mapboxgl.Map({
    container: 'content', // container ID 
    style: 'mapbox://styles/mapbox/outdoors-v11', // style URL for glob streets-v12
    center: [32.522854, 15.508457], // starting position [lng, lat]
    zoom:3, // starting zoom
    });
   


$.ajax({
      url:"http://test.wildfins.org/classes/SightingMap.cfc?method=sightingSpot",
      type: "POST",
      data: {},
      success: function(data) {

        var data = jQuery.parseJSON(data);
        var mapSighting = data.features;
        console.log(mapSighting);
    
        for (var i =0 ; i <= mapSighting.length; i++ ) {
          // create a HTML element for each feature
          const el = document.createElement('div');
          el.className = 'marker';
        
          // make a marker for each feature and add to the map
          new mapboxgl.Marker(el).setLngLat(mapSighting[i].geometry.coordinates).addTo(map);
            
        // make a marker for each feature and add it to the map
        new mapboxgl.Marker(el)
        .setLngLat(mapSighting[i].geometry.coordinates)
        .setPopup(
        new mapboxgl.Popup({ offset: 25 }) // add popups
        .setHTML(
        `<div><div class="header-title"><h3>Spot Detail</h3></div><div class="modal-content"><p><b>Title:</b>${mapSighting[i].properties.title}</p><p><b>Location:</b>${mapSighting[i].properties.description}</p><p><b>Location:</b>${mapSighting[i].properties.description}</p></div></div>`
        )
        )
        .addTo(map);
        }


        }
      
    });

     function saveMapStyle(val){
        // alert(); 
        const map = new mapboxgl.Map({
        container: 'content', // container ID
        style: 'mapbox://styles/mapbox/'+ val, // style URL
        center: [32.522854, 15.508457], // starting position [lng, lat]
        zoom:3, // starting zoom
        });


        $.ajax({
      url:"http://test.wildfins.org/classes/SightingMap.cfc?method=sightingSpot",
      type: "POST",
      data: {},
      success: function(data) {

        var data = jQuery.parseJSON(data);
        var mapSighting = data.features;
        console.log(mapSighting);
    
        for (var i =0 ; i <= mapSighting.length; i++ ) {
          // create a HTML element for each feature
          const el = document.createElement('div');
          el.className = 'marker';
        
          // make a marker for each feature and add to the map
          new mapboxgl.Marker(el).setLngLat(mapSighting[i].geometry.coordinates).addTo(map);
            
        // make a marker for each feature and add it to the map
        new mapboxgl.Marker(el)
        .setLngLat(mapSighting[i].geometry.coordinates)
        .setPopup(
        new mapboxgl.Popup({ offset: 25 }) // add popups
        .setHTML(
        `<div><div class="header-title"><h3>Spot Detail</h3></div><div class="modal-content"><p><b>Title:</b>${mapSighting[i].properties.title}</p><p><b>Location:</b>${mapSighting[i].properties.description}</p><p><b>Location:</b>${mapSighting[i].properties.description}</p></div></div>`
        )
        )
        .addTo(map);
        }


        }
      
    });

        
    }



<!--- 
        map.on('load', () => {
        // Add a new source from our GeoJSON data and
        // set the 'cluster' option to true. GL-JS will
        // add the point_count property to your source data.
        map.addSource('earthquakes', {
        type: 'geojson',
        // Point to GeoJSON data. This example visualizes all M1.0+ earthquakes
        // from 12/22/15 to 1/21/16 as logged by USGS' Earthquake hazards program.
    
        data: 'https://docs.mapbox.com/mapbox-gl-js/assets/earthquakes.geojson',
        cluster: true,
        clusterMaxZoom: 14, // Max zoom to cluster points on
        clusterRadius: 50 // Radius of each cluster when clustering points (defaults to 50)
        });
        
        map.addLayer({
        id: 'clusters',
        type: 'circle',
        source: 'earthquakes',
        filter: ['has', 'point_count'],
        paint: {
        // Use step expressions (https://docs.mapbox.com/mapbox-gl-js/style-spec/#expressions-step)
        // with three steps to implement three types of circles:
        //   * Blue, 20px circles when point count is less than 100
        //   * Yellow, 30px circles when point count is between 100 and 750
        //   * Pink, 40px circles when point count is greater than or equal to 750
        'circle-color': [
        'step',
        ['get', 'point_count'],
        '#51bbd6',
        100,
        '#f1f075',
        750,
        '#f28cb1'
        ],
        'circle-radius': [
        'step',
        ['get', 'point_count'],
        20,
        100,
        30,
        750,
        40
        ]
        }
        });
        
        map.addLayer({
        id: 'cluster-count',
        type: 'symbol',
        source: 'earthquakes',
        filter: ['has', 'point_count'],
        layout: {
        'text-field': ['get', 'point_count_abbreviated'],
        'text-font': ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
        'text-size': 12
        }
        });
        
        map.addLayer({
        id: 'unclustered-point',
        type: 'circle',
        source: 'earthquakes',
        filter: ['!', ['has', 'point_count']],
        paint: {
        'circle-color': '#11b4da',
        'circle-radius': 4,
        'circle-stroke-width': 1,
        'circle-stroke-color': '#fff'
        }
        });
        
        // inspect a cluster on click
        map.on('click', 'clusters', (e) => {
        const features = map.queryRenderedFeatures(e.point, {
        layers: ['clusters']
        });
        const clusterId = features[0].properties.cluster_id;
        map.getSource('earthquakes').getClusterExpansionZoom(
        clusterId,
        (err, zoom) => {
        if (err) return;
        
        map.easeTo({
        center: features[0].geometry.coordinates,
        zoom: zoom
        });
        }
        );
        });
        
        // When a click event occurs on a feature in
        // the unclustered-point layer, open a popup at
        // the location of the feature, with
        // description HTML from its properties.
        map.on('click', 'unclustered-point', (e) => {
        const coordinates = e.features[0].geometry.coordinates.slice();
        const mag = e.features[0].properties.mag;
        const tsunami =
        e.features[0].properties.tsunami === 1 ? 'yes' : 'no';
        
        // Ensure that if the map is zoomed out such that
        // multiple copies of the feature are visible, the
        // popup appears over the copy being pointed to.
        while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
        coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
        }
        
        new mapboxgl.Popup()
        .setLngLat(coordinates)
        .setHTML(
        `magnitude: ${mag}<br>Was there a tsunami?: ${tsunami}`
        )
        .addTo(map);
        });
        
        content.on('mouseenter', 'clusters', () => {
            content.getCanvas().style.cursor = 'pointer';
        });
        map.on('mouseleave', 'clusters', () => {
        map.getCanvas().style.cursor = '';
        });
        }); --->






    </script>

<style>
.marker {
  background-image: url('http://test.wildfins.org/assets/dolphin.png');
  background-size: cover;
  width: 50px;
  height: 50px;
  border-radius: 50%;
  cursor: pointer;
}
.mapboxgl-popup {
  max-width: 200px;
  width: 200px;
}

.header-title {
    text-align: left;
    padding: 9px;
    background: #02254b;
}

.header-title h3 {
    margin: 0;
    font-size: 12px;
    color: #fff;
}
.mapboxgl-popup-close-button {
    color: #fff;
    border: none;
    top: 3px;
    right: 2px;
    outline: none;
}
.mapboxgl-popup-content {
    padding: 0;
}
.modal-content {
    padding: 10px;
}
.modal-content p {
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-top: 1px solid #d5d8da;
    margin: 0;
    padding: 5px 0px;
}

.mapboxgl-popup-content {
  text-align: center;
  font-family: 'Open Sans', sans-serif;
}
.row.re-ro>[class*=col-] {
    padding: 0px;
}
.code-list-rwo {
    max-height: 434px;
    height: 100%;
    background: #d5d8da;
    overflow-y: scroll;
    margin-bottom: 20px;
    width: 223px;}
.code-list-rwo table {
    margin-bottom: 0;
}
.tr-tl {
    padding-bottom: 15px;
}
.exp-btn {
    padding-bottom: 5px;
}
.row.tracking-l-ro {
    padding-bottom: 30px;
}
    .export{
        margin-left: 76%;
        margin-bottom: -57px;
    }
    .values-wrapper {
        margin-bottom: 30px;
        padding-top: 10px;
    }
    .values-wrap {
        background: #FFF;
        padding: 20px 30px;
        border: 2px solid #c3c1c1;
        border-radius: 5px;
        margin-top: 0px;
        text-align: right;
    }
    .values-wrap h2 {
        margin: 0;
        font-size: 40px;
    }
    .tracking-lists table{
        background: #fff;
    }
    .table thead tr.inverse th {
        color: #333;
        background-color: #e1e7f3 !important;
        border: 1px solid #bec3c6 !important;
    }
    .incident-reports table{
        border-radius: 0px;
        border: 2px solid #ebeced !important;
    }
    #menu {
        position: fixed;
        background: #efefef;
        padding: 10px;
        // padding-top: 22px;
        padding-top: 8px;
        font-family: 'Open Sans', sans-serif;
        z-index: 1;
        left: 251px;
        top: 58px;
        height: 58px;
    }
    
    @media (max-width: 767px) {
        #menu {
            left: 58px;
        }
    }
    @media (max-width: 1199px){
        .row.tracking-l-ro {
    padding-bottom: 0px;
}
.code-list-rwo {
    width: 100%;
}
    }
</style>
