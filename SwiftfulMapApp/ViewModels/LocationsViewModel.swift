//
//  LocationsViewModel.swift
//  SwiftfulMapApp
//
//  Created by Ian Tsai on 2024/6/19.
//  "ViewModels" folder connects frontend(view) to backend(model)

import Foundation
import MapKit
import SwiftUI

//with ObservableObject UI will update when changes are made
class LocationsViewModel: ObservableObject{
    //this "locations: [Location]" is the static type in LocationsDataService
    //"@Published" triggers update if value in this variable is changed
    //All loaded locations
    @Published var locations: [Location]
    
    //when we change the location, region will automatically be updated
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    @Published var mapRegion: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init(){
        //get the value of "locations" from LocationsDataService
        let locations = LocationsDataService.locations
        self.locations = locations
        // "!" unwraps content
        self.mapLocation = locations.first!
        self.updateMapRegion(location: mapLocation)
    }
    //update map region given location
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut){
            mapRegion = MapCameraPosition.region(MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan))
        }
    }
}
