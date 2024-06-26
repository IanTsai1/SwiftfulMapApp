//
//  Location.swift
//  SwiftfulMapApp
//
//  Created by Ian Tsai on 2024/6/19.
// "Models" folder store the backend code

import Foundation
import MapKit

//need id variable(Identifiable) so we can identify unique object
//Equatable to check if two or more "Location" is the same
struct Location: Identifiable, Equatable{
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    //identifiable
    var id: String{
        name+cityName
    }
    //equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
