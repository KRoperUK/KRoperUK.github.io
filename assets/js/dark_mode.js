document.addEventListener('DOMContentLoaded', function() {
    const mode_toggle = document.getElementById("light-toggle");

    mode_toggle.addEventListener("click", function() {
        toggleTheme(localStorage.getItem("theme"));
        
        const event = new Event('itemInserted');
        event.key = "theme";
        event.value = localStorage.getItem("theme");
        document.dispatchEvent(event);
    });
});

