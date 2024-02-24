//
//  ContentView.swift
//  PortalHackathon
//
//  Created by Ella Goode on 2/23/24.
//

import SwiftUI
import Foundation
import URLImage
import MapKit
import UIKit
import AVFoundation
import AVKit

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
                Image("WorldMapv2") // Replace "background_image" with the name of your image file
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                // Other views overlaying the background
                
                VStack {
                    
                    HStack {
                        Spacer()
                        Text("P")
                            .font(.custom("Futura", size: 100))
                            .foregroundColor(.white)
                            .padding(.top, 30)
                        Image(systemName: "door.left.hand.open")
                            .resizable()
                            .frame(width:50, height: 80)
                            .padding(.top, 30)
                            .colorInvert()
                        Text("rtal")
                            .font(.custom("Futura", size:100))
                            .foregroundColor(.white)
                            .padding(.top, 30)
                        Spacer()
                    }
                    Spacer()
                    
                    
                }
                /*NavigationLink(destination: SecondView(cultureVal: "American")) {
                    Image(systemName: "building.columns")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .position(x: 230, y:500)
                }
                
                NavigationLink(destination: SecondView(cultureVal: "French")) {
                    Image(systemName: "building.columns")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .position(x: 500, y:600)
                }
                NavigationLink(destination: SecondView(cultureVal: "Japanese")) {
                    Image(systemName: "building.columns")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .position(x: 450, y:480)
                }*/
                NavigationLink(destination: SecondView(cultureVal: "American")) {
                    Image(systemName: "building.columns")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                    }
                    .position(x: 240, y: 500) // Adjust as needed
                                    
                // Nav to second view ( France )
                NavigationLink(destination: SecondView(cultureVal: "French")) {
                    Image(systemName: "building.columns")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                    }
                    .position(x: 440, y: 480)
                                    
                                    // nav to third view ( Japan )
                                    
                NavigationLink(destination: SecondView(cultureVal: "Japanese")) {
                    Image(systemName: "building.columns")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                    }
                    .position(x: 770, y: 500)
                                
                NavigationLink(destination: VideoView()) {
                    Image(systemName: "door.left.hand.open") // Placeholder for a door opening to the left
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                    }
                    .offset(x: -30 , y: 20) // Adjust offset here for positioning
                    .padding(.bottom, 50) // Padding to ensure it's within the safe area
                                    
                NavigationLink(destination: SecVideoView()) {
                    Image(systemName: "door.left.hand.open") // Placeholder for a door opening to the left
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                    }
                    .offset(x: 350 , y: 150) // Adjust offset here for positioning
                    .padding(.bottom, 50) // Padding to ensure it's within the safe area
                                    
                NavigationLink(destination: ThirdVideoView()) {
                    Image(systemName: "door.left.hand.open") // Placeholder for a door opening to the left
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                    }
                    .offset(x: -250 , y: 9) // Adjust offset here for positioning
                    .padding(.bottom, 50) // Padding to ensure it's within the safe area
                
                Text("Washington D.C.")
                    .foregroundColor(.white)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(5)
                    .background(Color.black)
                    .cornerRadius(5)
                    .opacity(0.7)
                    .position(x: 230, y: 460)
                
                VStack {
                    Spacer()
                    HStack{
                        Text("Select a ")
                            .font(.custom("Futura", size:40))
                            .colorInvert()
                        Image(systemName: "building.columns")
                            .resizable()
                            .frame(width:60, height:60)
                            .colorInvert()
                        Text(" to view art from that country")
                            .font(.custom("Futura", size:40))
                            .colorInvert()
                    }
                    HStack {
                        Text("Select a ")
                            .font(.custom("Futura", size:40))
                            .colorInvert()
                        Image(systemName: "door.left.hand.open")
                            .resizable()
                            .frame(width:37.5, height:60)
                            .colorInvert()
                        Text(" to call a Portal in that country")
                            .font(.custom("Futura", size:40))
                            .colorInvert()
                    }
                    .padding(.bottom, 40)
                }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        
    }

struct FirstView: View {
    var body: some View {
        Text("First View")
            .navigationTitle("First View")
    }
}

struct ThirdView: View {
    var body: some View {
        Text("Third View")
            .navigationTitle("Third View")
    }
}


struct VideoView: View {
    // Create the AVPlayer instance with the video URL
    private let player = AVPlayer(url: Bundle.main.url(forResource: "America", withExtension: "mp4")!)

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                // Play the video automatically when the view appears
                player.play()
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("First Portal View")
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
struct SecondView: View {
    @State private var paintings: [Painting] = []
    @State private var isLoading = false
    @State private var currentPage = 0
    
    let cultureVal: String
    
    var body: some View {
            NavigationStack {
                VStack {
                    if isLoading {
                        ProgressView()
                    } else {
                        TabView(selection: $currentPage) {
                            ForEach(paintings, id: \.self) { painting in
                                pageView(for: painting)
                                    .tag(painting.imageUrl) // Use painting's imageUrl as tag for selection
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
                .navigationTitle("Art Gallery")
                .onAppear {
                    // Start loading indicator
                    isLoading = true
                    fetchArt(culture: cultureVal, myKey: "6c461233-f25c-46f0-89a0-8b565588d5b7", baseURL: "https://api.harvardartmuseums.org") { paintings, error in
                        if let error = error {
                            print("Error: \(error)")
                            return
                        }
                        
                        if let paintings = paintings {
                            self.paintings = paintings
                        }
                        
                        // Stop loading indicator
                        isLoading = false
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
        }
    
    func pageView(for painting: Painting) -> some View {
        ScrollView {
            VStack(alignment: .center) {
                URLImage(URL(string: painting.imageUrl)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 600, height: 600)
                .padding(.top, 50)
                
                Text(painting.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Artist: \(painting.artistName)")
                Text("Year of Creation: \(painting.yearOfCreation == 0 ? "Unknown" : "\(painting.yearOfCreation)")")
            }
        }
    }
}

struct CustomBackButton: View {
    var body: some View {
        NavigationStack {
            NavigationLink (destination: ContentView()) {
                Image(systemName: "arrowshape.backward.circle")
                    .foregroundColor(Color(hex: 0x9A8C98))
                    .font(.system(size:50))
                    .padding(.top, 50)
                    .padding(.leading, 10)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xff) / 255.0
        let green = Double((hex >> 8) & 0xff) / 255.0
        let blue = Double(hex & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue)
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

struct Painting: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageUrl: String
    let artistName: String // New property for artist's name
    let yearOfCreation: Int // New property for year of creation
}

func fetchArt(culture: String, myKey: String, baseURL: String, completion: @escaping ([Painting]?, Error?) -> Void) {
    // Define the endpoint for retrieving random objects
    let endpoint = "/object"

    // Define the query parameters for the API request
    let queryParams = [
        "apikey": myKey,
        "size": "20", // Specify the number of random paintings to retrieve
        "sort": "random", // Sort the results randomly
        "fields": "title,primaryimageurl,people,datebegin",
    ]

    // Create the URL components
    var urlComponents = URLComponents(string: baseURL + endpoint)!
    urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }

    // Create a URL object from the URL components
    guard let url = urlComponents.url else {
        completion(nil, NSError(domain: "InvalidURL", code: -1, userInfo: nil))
        return
    }

    // Create an array to store the paintings
    var paintings = [Painting]()

    // Create a URLSession object
    let session = URLSession.shared

    // Create a data task with the URLSession to fetch data from the URL
    let task = session.dataTask(with: url) { data, response, error in
        // Check for errors
        if let error = error {
            completion(nil, error)
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            completion(nil, NSError(domain: "InvalidResponse", code: -1, userInfo: nil))
            return
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            completion(nil, NSError(domain: "InvalidResponse", code: -1, userInfo: nil))
            return
        }

        guard let responseData = data else {
            completion(nil, NSError(domain: "NoData", code: -1, userInfo: nil))
            return
        }

        do {
            let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
            
            print(json as Any)
            if let records = json?["records"] as? [[String: Any]] {
                var paintings = [Painting]()
                for record in records {
                    if let people = record["people"] as? [[String: Any]],
                       let person = people.first,
                       let cultureVal = person["culture"] as? String,
                       cultureVal == culture,
                       let title = record["title"] as? String,
                       let imageUrl = record["primaryimageurl"] as? String,
                       let name = person["name"] as? String,
                       let dateBegin = record["datebegin"] as? Int {
                            print(cultureVal + title + name + String(dateBegin))
                            let painting = Painting(title: title, imageUrl: imageUrl, artistName: name, yearOfCreation: dateBegin)
                            paintings.append(painting)
                    }
                }
                completion(paintings, nil)
            } else {
                completion(nil, NSError(domain: "InvalidResponse", code: -1, userInfo: nil))
            }
        } catch {
            completion(nil, error)
        }
    }


    // Start the data task
    task.resume()
}
