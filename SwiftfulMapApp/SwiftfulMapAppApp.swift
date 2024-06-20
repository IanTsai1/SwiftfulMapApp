//
//  SwiftfulMapAppApp.swift
//  SwiftfulMapApp
//
//  Created by Ian Tsai on 2024/6/19.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    
    //assigning variable "LocationsViewModel()" class
    //"@StateObject" is used for instance of stateful class with "ObservableObject"
    @StateObject private var vm = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            //LocationsView() contains UI; Everything in "Views" folder is for UI
            //enviorment object allows sharing and access of data across diff. view
            //anything in this LocationsView() or child of it will have reference to "vm"
            LocationsView()
                .environmentObject(vm)
        }
    }
}
