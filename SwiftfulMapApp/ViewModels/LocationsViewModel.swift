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
    
    //when we change the location, region will automatically be updated by calling the func
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    //current region on map
    @Published var mapRegion: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //show list of locations(give a boolean so it will show vs not show)
    @Published var showLocationsList: Bool = false
    
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
    
    public func toggleLocationsList(){
        withAnimation(.easeInOut){
            showLocationsList = !showLocationsList
        }
    }
    
    public func showNextLocation(location: Location){
        withAnimation(.easeInOut){
            mapLocation = location
            
        }
    }
    
    public func nextButtonPressed(){
        //get current index; might be optional if it doesn't exist
        guard let currIndex = locations.firstIndex(where: {$0==mapLocation}) else{
            print("couldn't find the curr index")
            return
        }
        //check if currIndex is valid
        let newIndex = (currIndex+1)%locations.count
        let nextLocation = locations[newIndex]
        showNextLocation(location: nextLocation)
        
        
    }
}
