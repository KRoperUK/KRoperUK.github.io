---
layout: page
title: hikes
permalink: /hikes/
nav: true
description: all the different hikes I have been on
display_categories: [trip]
horizontal: false
---

<!-- pages/hikes.md -->
<div class="hikes">
{%- if site.enable_hike_categories and page.display_categories %}
  <!-- Display categorized hikes -->
  {%- for category in page.display_categories %}
  <h2 class="category">{{ category }}</h2>
  {%- assign categorized_hikes = site.hikes | where: "category", category -%}
  {%- assign sorted_hikes = categorized_hikes | sort: "importance" %}
  <!-- Generate cards for each hikes -->
  {% if page.horizontal -%}
  <div class="container">
    <div class="row row-cols-2">
    {%- for hike in sorted_hikes -%}
      {% include hikes_horizontal.html %}
    {%- endfor %}
    </div>
  </div>
  {%- else -%}
  <div class="grid">
    {%- for hike in sorted_hikes -%}
      {% include hikes.html %}
    {%- endfor %}
  </div>
  {%- endif -%}
  {% endfor %}

{%- else -%}
<!-- Display hikes without categories -->
  {%- assign sorted_hikes = site.hikes | sort: "importance" -%}
  <!-- Generate cards for each hikes -->
  {% if page.horizontal -%}
  <div class="container">
    <div class="row row-cols-2">
    {%- for hikes in sorted_hikes -%}
      {% include hikes_horizontal.html %}
    {%- endfor %}
    </div>
  </div>
  {%- else -%}
  <div class="grid">
    {%- for hike in sorted_hikes -%}
      {% include hikes.html %}
    {%- endfor %}
  </div>
  {%- endif -%}
{%- endif -%}
</div>
