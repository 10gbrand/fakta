﻿<!DOCTYPE html>
<html>

<head>
    <!-- skapad utifrån http://www.jessicaschillinger.us/2017/blog/print-repeating-header-browser/ -->
    <title>Planeringsunderlag försäljning</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>

    <!-- Leaflet -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.1/dist/leaflet.css" integrity="sha512-Rksm5RenBEKSKFjgI3a41vrjkw4EVPlJ3+OiI65vTjIdo9brlAacEuKOiQ5OFh7cOI1bkDwLqdLw3Zg0cRJAAQ=="
        crossorigin="" />
    <script src="https://unpkg.com/leaflet@1.3.1/dist/leaflet.js" integrity="sha512-/Nsx9X4HebavoBvEBuyp3I7od5tA0UzAxs+j83KgC8PU0kgB4XiK4Lfe4y4cgBtaRJQEIFCW+oC506aPT2L1zw=="
        crossorigin=""></script>

    <!-- Load Esri Leaflet from CDN.  it has no .css stylesheet of its own, only .js -->
    <script src="https://unpkg.com/esri-leaflet@2.0.4/dist/esri-leaflet.js"></script>

    <!-- Laddar proj4 -->
    <script src="https://unpkg.com/proj4@2.4.3"></script>
    <script src="https://unpkg.com/proj4leaflet@1.0.1"></script>



    <!-- 
    <script src="lib/leaflet.label.js"></script>
    <script type="text/javascript" src="Data/symbologi.json"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">
    -->

    <style type="text/css">
        #mapid {
            height: 800px;
        }

        .label {
            font-weight: 700;
            text-transform: uppercase;
            text-align: center;
            margin-top: -1em;
        }

        .label div {
            position: relative;
            left: -50%;
            text-shadow: 0px 2px 1px rgba(255, 255, 255, 0.85);
        }

        .map-marker {
            text-align: center;
            position: absolute;
            overflow: hidden;
            background-repeat: no-repeat;
            background-position: center;
            color: #fff;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            line-height: 22pt;
            font-size: 22px;
            font-family: 'sans-serif';
            
        }


        .map-marker.marker-color-fastighet-yl {
            background: white;
            color: black;
        }

        .map-marker.marker-color-byggnad {
            background: #55ff00;
        }

        .map-marker.marker-color-tomt {
            background: #734c00;
        }
        .map-marker.marker-color-tomt-yl {
            background: white;
            color: #734c00;
        }

        .map-marker.marker-color-belastning {
            background: #e69900 !important;
        }

        .map-marker.marker-color-belastning-yl {
            background: white;
            color: #e69900;
        }

        .map-marker.marker-color-rattighet {
            background: #00c5ff;
        }

        .map-marker.marker-color-rattighet-yl {
            background: white;
            color: #00c5ff;
        }
    </style>
</head>

<body>



    <div class="container">
        <div class="row pgaBreak" id="kartsida_3">
            <div class="col-12">
                <div class="jumbotron">
                    <div>
                        <img src="https://www.sveaskog.se/static/dist/img/sveaskog-logo.svg" alt="Sveaskog" style="padding:5px;" width="200px" align="left">
                    </div>
                    <div>
                        <h1 align="center">Planeringsunderlag försäljning</h1>
                        <p align="center">Sveaskog säljer Lorem ipsum dolor sit amet con <span class="step">1</span></p>
                    </div>
                </div>
                <div calss="row">
                    <div id="mapid"></div>
                </div>
                <div id="legend">
                    <h4 class="text-center">Legend </h4>
                    <svg height="200" width="100%">
                        <line x1="10" y1="10" x2="80" y2="10" style="stroke:greenyellow; stroke-width: 2; stroke-dasharray: 20, 5, 10, 5" />
                        <text x="90" y="15" style="font-family: sans-serif; font-size: 16px;">Belastning</text>
                    </svg>

                </div>
            </div>
        </div>

    </div>





    <script>

        //var overlatelseID = 142401;
        var overlatelseID = getQueryVariable("id");

        var crs = new L.Proj.CRS('EPSG:3006',
            '+proj=utm +zone=33 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
            {
                resolutions: [
                    8192, 4096, 2048, 1024, 512, 256, 128,
                    64, 32, 16, 8, 4, 2, 1, 0.5
                ],
                origin: [0, 0],
                bounds: L.bounds([218128.7031, 6126002.9379], [1083427.2970, 7692850.9468])
            }),
            map = new L.Map('mapid', {
                crs: crs,
            });

        map.setView([62.0, 15.0], 2);

        map.createPane('overlatelse');
        map.getPane('overlatelse').style.zIndex = 490;
        map.createPane('tomt');
        map.getPane('tomt').style.zIndex = 470;


        //----------------- OpenStreetMap ---------------------
        var osm = L.tileLayer('https://api.geosition.com/tile/osm-bright-3006/{z}/{x}/{y}.png', {
            maxZoom: 14,
            minZoom: 0,
            attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap contributors</a>, Imagery &copy; <a href="http://www.kartena.se/">Kartena</a>'
        }).addTo(map);

        //--------------------------------------------- Metria maps skarp ----------------------------
        var wmsMetriaBakgrundLayer = L.tileLayer.wms('https://kartportaltest.sveaskog.se/tokenproxy/metria/wms?', {
            layers: 'MetriaFastighetSkarp',
            //opacity : 0.25,
            maxZoom: 14
        });//.addTo(map);


        //----------------------------- ortofoto från Metria via tokenproxy ---------------------
        var wmsOrtoLayer = L.tileLayer.wms('https://kartportaltest.sveaskog.se/tokenproxy/metria/wms?', {
            layers: 'metria:orto_farg',
            //opacity : 0.25,
            maxZoom: 14
        });//.addTo(map);

        //----------------------------- Fastigheter från Metria via tokenproxy ---------------------
        var wmsFstLayer = L.tileLayer.wms('https://kartportaltest.sveaskog.se/tokenproxy/metria/wms?', {
            layers: 'metria:FastighetsytorGranser_FK',
            //opacity : 0.25,
            maxZoom: 14,
            transparent: true,
            format: 'image/png'
        });//.addTo(map);

        //----------------Fastighet från analysen----------------
        var fastighetYtaMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljning/MapServer/9',
            where: "OverlatelseID = " + overlatelseID,
            style: fastighetMapStyle(this),

        });//.addTo(map);

        var fastighetYtaLabels = {};

        fastighetYtaMapLayer.on('createfeature', function (e) {
            var id = e.feature.id;
            var feature = fastighetYtaMapLayer.getFeature(id);
            console.log(feature);
            console.log(feature.feature.properties.lopnummer);
            var center = feature.getBounds().getCenter();
            var label = L.marker(center, {
                icon: L.divIcon({
                    iconSize: null,
                    //position: 'relative',
                    //left: '-50%',
                    className: 'map-marker marker-color-fastighet-yl',
                    html: '<div>' + feature.feature.properties.lopnummer + '</div>'
                })
            }).addTo(map);
            fastighetYtaLabels[id] = label;
        });

        fastighetYtaMapLayer.on('addfeature', function (e) {
            var label = fastighetYtaLabels[e.feature.id];
            if (label) {
                label.addTo(map);
            }
        });

        fastighetYtaMapLayer.on('removefeature', function (e) {
            var label = fastighetYtaLabels[e.feature.id];
            if (label) {
                map.removeLayer(label);
            }
        });

        //---------------------------------- Överlåtelsen ------------------------------------
        var overlatelseMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljning/MapServer/8',
            where: "OverlatelseID = " + overlatelseID,
            style: overlatelseMapStyle(this),
            pane: 'overlatelse',
        }).addTo(map);


        // ------------------------- Avdelning -----------------------------
        var agoslagMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljningAvd/MapServer/1',
            where: "OverlatelseID = " + overlatelseID,
            style: agoslagMapStyle(this),
        });//.addTo(map);

        //---------------------------------- rättighet ------------------------------------
        //----------------rättighet Punkt-------------
        var rattighetPunktMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljning/MapServer/1',
            where: "OverlatelseID = " + overlatelseID,
            pointToLayer: function (geojson, latlng) {
                //console.log(latlng);
                //console.log(geojson);
                //console.log(geojson.properties);
                label = String(geojson.properties.lopnummer)
                return L.marker(latlng, {
                    icon: L.divIcon({
                        iconSize: null,
                        className: 'map-marker marker-color-rattighet',
                        html: '<div>' + label + '</div>'
                    })
                })
            },
        });//.addTo(map);

        //----------------rättighet Yta----------------
        var rattighetYtaMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljning/MapServer/7',
            where: "OverlatelseID = " + overlatelseID,
            style: rattighetMapStyle(this),

        });//.addTo(map);

        var rattighetYtaLabels = {};

        rattighetYtaMapLayer.on('createfeature', function (e) {
            var id = e.feature.id;
            var feature = rattighetYtaMapLayer.getFeature(id);
            console.log(feature);
            console.log(feature.feature.properties.lopnummer);
            var center = feature.getBounds().getCenter();
            var label = L.marker(center, {
                icon: L.divIcon({
                    iconSize: null,
                    //position: 'relative',
                    //left: '-50%',
                    className: 'map-marker marker-color-rattighet-yl',
                    html: '<div>' + feature.feature.properties.lopnummer + '</div>'
                })
            }).addTo(map);
            rattighetYtaLabels[id] = label;
        });

        rattighetYtaMapLayer.on('addfeature', function (e) {
            var label = rattighetYtaLabels[e.feature.id];
            if (label) {
                label.addTo(map);
            }
        });

        rattighetYtaMapLayer.on('removefeature', function (e) {
            var label = rattighetYtaLabels[e.feature.id];
            if (label) {
                map.removeLayer(label);
            }
        });

        //----------------rättighet Linje----------------
        var ratighetLinjeMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljning/MapServer/4',
            where: "OverlatelseID = " + overlatelseID,
            style: rattighetMapStyle(this),

        });//.addTo(map);

        var rattighetLinjeLabels = {};

        ratighetLinjeMapLayer.on('createfeature', function (e) {
            var id = e.feature.id;
            var feature = ratighetLinjeMapLayer.getFeature(id);
            console.log(feature);
            console.log(feature.feature.properties.lopnummer);
            var center = feature.getBounds().getCenter();
            var label = L.marker(center, {
                icon: L.divIcon({
                    iconSize: null,
                    //position: 'relative',
                    //left: '-50%',
                    className: 'map-marker marker-color-rattighet-yl',
                    html: '<div>' + feature.feature.properties.lopnummer + '</div>'
                })
            }).addTo(map);
            rattighetLinjeLabels[id] = label;
        });

        ratighetLinjeMapLayer.on('addfeature', function (e) {
            var label = rattighetLinjeLabels[e.feature.id];
            if (label) {
                label.addTo(map);
            }
        });

        ratighetLinjeMapLayer.on('removefeature', function (e) {
            var label = rattighetLinjeLabels[e.feature.id];
            if (label) {
                map.removeLayer(label);
            }
        });

        //---------------------------------- byggnad ------------------------------------
        //----------------byggnad Punkt-------------
        var byggnadPunktMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljning/MapServer/2',
            where: "OverlatelseID = " + overlatelseID,
            pointToLayer: function (geojson, latlng) {
                //console.log(latlng);
                //console.log(geojson);
                //console.log(geojson.properties);
                label = String(geojson.properties.lopnummer)
                return L.marker(latlng, {
                    icon: L.divIcon({
                        iconSize: null,
                        className: 'map-marker marker-color-byggnad',
                        html: '<div>' + label + '</div>'
                    })
                })
            },
        });//.addTo(map);

        //---------------------------------- belastning ------------------------------------
        //----------------belastning Punkt-------------
        var belastingPunktMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljning/MapServer/3',
            where: "OverlatelseID = " + overlatelseID,
            pointToLayer: function (geojson, latlng) {
                //console.log(latlng);
                //console.log(geojson);
                //console.log(geojson.properties);
                label = String(geojson.properties.lopnummer)
                return L.marker(latlng, {
                    icon: L.divIcon({
                        iconSize: null,
                        className: 'map-marker marker-color-belastning',
                        html: '<div>' + label + '</div>'
                        
                    })
                })
            },
        });//.addTo(map);

        //----------------belastning Yta----------------
        var belastningYtaMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljning/MapServer/10',
            where: "OverlatelseID = " + overlatelseID,
            style: belastningMapStyle(this),

        });//.addTo(map);

        var belsatningYtaLabels = {};

        belastningYtaMapLayer.on('createfeature', function (e) {
            var id = e.feature.id;
            var feature = belastningYtaMapLayer.getFeature(id);
            console.log(feature);
            console.log(feature.feature.properties.lopnummer);
            var center = feature.getBounds().getCenter();
            var label = L.marker(center, {
                icon: L.divIcon({
                    iconSize: null,
                    //position: 'relative',
                    //left: '-50%',
                    className: 'map-marker marker-color-belastning-yl',
                    html: '<div>' + feature.feature.properties.lopnummer + '</div>'
                })
            }).addTo(map);
            belsatningYtaLabels[id] = label;
        });

        belastningYtaMapLayer.on('addfeature', function (e) {
            var label = belsatningYtaLabels[e.feature.id];
            if (label) {
                label.addTo(map);
            }
        });

        belastningYtaMapLayer.on('removefeature', function (e) {
            var label = belsatningYtaLabels[e.feature.id];
            if (label) {
                map.removeLayer(label);
            }
        });


        //----------------belastning Linje----------------
        var belastningLinjeMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljning/MapServer/5',
            where: "OverlatelseID = " + overlatelseID,
            style: belastningMapStyle(this),

        });//.addTo(map);

        var belsatningYtaLabels = {};

        belastningLinjeMapLayer.on('createfeature', function (e) {
            var id = e.feature.id;
            var feature = belastningLinjeMapLayer.getFeature(id);
            console.log(feature);
            console.log(feature.feature.properties.lopnummer);
            var center = feature.getBounds().getCenter();
            var label = L.marker(center, {
                icon: L.divIcon({
                    iconSize: null,
                    className: 'map-marker marker-color-belastning-yl',
                    html: '<div>' + feature.feature.properties.lopnummer + '</div>'
                })
            }).addTo(map);
            belsatningYtaLabels[id] = label;
        });

        belastningLinjeMapLayer.on('addfeature', function (e) {
            var label = belsatningYtaLabels[e.feature.id];
            if (label) {
                label.addTo(map);
            }
        });

        belastningLinjeMapLayer.on('removefeature', function (e) {
            var label = belsatningYtaLabels[e.feature.id];
            if (label) {
                map.removeLayer(label);
            }
        });

        //---------------------------------- tomt ------------------------------------



        var tomtPunktMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljning/MapServer/0',
            where: "OverlatelseID = " + overlatelseID,
            pointToLayer: function (geojson, latlng) {
                //console.log(latlng);
                //console.log(geojson);
                //console.log(geojson.properties);
                label = String(geojson.properties.lopnummer)
                return L.marker(latlng, {
                    icon: L.divIcon({
                        iconSize: null,
                        className: 'map-marker marker-color-tomt',
                        html: '<div>' + label + '</div>'
                    })
                })
            },
        });//.addTo(map);

        var tomtYtaMapLayer = L.esri.featureLayer({
            url: 'https://karttjanstertest.sveaskog.se/agspublic/rest/services/SFS_Demo/UnderlagForForsaljning/MapServer/6',
            where: "OverlatelseID = " + overlatelseID,
            style: tomtMapStyle(this),
            pane: 'tomt',
        });//.addTo(map);

        var tomtYtaLabels = {};

        tomtYtaMapLayer.on('createfeature', function (e) {
            var id = e.feature.id;
            var feature = tomtYtaMapLayer.getFeature(id);
            console.log(feature);
            console.log(feature.feature.properties.lopnummer);
            var center = feature.getBounds().getCenter();
            var label = L.marker(center, {
                icon: L.divIcon({
                    iconSize: null,
                    className: 'map-marker marker-color-tomt-yl',
                    html: '<div>' + feature.feature.properties.lopnummer + '</div>'
                })
            }).addTo(map);
            tomtYtaLabels[id] = label;
        });

        tomtYtaMapLayer.on('addfeature', function (e) {
            var label = tomtYtaLabels[e.feature.id];
            if (label) {
                label.addTo(map);
            }
        });

        tomtYtaMapLayer.on('removefeature', function (e) {
            var label = tomtYtaLabels[e.feature.id];
            if (label) {
                map.removeLayer(label);
            }
        });


        //------------------Zoomar till Övarlåtelsen----------------

        overlatelseMapLayer.once("load", function (evt) {
            // create a new empty Leaflet bounds object
            var bounds = L.latLngBounds([]);
            // loop through the features returned by the server
            overlatelseMapLayer.eachFeature(function (layer) {
                // get the bounds of an individual feature
                var layerBounds = layer.getBounds();
                // extend the bounds of the collection to fit the bounds of the new feature
                bounds.extend(layerBounds);
            });
            // once we've looped through all the features, zoom the map to the extent of the collection
            map.fitBounds(bounds);
        });

        //----------------------------------------- Skapar lagergrupper ------------------------
        var ortoLayerGroup = L.layerGroup([wmsOrtoLayer]);//.addTo(map);

        var avdLayerGroup = L.layerGroup([agoslagMapLayer]);//.addTo(map);
        var fastgransLayerGroup = L.layerGroup([wmsFstLayer, fastighetYtaMapLayer]);
        var tomtLayerGroup = L.layerGroup([tomtPunktMapLayer, tomtYtaMapLayer]);//.addTo(map);
        var belastningLayerGroup = L.layerGroup([belastningYtaMapLayer, belastingPunktMapLayer, belastningLinjeMapLayer]);//.addTo(map);
        var overlatelseLayerGroup = L.layerGroup([overlatelseMapLayer]).addTo(map);
        var rattighetLayerGroup = L.layerGroup([rattighetPunktMapLayer, ratighetLinjeMapLayer, rattighetYtaMapLayer]);//.addTo(map);
        var byggnadLayerGroup = L.layerGroup([byggnadPunktMapLayer]);//.addTo(map);

        var overlayMaps = {
            "Överltelse": overlatelseLayerGroup,
            "Avdelningar": avdLayerGroup,
            "Fastighetsgräns": fastgransLayerGroup,
            "Belastningar": belastningLayerGroup,
            "Rättighet": rattighetLayerGroup,
            "Tomt": tomtLayerGroup,
            "Byggnad": byggnadLayerGroup,

        };


        var baseMaps = {
            "Open Street Map": osm,
            "Bakgrund": wmsMetriaBakgrundLayer,
            "Orto": wmsOrtoLayer
        };

        L.control.layers(baseMaps, overlayMaps).addTo(map);
        L.control.scale({
            imperial: false
        }).addTo(map);



        //----------------------- Popup med koordinater vid klick i kartan ---------------------------
        var popup = L.popup();
        function onMapClick(e) {
            var swerefproj = "+proj=utm +zone=33 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs";
            var swerefcoords = proj4(swerefproj, [e.latlng.lng, e.latlng.lat]);
            console.log(swerefcoords);
            console.log(e.latlng);
            console.log(swerefcoords[1]);
            popup
                .setLatLng(e.latlng)
                .setContent("X: " + swerefcoords[0].toString().substring(0, 6) + '<br/>' + "Y: " + swerefcoords[1].toString().substring(0, 6))
                .openOn(map);
        };
        map.on('click', onMapClick);

        //------------------------------Funktioner för att sätta mapstyle för olika lager-------------------------
        function fastighetMapStyle(feature, fillcolor) {
            //console.log('hej')
            return {
                fillColor: null,
                weight: 3,
                opacity: 1,
                color: 'black',
                dashArray: 10,
                fillOpacity: 0.0
            }
        }

        function overlatelseMapStyle(feature, fillcolor) {
            //console.log('hej')
            return {
                fillColor: null,
                weight: 5,
                opacity: 1,
                color: 'purple',
                dashArray: 10,
                fillOpacity: 0.0
            }
        }

        function agoslagMapStyle(feature, fillcolor) {
            //console.log('hej')
            return {
                fillColor: null,
                weight: 1,
                opacity: 1,
                color: 'black',
                dashArray: 3,
                fillOpacity: 0.0
            }
        }

        function rattighetMapStyle(feature, fillcolor) {
            //console.log('hej')
            return {

                fillColor: '#00c5ff',
                weight: 3,
                opacity: 1,
                color: '#00c5ff',
                dashArray: 3,
                fillOpacity: 0.5
            }
        }

        function belastningMapStyle(feature, fillcolor) {
            //console.log('hej')
            return {

                fillColor: '#e69900',
                weight: 3,
                opacity: 1,
                color: '#e69900',
                dashArray: 3,
                fillOpacity: 0.5
            }
        }

        function tomtMapStyle(feature, fillcolor) {
            //console.log('hej')
            return {
                fillColor: '#734c00',
                weight: 3,
                opacity: 1,
                color: '#734c00',
                dashArray: 3,
                fillOpacity: 0.5
            }
        }

        //-------------------- olika ikoner -------------------------------------
        var tomtIcon = L.icon({
            iconUrl: 'src/arrow-down.svg',
            iconSize: [40, 40],
            iconAnchor: [20, 40],
            //popupAnchor: [-3, -76],
            //shadowUrl: 'my-icon-shadow.png',
            //shadowSize: [68, 95],
            //shadowAnchor: [22, 94],
            //html: "<span style='color:blue;'>textToDisplay</span>",
        })

        //---------------------- Hämtar överlåtelseid från url parameter eller uppmanar användare att ange id -------------------------------
        function getQueryVariable(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split("&");
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split("=");
                if (pair[0] == variable) { return pair[1]; }
            }
            return (false);
        }
    </script>
</body>

</html>