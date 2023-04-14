---
layout: page
title: spoons
permalink: /spoons/
description: "all the spoons I've visited. this page uses leafletJS and plugins thereof (locatecontrol, markercluster); and has been created to assist in my learning of leafletJS."
nav: true
---

{% include leaflet-header.html %}

<div id="map" class="mb-3" style="height: 30em; border-radius: 5px;"></div>

<div class="progress mb-1">
  <div class="progress-bar" id="pubProgressbar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
</div>
  <p class="text-center mb-3"><span id="progressLeft"></span> / <span id="progressRight"></span></p>

{% assign pubs = site.data.spoons_list_20230414 | sort: 'Locality' %}
<div class="card-columns">
{% for pub in pubs %}

{% if pub.Visited == 'Y' %}
        <div class="card shadow-none border-black mb-3 text-center card-block d-flex">
            <div class="card-body align-items-center d-flex justify-content-center" style="height: 6em;">
                <h5 class="card-title">{{ pub.pubName }}</h5>
            </div>
            <div class="card-footer">
                <p class="card-text">{{ pub.Locality }}</p>
            </div>
        </div>
{% endif %}
{% endfor %}
</div>

<style>

.leaflet-marker-icon {
    border-radius: 5px;
}

</style>

<span id="tile" class="invisible">{{site.maps.tiles.spoons}}</span>

<script>
    var tileURL = document.getElementById("tile").innerHTML;


    var spoonsIcon = L.icon({
        iconUrl: '/assets/img/spoons-icon.png',
        iconSize: [24, 24],
    });


    var pubPoints = {{ site.data.spoons_list_20230414 | jsonify }};
    // console.log(pubPoints);
    var map = L.map('map').setView([53.19059056109805, -1.864886360220277], 8);

    var tl = L.tileLayer(tileURL, {
        maxZoom: 19,
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);

    function handleLocationError() {
        console.log("Location refused");
    }

    var lc = L.control.locate({keepCurrentZoomLevel:true,onLocationError: handleLocationError,}).addTo(map);

    lc.start();

    var markers = L.markerClusterGroup();

    var count = 0;


    for (i in pubPoints) {
        let pub = pubPoints[i];
        if (pub.Visited == "Y") {
            var marker = L.marker([pub.Latitude,pub.Longitude,], {icon: spoonsIcon})
            marker.bindPopup(pub.pubName);
            markers.addLayer(marker);
            count += 1;
        }
    }

    map.addLayer(markers);
    
    document.getElementById("progressLeft").innerHTML = count;
    document.getElementById("progressRight").innerHTML = pubPoints.length;


    document.getElementById("pubProgressbar").ariaValueMax = pubPoints.length;
    document.getElementById("pubProgressbar").ariaValueNow = count;

    document.getElementById("pubProgressbar").style.width = (count / pubPoints.length * 100) + "%";

</script>