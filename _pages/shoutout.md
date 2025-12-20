---
layout: page
permalink: /shoutout-alex/
title: shoutout to alex
description: ""
nav: false
---

<div id="shoutout-content"></div>

<input class="button-2 w-100 border" style="height:5em" id="button-shoutout" type="button" value="Begin Shoutout" onclick="handleButton();" />

<script>    
var i = 0;
var txt = `These past three weeks have been a brilliant time of learning, getting a great insight into teaching and finding out about education behind the scenes. Thanks to your mentorship I have learned so much and have enjoyed it thoroughly. You might have only been here since January but you and the rest of your department and the wider Enterprise (the organisational structure of GSA is still a little hazy sometimes) have been so welcoming and a group of people I wish to cross paths with and contact in my future.

§I will think fondly of my time at GSA under your wing. Thanks to you and the rest of the department, my premonitions of teaching have been subdued and I have enjoyed it so much.

§My placement will be a year of learning my craft and passion and putting it into practice. I hope to learn at least 17.333333 times as much stuff as I have at GSA (given it's ~52 weeks long), but I sincerely doubt it will be that enlightening. 😄

§Once again thank you very much for all that you have done. Good luck to you and Connor with the next academic year, and good luck with A-level.

§- Kieran :)

§P.S: I shall definitely help you out with it, if you require.`; /* The text */
var speed = 20; /* The speed/duration of the effect in milliseconds */

var openColon = false;

function handleButton() {
    document.getElementById("button-shoutout").remove();
    typeWriter();
}

function typeWriter() {
    
  if (i < txt.length) {
    if (txt.charAt(i) == "§"){
        document.getElementById("shoutout-content").innerHTML += "<br /><br />";
    } else {
        document.getElementById("shoutout-content").innerHTML += txt.charAt(i);
    }
    i++;
    setTimeout(typeWriter, speed);
  }
}
</script>