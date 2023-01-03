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
    <cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>
    <cfquery name="cetaceans" datasource="#Application.dsn#">
        select ID,Code,Name from Cetaceans order by Code ASC
     </cfquery>
<cfoutput>
    <div id="content" class="content">
        <div id="menu" style="left: 270px;" class="vertical-content">
            <input id="satellite-v9" name="flexRadioDefault" type="radio"  onclick="saveMapStyle('satellite-v9')" value="mapbox://styles/mapbox/satellite-v9" >
            <label class="map-label" for="satellite-v9">Satellite</label>
            <input id="light-v10" name="flexRadioDefault" class="ml-2" type="radio" onclick="saveMapStyle('light-v10')" value="mapbox://styles/mapbox/light-v10" >
            <label class="map-label" for="light-v10"></label>Light</label>
            <input id="dark-v10" name="flexRadioDefault" type="radio" class="ml-2" onclick="saveMapStyle('dark-v10')" value="mapbox://styles/mapbox/dark-v10">
            <label class="map-label" for="dark-v10">Dark</label>
            <input id="outdoors-v11" name="flexRadioDefault" type="radio" class="ml-2" onclick="saveMapStyle('outdoors-v11')" value="mapbox://styles/mapbox/outdoors-v11" >
            <label class="map-label" for="outdoors-v11">Outdoors</label>
            <input id="heat_map" name="flexRadioDefault" type="radio" class="ml-2" onclick="saveMapStyle('light-v10')" value="mapbox://styles/mapbox/satellite-v9" >
            <label class="map-label" for="heat-map">Heat Map</label>
            <LanguageSwitcher class="spotter-lang-select" />
        </div>
        <div class="filter-btn"><button type="button" onclick="showModal()">Filter</button> </div>
  
    </div>
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog new-modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body row">
                <div class="form-group new-form-group col-lg-12 col-md-12 col-sm-12">
                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Date Range</label>
                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                        <div id="Date-range" class="input-group">
                            <input type="text"  class="form-control" name="date" id="date" placeholder="Select Date Range">
                            <span class="input-group-btn">
                                <button type="button" class="btn btn-primary"onclick="showdate()"><i class="fa fa-calendar"></i></button>
                            </span>
                        </div>
                    </div>
                </div>
                <!--- <div> --->
                    <div class="form-group new-form-group col-lg-12 col-md-12 col-sm-12">
                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">Species</label>
                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                            <select class="form-control" name="cetaceanSpecies" id="cetaceanSpecies">
                                <option value="">Select Species</option>
                                <cfloop query="#qgetCetaceanSpecies#">
                                    <option value="#CetaceanSpeciesName#" >#CetaceanSpeciesName#</option>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                    <div class="form-group new-form-group col-lg-12 col-md-12 col-sm-12">
                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">Code</label>
                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                            <select class="form-control" id="Cetacean_code" name="Cetacean_code">
                                <option value="">Select  Code</option>
                                <cfloop query="cetaceans">
                                <option value="#cetaceans.ID#">#cetaceans.Code# </option>
                                <!--- <option value="#cetaceans.ID#"> #cetaceans.Name# | #cetaceans.Code# </option> --->
                                </cfloop>
                            </select>
                        </div>
                    </div>
                    <div class="form-group new-form-group col-lg-12 col-md-12 col-sm-12">
                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">Tracking Category</label>
                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                            <select class="form-control" name="Cetacean_code">
                                <option value="">Select  Code</option>
                                <cfloop query="cetaceans">
                                <option value="#cetaceans.ID#">#cetaceans.Code# </option>
                                <!--- <option value="#cetaceans.ID#"> #cetaceans.Name# | #cetaceans.Code# </option> --->
                                </cfloop>
                            </select>
                        </div>
                    </div>
                <!--- </div> --->

            </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" onclick="filterData()">Filter</button>
            </div>
        </div>
        </div>
    </div>
</cfoutput>
<script>

    function filterData(){
        var date = $('#date').val();
        const myArray = date.split("-");
        let word = myArray[1];
        console.log(myArray);

        var startDate = myArray[0];
        var endDate = myArray[1];
        // console.log(startDate);
        // console.log(endDate);
        var cetaceanSpecies = $('#cetaceanSpecies').val();
        var Cetacean_code = $('#Cetacean_code').val();
        // alert(date + '-' +cetaceanSpecies+'-'+ Cetacean_code )
    $.ajax({
      url:"http://test.wildfins.org/classes/SightingMap.cfc?method=getFilterSightingMapData",
      type: "POST",
      dataType: "json",
      data: {
          date: date,    
          cetaceanSpecies: cetaceanSpecies,    
          Cetacean_code: Cetacean_code,    
        },
      success: function(data) {


        var lat = 27.534991;
        var lng = -80.337171;
        var mapZoom = 7;
        var mapStyle = 'outdoors-v11';

        mapboxgl.accessToken = 'pk.eyJ1Ijoid2F0Y2hzcG90dGVyIiwiYSI6ImNsMmY0OTgxdzA3MW0zYm1jMmY5MGY5OG4ifQ.vEle7r52YhgPJ8D-MVlZ2A';
            
            const map = new mapboxgl.Map({
            container: 'content', // container ID 
            style: 'mapbox://styles/mapbox/'+mapStyle, // style URL for glob  streets-v12
            center: [lng, lat], // starting position [lng, lat]
            zoom: mapZoom, // starting zoom
            });  


        var data = jQuery.parseJSON(data);
        //   console.log('test')
        var mapSighting = data.features;
        
        for (var i =0 ; i <= mapSighting.length; i++ ) {
        // create a HTML element for each feature
        const el = document.createElement('div');
        el.className = 'marker';
        
        // make a marker for each feature and add to the map
        new mapboxgl.Marker(el).setLngLat(mapSighting[i].geometry.coordinates).addTo(map);
            var date = mapSighting[i].properties.description;        
            
        // make a marker for each feature and add it to the map
        new mapboxgl.Marker(el)
        .setLngLat(mapSighting[i].geometry.coordinates)
        .setPopup(
        new mapboxgl.Popup({ offset: 25 }) // add popups
        .setHTML(
        `<div class="head-modal"><div class="header-title"><h3>Spot Detail</h3></div><div class="modal-content"><p><b>Title:</b>${mapSighting[i].properties.title}</p><p><b>Date:</b>${mapSighting[i].properties.date}</p><p><b>Sighting Number:</b>${mapSighting[i].properties.sightingNo}</p><p><b>Species:</b>${mapSighting[i].properties.Species}</p> <a href="http://test.wildfins.org/?Module=Sighting&Page=Home&SurveyId=${mapSighting[i].properties.SurveyId}&SightingId=${mapSighting[i].properties.SightingId}">Open Sighting</a>`
        )
        )
        .addTo(map);
        }

        $('#myModal').modal('hide');

        }
      
    });
    }




    var lat = 27.534991;
    var lng = -80.337171;
    var mapZoom = 7;
    var mapStyle = 'outdoors-v11';

    $.ajax({
      url:"http://test.wildfins.org/classes/SightingMap.cfc?method=getSightingMapData",
      type: "POST",
      data: {},
      success: function(data) {
          var data = jQuery.parseJSON(data);
        // console.log(data.DATA[0]);
        if(data){
            var lat = data.DATA[0][2];
            var lng = data.DATA[0][1];
            var mapZoom = data.DATA[0][3];
            if(data.DATA[0][5] == 'light-vv10')
            {
                jQuery("#heat_map").attr('checked', true);
            }else if (data.DATA[0][5] == 'satellite-v9') {
                jQuery("#satellite-v9").attr('checked', true);
            }else if (data.DATA[0][5] == 'light-v10') {
                jQuery("#light-v10").attr('checked', true);
            }else if (data.DATA[0][5] == 'dark-v10') {
                jQuery("#dark-v10").attr('checked', true);
            }else if (data.DATA[0][5] == 'outdoors-v11') {
                jQuery("#outdoors-v11").attr('checked', true);
            }
            
            if(data.DATA[0][5] == 'light-vv10'){
                var mapStyle = 'light-v10';
            }else{
                var mapStyle = data.DATA[0][5];
            }
            loadMap(lat,lng,mapZoom,mapStyle)
            
        }else{
            loadMap(lat,lng,mapZoom,mapStyle)
        }

    }
      
    });
    // TO MAKE THE MAP APPEAR YOU MUST
    // ADD YOUR ACCESS TOKEN FROM
    // https://account.mapbox.com

    function loadMap(lat,lng,mapZoom,mapStyle)
    {
    mapboxgl.accessToken = 'pk.eyJ1Ijoid2F0Y2hzcG90dGVyIiwiYSI6ImNsMmY0OTgxdzA3MW0zYm1jMmY5MGY5OG4ifQ.vEle7r52YhgPJ8D-MVlZ2A';
    
    const map = new mapboxgl.Map({
    container: 'content', // container ID 
    style: 'mapbox://styles/mapbox/'+mapStyle, // style URL for glob  streets-v12
    center: [lng, lat], // starting position [lng, lat]
    zoom: mapZoom, // starting zoom
    });  


    $.ajax({
        url:"http://test.wildfins.org/classes/SightingMap.cfc?method=sightingSpot",
        type: "POST",
        data: {},
        success: function(data) {

            var data = jQuery.parseJSON(data);
            var mapSighting = data.features;
        
            for (var i =0 ; i <= mapSighting.length; i++ ) {
            // create a HTML element for each feature
            const el = document.createElement('div');
            el.className = 'marker';
            
            // make a marker for each feature and add to the map
            new mapboxgl.Marker(el).setLngLat(mapSighting[i].geometry.coordinates).addTo(map);
                var date = mapSighting[i].properties.description;
            
                
            // make a marker for each feature and add it to the map
            new mapboxgl.Marker(el)
            .setLngLat(mapSighting[i].geometry.coordinates)
            .setPopup(
            new mapboxgl.Popup({ offset: 25 }) // add popups
            .setHTML(
            `<div class="head-modal"><div class="header-title"><h3>Spot Detail</h3></div><div class="modal-content"><p><b>Title:</b>${mapSighting[i].properties.title}</p><p><b>Date:</b>${mapSighting[i].properties.date}</p><p><b>Sighting Number:</b>${mapSighting[i].properties.sightingNo}</p><p><b>Species:</b>${mapSighting[i].properties.Species}</p> <a href="http://test.wildfins.org/?Module=Sighting&Page=Home&SurveyId=${mapSighting[i].properties.SurveyId}&SightingId=${mapSighting[i].properties.SightingId}">Open Sighting</a>`
            )
            )
            .addTo(map);
            }


            }
        
        });
    }



     function saveMapStyle(val){


        $.ajax({
            url:"http://test.wildfins.org/classes/SightingMap.cfc?method=getSightingMapData",
            type: "POST",
            data: {},
            success: function(data) {
                var data = jQuery.parseJSON(data);
                console.log(data.DATA[0]);
                if(data){
                var lat = data.DATA[0][2];
                var lng = data.DATA[0][1];
                var mapZoom = data.DATA[0][3];
                // loadMap(lat,lng,mapZoom)

        const map = new mapboxgl.Map({
        container: 'content', // container ID
        style: 'mapbox://styles/mapbox/'+ val, // style URL
        center:  [lng, lat], // starting position [lng, lat]
        zoom:mapZoom, // starting zoom
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
                `<div class="head-modal"><div class="header-title"><h3>Spot Detail</h3></div><div class="modal-content"><p><b>Title:</b>${mapSighting[i].properties.title}</p><p><b>Location:</b>${mapSighting[i].properties.description}</p><p><b>Location:</b>${mapSighting[i].properties.description}</p></div></div>`
                )
                )
                .addTo(map);
                }


                }
            
            });

            }else{
            // loadMap(lat,lng,mapZoom)
            }

            }

        });
      
    }
function showModal(){
    $('#myModal').modal('show');
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
  background-image: url('http://test.wildfins.org/assets/mapBox_icon.png');
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
.head-modal a {
    display: flex;
    justify-content: flex-end;
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

.modal-content p:nth-child(4) {
    border-bottom: 1px solid #d5d8da;
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
.new-modal-dialog {
    width: 600px !important;
}
.new-form-group {
    display: flex;
    align-items: center;
}
.new-form-group label {
    margin-bottom: 0px;
}
.vertical-content input {
    vertical-align: text-bottom;
}
    .filter-btn {
        position: absolute;
        bottom: 40px;
        z-index: 8;
        right: 90px;
    }
    .filter-btn button {
        max-width: 130px;
        width: 130px;
        font-size: 14px;
        font-weight: 700;
        min-width: 100px;
        padding: 10px 30px;
        background-color: #fff;
        border-color: #02254b;
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
        left: 250px !important;
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
