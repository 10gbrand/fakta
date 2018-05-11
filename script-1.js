// Our labels along the x-axis
var ägoslag = ['Skogsmark','Myr','Berg','Vatten','Åker','Övrigt'];
// For drawing the lines
var areal = [533,112,33,74,3,12];
var volym = [12707,0,0,0,0,0];


var ctx = document.getElementById("agoslagChart");
var myChart = new Chart(ctx, {
//   type: 'bar',
  type: 'horizontalBar',
  data: {
    labels: ägoslag,
    datasets: [
      { 
        data: areal,
        label: "Areal"
      }
    ]

  }
});


// leaflet map

// initialize the map
//   var map = L.map('map').setView([42.35, -71.08], 13);

  // load a tile layer
//   L.tileLayer('http://tiles.mapc.org/basemap/{z}/{x}/{y}.png',
//     {
//       attribution: 'Tiles by <a href="http://mapc.org">MAPC</a>, Data by <a href="http://mass.gov/mgis">MassGIS</a>',
//       maxZoom: 17,
//       minZoom: 9
//     }).addTo(map);