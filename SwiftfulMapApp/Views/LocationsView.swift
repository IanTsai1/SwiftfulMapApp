//
//  LocationsView.swift
//  SwiftfulMapApp
//
//  Created by Ian Tsai on 2024/6/19.
// "Views" folder stores the UI; things we can "view"

import SwiftUI
import MapKit

struct LocationsView: View {
    //pull from enviorment instead of making new instance
    //since we set "LocationsView" for access to data, we can just access it here
    @EnvironmentObject private var vm: LocationsViewModel

    var body: some View {
        //zstack creates layers on z axis(front-to-back order)
        ZStack {
            Map(position: $vm.mapRegion).ignoresSafeArea()
            
            VStack(spacing: 0){
                header
                    .padding()
                
                Spacer()
                
                ZStack{
                    ForEach(vm.locations){location in
                        if(vm.mapLocation==location){
                            LocationPreviewView(location: location)
                                .shadow(color:Color.black.opacity(0.3), radius: 20)
                                .padding()
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                    }
                }
            }
        }
    }
}

//preview is a tool to quickly visualize and test UI
//preview runs in a sandbox enviorment sepearte from enviorment so we need to explicity provide code to mimic actual environment
struct LocationsView_Previews: PreviewProvider{
    static var previews: some View{
        //when we call LocationsView here it doesn't have the enviorment setup(as its in sandbox), so we hv to manually inject LocationsViewModel() like what we did in "SwiftulMapAppApp"
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

//this is still part of LocationsView but allow our "body" be more readable/clean
extension LocationsView{
    //variable for a header with all needed settings
    private var header: some View {
        //display text inside with properties and apply modifiers
        //VStack = Vertical Stack; vertical alignment
        VStack {
            //button that will change showLocationList value through function call when clicked/"action"
            Button(action: vm.toggleLocationsList){
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading){
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                }
            }
            
            if(vm.showLocationsList==true){
                LocationsListView()
            }
                
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 15)
    }
}
