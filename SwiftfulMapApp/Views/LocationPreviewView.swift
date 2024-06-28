//
//  LocationPreviewView.swift
//  SwiftfulMapApp
//
//  Created by Ian Tsai on 2024/6/27.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    var body: some View {
        //HStack is for horizontal view ("H" = horizontal)
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16.0){
                imageSection
                titleSection
            }
            
            VStack(spacing: 8.0){
                learnMore
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

#Preview {
    //get first location from LocationsDataService locations
    ZStack{
        Color.green.ignoresSafeArea()
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding()
    }
    .environmentObject(LocationsViewModel())
   
}
//keep big/general structure in main and put sub stack in extension
//"some View" is used to return a type that has a View since all of these variables are UI that should be viewed
extension LocationPreviewView{
    private var imageSection: some View{
        ZStack{
            //will only set imageName to its value if location.imageNames is not empty
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width:100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 4){
            Text(location.name).font(.title2).fontWeight(.bold)
            Text(location.cityName).font(.subheadline)
        }
        //need "." if the value is a keyword
        .frame(maxWidth: .infinity, alignment: .leading)
        
        
        
    }
    
    private var learnMore: some View{
        Button{
            
        } label:{
            Text("learn more")
                .font(.headline)
                .frame(width: 125, height:35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button{
            vm.nextButtonPressed()
        }label:{
            Text("next")
                .font(.subheadline)
                .frame(width: 125, height:35)
        }
        .buttonStyle(.bordered)
    }
}
