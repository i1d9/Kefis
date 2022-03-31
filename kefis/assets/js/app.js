// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "./vendor/some-package.js"
//
// Alternatively, you can `npm install some-package` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"

import 'bootstrap'; // Bootstrap support
import "jquery";

import "../node_modules/smooth-scroll";

import "./custom";


// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"

import './leaflet/leaflet-map';
import './leaflet/leaflet-marker'
import './leaflet/leaflet-icon'




let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
let Hooks = {}



Hooks.LeafLetAdminMapComponent = {
    mounted() {
        this.el.addEventListener("click", e => {
            var x = e.layerX;
            var y = e.layerY;

            // calculate point in xy space
            var pointXY = L.point(x, y);
            //console.log(e);

            console.log(window.clicked_pos);
            // convert to lat/lng space
            var pointlatlng = window.map.layerPointToLatLng(pointXY);
            console.log(pointlatlng);
            window.map_component_marker.setLatLng(window.clicked_pos);

            var popup = L.popup()
                .setLatLng(window.clicked_pos)
                .setContent('<p><center>Here</center></p>')
                .openOn(window.map);
            window.map.panTo(window.clicked_pos);
            //Send the coordinates to the map_component using map_component_coordinates event
            this.pushEventTo(this.el, "map_component_coordinates", { lat: window.clicked_pos.lat, lng: window.clicked_pos.lng });
            // why doesn't this match e.latlng?
            //console.log("Point in lat,lng space: " + pointlatlng);
        });
    }
}

let liveSocket = new LiveSocket("/live", Socket, { hooks: Hooks, params: { _csrf_token: csrfToken } })

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

import "./custom.js";


const swalWithBootstrapButtons = Swal.mixin({
    customClass: {
        confirmButton: 'btn btn-primary',
        cancelButton: 'btn btn-gray'
    },
    buttonsStyling: false
});

function display_modal(params) {

    document.getElementById('flashButton').addEventListener('click', function () {
        swalWithBootstrapButtons.fire({
            icon: params.icon,
            title: params.title,
            text: params.message,
            showConfirmButton: true,
        })
    });
    document.getElementById('flashButton').click();
}
window.display_modal = display_modal;


