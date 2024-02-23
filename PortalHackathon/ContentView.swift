//
//  ContentView.swift
//  PortalHackathon
//
//  Created by Ella Goode on 2/23/24.
//

import SwiftUI
import MapKit

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Museum {
    let name: String
    let location: String
    // You can add more properties such as coordinates, images, etc.
}

// Sample data for different locations
let museums: [Museum] = [
    Museum(name: "name 1", location: "Description of name 1"),
    Museum(name: "name 2", location: "Description of name 2"),
    // Add more locations as needed
]

struct ContentView: View {
    var body: some View {
        NavigationStack{
            ZStack {
                // Background image
                Image("WorldMapv1") // Replace "background_image" with the name of your image file
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                // Other views overlaying the background
                
                VStack {
                    Spacer() // Pushes the text to the top
                    Text("Portal")
                        .font(.largeTitle) // Set the font size
                        .foregroundColor(.white) // Set the text color
                        .padding(.top, 30)
                    Spacer(minLength: 1000)
                    
                    
                }
                NavigationLink(destination: SecondView()) {
                    Image(systemName: "building.columns")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .position(x: 230, y:500)
                }
                Text("Smithsonian Museum of Art, Washington D.C.")
                    .foregroundColor(.white)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .padding(5)
                    .background(Color.black)
                    .cornerRadius(5)
                    .opacity(0.7) // Adjust the opacity as needed
                    .position(x: 230, y:540)
            }
        }
        .navigationTitle("MapView")
    }
}

struct SecondView: View {
    var body: some View {
        Text("Second View")
            .navigationTitle("Second View")
    }
}

struct MuseumDetail: View {
    let museum: Museum
    
    var body: some View {
        VStack {
            Text(museum.name)
                .font(.title)
                .padding()
            Text(museum.location)
                .padding()
            // You can add more information here such as images, maps, etc.
            Spacer()
        }
        .navigationTitle(museum.name)
    }
}

