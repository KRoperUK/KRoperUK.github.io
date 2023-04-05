---
layout: page
title: spoons
permalink: /spoons/
description: all the spoons I've visited
nav: false
---

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css" integrity="sha256-kLaT2GOSpHechhsozzB+flnD+zUyjE2LlfWPgU04xyI=" crossorigin="" />
<script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js" integrity="sha256-WBkoXOwTeyKclOHuWtc+i2uENFpDZ9YPdf5Hf+D7ewM=" crossorigin=""></script>


<div id="map" class="mb-5" style="height: 30em; border-radius: 5px;"></div>


{% assign pubs = site.data.spoons_list_20221005 | sort: 'Locality' %}
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

<script>

    var spoonsIcon = L.icon({
        iconUrl: '/assets/img/spoons-icon.png',
        iconSize: [24, 24],
    });


    var pubPoints = {{ site.data.spoons_list_20221005 | jsonify }};
    // console.log(pubPoints);
    var map = L.map('map').setView([53.19059056109805, -1.864886360220277], 8);
    L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
        maxZoom: 19,
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);


    for (i in pubPoints) {
        let pub = pubPoints[i];
        if (pub.Visited == "Y") {
            let marker = L.marker([pub.Latitude,pub.Longitude,], {icon: spoonsIcon}).addTo(map);
            marker.bindPopup(pub.pubName);
        }
    }
    console.log(markers);

</script>