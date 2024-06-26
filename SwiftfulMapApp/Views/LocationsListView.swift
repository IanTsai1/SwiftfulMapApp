//
//  LocationsListView.swift
//  SwiftfulMapApp
//
//  Created by Ian Tsai on 2024/6/25.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List{
            ForEach(vm.locations){ location in
                    //need to specify type
                    Button{
                        vm.showNextLocation(location: location)
                    } label: {
                        listRowView(location: location)
                    }
                    .padding(.vertical,4)
                    .listRowBackground(Color.clear)
                }
        }
        .listStyle(PlainListStyle())
    }
}


#Preview {
    LocationsListView().environmentObject(LocationsViewModel())
}

extension LocationsListView{
    // "-> some View" gives return
    private func listRowView(location: Location) -> some View{
        HStack{
            //access image by imageNames
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width:45, height:45)
                    .cornerRadius(10)
            }
        
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            } //all the same width
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
    
}
