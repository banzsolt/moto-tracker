/**
 * Created by Zsolti on 17/04/2016.
 */

function initMap() {


    var lastPosition = {lat: parseFloat(gon.gps_data.last()['latitude']),
                        lng: parseFloat(gon.gps_data.last()['longitude'])};

    var mapDiv = document.getElementById('map');
    var map = new google.maps.Map(mapDiv, {
        center: lastPosition,
        zoom: 8
    });

    var flightPlanCoordinates = [
        {lat: 37.772, lng: -122.214},
        {lat: 21.291, lng: -157.821},
        {lat: -18.142, lng: 178.431},
        {lat: -27.467, lng: 153.027}
    ];
    var flightPath = new google.maps.Polyline({
        path: flightPlanCoordinates,
        geodesic: true,
        strokeColor: '#FF0000',
        strokeOpacity: 1.0,
        strokeWeight: 2
    });

    //flightPath.setMap(map);


    console.dir(gon.gps_data);

    var bikeLocationData = parseHelper(gon.gps_data);

    var bikeLocationPath = new google.maps.Polyline({
        path: bikeLocationData,
        geodesic: true,
        strokeColor: '#FF0000',
        strokeOpacity: 1.0,
        strokeWeight: 2
    });

    bikeLocationPath.setMap(map);
    bikeLocationPath.addListener('click', showArrays);
    infoWindow = new google.maps.InfoWindow;

    var marker = new google.maps.Marker({
        position: lastPosition ,
        map: map,
        title: 'Hello World!'
    });

}

/** @this {google.maps.Polygon} */
function showArrays(event) {
    // Since this polygon has only one path, we can call getPath() to return the
    // MVCArray of LatLngs.
    console.dir(event);
    var vertices = this.getPaths();
    console.dir(vertices);

    var contentString = '<b>Device location</b><br>' +
        'Clicked location: <br>' + event.latLng.lat() + ',' + event.latLng.lng() +
        '<br>';

    // Replace the info window's content and position.
    infoWindow.setContent(contentString);
    infoWindow.setPosition(event.latLng);

    infoWindow.open(map);
}

$(function () {

    //console.dir(gon.gps_data);

    //var bikeLocationData = gon.gps_data;

    //var bikeLocationPath = new google.maps.Polyline({
        //path: bikeLocationData,
        //geodesic: true,
        //strokeColor: '#FF0000',
       // strokeOpacity: 1.0,
      //  strokeWeight: 2
    //});

    //bikeLocationPath.setMap(map);
    //flightPath.addListener('click', showArrays);

});



function parseHelper(data)
{
    var result = [];
    data.forEach(function(element)
    {
        element['longitude'] = parseFloat(element['longitude']);
        element['latitude'] = parseFloat(element['latitude']);
        element['lat'] = element['latitude'];
        element['lng'] = element['longitude'];
        result.push(element);
    });

    return result
}