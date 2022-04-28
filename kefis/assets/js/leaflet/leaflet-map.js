import L from 'leaflet'

const template = document.createElement('template');
template.innerHTML = `


<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A==" crossorigin="" />
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js" integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA==" crossorigin=""></script>

    <div style="height: 250px; z-index: 0;" class="kmksmlask">
        <slot />
    </div>
`

class LeafletMap extends HTMLElement {
    constructor() {
        super();

        this.attachShadow({ mode: 'open' });
        this.shadowRoot.appendChild(template.content.cloneNode(true));
        this.mapElement = this.shadowRoot.querySelector('div')

        this.map = L.map(this.mapElement).setView([this.getAttribute('lat'), this.getAttribute('lng')], 13);

        let zoom = this.getAttribute('zoom');
        console.log(this.getAttribute('zoom'));

        window.map = this.map;
        this.map.setZoom(zoom);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            
            

        }).addTo(this.map);

        this.map.on("click", (e) => {

            window.clicked_pos = e.latlng;
            //console.log("Map Click Event", e.latlng);
        });


        this.defaultIcon = L.icon({
            iconUrl: '/images/elixir-icon.png',
            iconSize: [64, 64],
        });
    }

    connectedCallback() {
        const markerElements = this.querySelectorAll('leaflet-marker');
        markerElements.forEach(markerEl => {

            const lat = markerEl.getAttribute('lat')
            const lng = markerEl.getAttribute('lng')
            const leafletMarker = L.marker([lat, lng], { icon: this.defaultIcon }).addTo(this.map);
            leafletMarker.addEventListener('click', (_event) => {
                markerEl.click()
            });



            window[`${markerEl.getAttribute('marker-id')}`] = leafletMarker;
            const iconEl = markerEl.querySelector('leaflet-icon');
            const iconSize = [iconEl.getAttribute('width'), iconEl.getAttribute('height')]

            iconEl.addEventListener('url-updated', (e) => {
                leafletMarker.setIcon(L.icon({
                    iconUrl: e.detail,
                    iconSize: iconSize,
                    iconAnchor: iconSize
                }));

            });
        });


    }
}

window.customElements.define('leaflet-map', LeafletMap);