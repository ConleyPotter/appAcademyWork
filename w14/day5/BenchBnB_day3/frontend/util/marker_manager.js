/* eslint-disable constructor-super */
/* eslint-disable no-this-before-super */
import React from 'react'

class MarkerManager extends React.Component {
  constructor (map) {
    super({})
    this.map = map
    this.markers = {}
    this.createMarkerFromBench = this.createMarkerFromBench.bind(this)
    this.updateMarkers = this.updateMarkers.bind(this)

  }

  
  createMarkerFromBench (bench) {
    const { description, lat, lng } = bench 
    const myLatLang = new google.maps.LatLng(lat, lng)
    const marker = new google.maps.Marker({ 
      position: myLatLang,
      map: this.map,
      title: description 
    })
    marker.setMap(this.map)
  }

  updateMarkers (benches) {
    return benches.map((bench) => this.createMarkerFromBench(bench))
  }
}

export default MarkerManager
