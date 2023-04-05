---
layout: page
title: spoons
permalink: /spoons/
description: all the spoons I've visited
nav: false
---

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