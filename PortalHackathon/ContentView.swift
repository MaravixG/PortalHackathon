//
//  ContentView.swift
//  PortalHackathon
//
//  Created by Ella Goode on 2/23/24.
//

import SwiftUI
import MapKit

// Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Location Struct
struct Location {
    let name: String
    let description: String
    // Additional properties can be added here.
}

// Sample Data
let locations: [Location] = [
    Location(name: "Location 1", description: "Description of Location 1"),
    Location(name: "Location 2", description: "Description of Location 2"),
    // More locations can be added as needed.
]

// Main Content View
struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("WorldMapv1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                //
                VStack {
                    Spacer()
                    Text("Portal")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                    Spacer()
                    
                    // Navigation to SecondView
                    NavigationLink(destination: SecondView()) {
                        Image(systemName: "building.columns")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                    }
                    .position(x: 230, y: 410) // Adjust as needed
                    
                    NavigationLink(destination: VideoView()) {
                        Image(systemName: "door.left.hand.open") // Placeholder for a door opening to the left
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                    }
                    .offset(x: -30 , y: -279) // Adjust offset here for positioning
                    .padding(.bottom, 50) // Padding to ensure it's within the safe area
                    
                    NavigationLink(destination: SecVideoView()) {
                        Image(systemName: "door.left.hand.open") // Placeholder for a door opening to the left
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                    }
                    .offset(x: 0 , y: -475) // Adjust offset here for positioning
                    .padding(.bottom, 50) // Padding to ensure it's within the safe area
                    
                    NavigationLink(destination: ThirdVideoView()) {
                        Image(systemName: "door.left.hand.open") // Placeholder for a door opening to the left
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                    }
                    .offset(x: -250 , y: -500) // Adjust offset here for positioning
                    .padding(.bottom, 50) // Padding to ensure it's within the safe area
                }
                
                Text("Smithsonian Museum of Art, Washington D.C.")
                    .foregroundColor(.white)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(5)
                    .background(Color.black)
                    .cornerRadius(5)
                    .opacity(0.7)
                    .position(x: 230, y: 460)
            }
        }
        .navigationTitle("MapView")
    }
}

// Second View
struct SecondView: View {
    var body: some View {
        Text("Second View")
            .navigationTitle("Second View")
    }
}

// Third View
struct VideoView: View {
    var body: some View {
        Text("Welcome to the portal 1")
            .navigationTitle("First portal View")
    }
}

struct SecVideoView: View {
    var body: some View {
        Text("Welcome to the portal 2")
            .navigationTitle("Secnd  portal View")
    }
}

struct ThirdVideoView: View {
    var body: some View {
        Text("Welcome to the portal 3")
            .navigationTitle("Third portal View")
    }
}

struct FourthVideoView: View {
    var body: some View {
        Text("Welcome to the portal 4")
            .navigationTitle("Fourth portal View")
    }
}



// Location Detail View
struct LocationDetail: View {
    let location: Location
    
    var body: some View {
        VStack {
            Text(location.name)
                .font(.title)
                .padding()
            Text(location.description)
                .padding()
            Spacer()
        }
        .navigationTitle(location.name)
    }
}
