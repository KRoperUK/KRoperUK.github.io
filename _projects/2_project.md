---
layout: project
title: UoB Study Spaces
description: "A simple website to show the study spaces available at the University of Birmingham."
img: "/assets/img/study-spaces.png"
preview_image: false
importance: 1
category: fun
repo: KRoperUK/uobstudyspaces
---

## [Live Website](https://uobstudy.space)

<div id="previewButton">
    <a href="javascript:enablePreview()"><button class="button-2" role="button" >Enable Preview</button></a>
</div>
<iframe id="preview" hidden  title="UoB Study Spaces"></iframe>
<br>
## Features

- Uses [operating_hours.js](https://github.com/opening-hours/opening_hours.js/)
- Shows live opening times can be updated easily through a .yml file.
- Toggle between showing all or only open study spaces.
- Toggle between different map layers.
- Works on desktop and mobile.
- Dark mode support.



<script>
    function enablePreview() {
        document.getElementById("preview").setAttribute("style", "width:100%; height: 80vh;");
        document.getElementById("preview").setAttribute("src", "https://www.uobstudy.space");

        document.getElementById("preview").removeAttribute("hidden");
        document.getElementById("previewButton").remove();
        document.getElementById("preview").focus();
        document.getElementById("preview").scrollIntoView();

        window.scrollBy(0, - 2 * document.getElementById("navbar").offsetHeight);
    }
</script>
