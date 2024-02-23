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

struct Location {
    let name: String
    let description: String
    // You can add more properties such as coordinates, images, etc.
}

// Sample data for different locations
let locations: [Location] = [
    Location(name: "Location 1", description: "Description of Location 1"),
    Location(name: "Location 2", description: "Description of Location 2"),
    // Add more locations as needed
]

struct ContentView: View {
    var body: some View {
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
            
            Button(action: {
                // Action to perform when the button is tapped
                print("Button tapped!")
                
            }) {
                // Content of the button
                Text("Tap Me")
                    .font(.title) // Set the font size
                    .foregroundColor(.white) // Set text color
                    .padding() // Add padding around the text
                    .background(Color.purple) // Set background color
                    .cornerRadius(10) // Add rounded corners
                }
                .help("This is a place!")
            }
            ZStack {
                Text("This is a permanent tooltip")
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding(5)
                    .background(Color.black)
                    .cornerRadius(5)
                    .opacity(0.7) // Adjust the opacity as needed
                    .offset(x: 0, y: 480) // Adjust the position relative to the button
            }
        }
    }
}

struct LocationDetail: View {
    let location: Location
    
    var body: some View {
        VStack {
            Text(location.name)
                .font(.title)
                .padding()
            Text(location.description)
                .padding()
            // You can add more information here such as images, maps, etc.
            Spacer()
        }
        .navigationTitle(location.name)
    }
}

