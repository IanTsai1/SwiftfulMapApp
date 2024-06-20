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
        //zstack creates layers
        ZStack {
            Map(position: $vm.mapRegion)
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
