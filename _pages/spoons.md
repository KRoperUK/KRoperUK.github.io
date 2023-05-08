---
layout: page
title: spoons
permalink: /spoons/
description: "all the spoons I've visited. this page uses leafletJS and plugins thereof (locatecontrol, markercluster); and has been created to assist in my learning of leafletJS."
nav: true
---

{% include leaflet-header.html %}

<div id="container-map">
    <div id="map" class="mb-3" style="height: 30em; border-radius: 5px;"></div>
</div>
<center>
    <button class="btn mb-3" id="visited" onclick="handleVisitedSwap()">
        <i class="fas fa-map-marker-alt"></i>
        <span id="visited-shown-text">View Unvisited</span>
    </button>
</center>

<div class="progress mb-1">
  <div class="progress-bar" id="pubProgressbar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
</div>
  <p class="text-center mb-3"><span id="progressLeft"></span> / <span id="progressRight"></span></p>

{% assign pubs = site.data.spoons_list_20230414 | sort: 'Locality' %}
<div class="card-columns" style="display: inline-block;" id="cards-landing">
</div>

<style>

.leaflet-marker-icon {
    border-radius: 5px;
}

.dumb-a {
    text-decoration:none;
    transition: all 0.1s linear;
    z-index: 100;
}
.dumb-a:hover {
    z-index: 1000;
    text-decoration:none;
    transform: scale(1.05);
    filter: brightness(1.05);
    border-radius: 0.5em;
}

#cluster-switch {
    background-color: red;
}

.leaflet-cluster-switch {
    margin-top: 10px;
    margin-left: 10px;
}

</style>


<script>
    const tileURL = {{ site.maps.tiles.spoons | jsonify}}
    unvisitedShown = false;

    var spoonsIcon = L.icon({
        iconUrl: '/assets/img/spoons-icon.png',
        iconSize: [24, 24],
    });

    var greySpoonsIcon = L.divIcon({
        // iconUrl: '/assets/img/spoons-icon.png',
        iconSize: [24, 24],
        html: '<img alt="W" src="/assets/img/spoons-icon.png" style="display: block; color: white; width: 100%; height: 100%;background-color: grey; filter: sepia(); "></img>'
    });

    var closedSpoonsIcon = L.icon({
        iconUrl: '/assets/img/closed-spoons-icon.png',
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

    var visitedMarkers = L.markerClusterGroup();
    var unvisitedMarkers = L.markerClusterGroup();

    var count = 0;


    for (i in pubPoints) {
        let pub = pubPoints[i];
        if (pub.Visited == "Y") {
            var marker = L.marker([pub.Latitude,pub.Longitude,], {icon: (pub.Closed == "Y") ? closedSpoonsIcon : spoonsIcon})
            marker.bindPopup(`<center><a href="${pub.SourceURL}"><b>${pub.pubName}</b></a><br>${pub.Locality}</center>`);
            visitedMarkers.addLayer(marker);
            count += 1;
            
            let cardA = document.createElement("a");
            cardA.classList.add("dumb-a");

            cardA.href = pub.SourceURL;

            let card = document.createElement("div");
            card.classList.add("card");
            card.classList.add("shadow-none");
            card.classList.add("border-black");
            card.classList.add("mb-3");
            card.classList.add("text-center");
            card.classList.add("card-block");
            card.classList.add("d-flex");
            card.classList.add("dumb-a");
            if (pub.Closed == "Y") {
                card.classList.add("bg-danger");
            }
            
            let cardInner = document.createElement("div");
            cardInner.classList.add("card-body");
            cardInner.classList.add("align-items-center");
            cardInner.classList.add("d-flex");
            cardInner.classList.add("justify-content-center");
            cardInner.style.height = "6em";

            let cardInnerText = document.createElement("h5");
            cardInnerText.classList.add("card-title");
            if (pub.Closed == "Y") {
                cardInnerText.innerHTML = "<br>" + pub.pubName + "<br><small>Closed</small>";
            } else {
                cardInnerText.innerHTML = pub.pubName;
            }

            let cardFooter = document.createElement("div");
            cardFooter.classList.add("card-footer");
            
            let cardFooterText = document.createElement("p");
            cardFooterText.classList.add("card-text");
            cardFooterText.innerHTML = pub.Locality;
            
            cardFooter.innerHTML = cardFooterText.outerHTML;
            cardInner.innerHTML = cardInnerText.outerHTML;

            card.innerHTML = cardInner.outerHTML + cardFooter.outerHTML;
            cardA.innerHTML = card.outerHTML;

            cardInner.appendChild(cardInnerText);
            cardFooter.innerHTML = cardFooterText.outerHTML;
            
            document.getElementById("cards-landing").appendChild(cardA);
        } else {
            var marker = L.marker([pub.Latitude,pub.Longitude,], {icon: (pub.Closed == "Y") ? closedSpoonsIcon : greySpoonsIcon})
            marker.bindPopup(`<center><a href="${pub.SourceURL}"><b>${pub.pubName}</b></a><br>${pub.Locality}</center><center><small><i>Unvisited</i></small></center>`);
            unvisitedMarkers.addLayer(marker);

        }
    }
    
    map.addLayer(visitedMarkers);
    // map.addLayer(unvisitedMarkers);
    // unvisitedShown = true;

    
    document.getElementById("progressLeft").innerHTML = count;
    document.getElementById("progressRight").innerHTML = pubPoints.length;


    document.getElementById("pubProgressbar").ariaValueMax = pubPoints.length;
    document.getElementById("pubProgressbar").ariaValueNow = count;

    document.getElementById("pubProgressbar").style.width = (count / pubPoints.length * 100) + "%";

    function handleVisitedSwap() {
        if (unvisitedShown) {
            map.removeLayer(unvisitedMarkers);
            document.getElementById("visited-shown-text").innerHTML = "View Unvisited";
            unvisitedShown = false;
        } else {
            map.addLayer(unvisitedMarkers);
            document.getElementById("visited-shown-text").innerHTML = "Hide Unvisited";
            unvisitedShown = true;
        }
    }
</script>
