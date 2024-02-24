//
//  ContentView.swift
//  PortalHackathon
//
//  Created by Ella Goode on 2/23/24.
//

import SwiftUI
import Foundation
import URLImage

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
                Button("press for art") {
                    fetchArt(myKey: "6c461233-f25c-46f0-89a0-8b565588d5b7", baseURL: "https://api.harvardartmuseums.org") { paintings, error in
                        if let error = error {
                            print("Error: \(error)")
                            return
                        }

                        if let paintings = paintings {
                            for painting in paintings {
                                print("Title: \(painting.title), Image URL: \(painting.imageUrl)")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("MapView")
    }
}

struct SecondView: View {
    @State private var paintings: [Painting] = []
    @State private var isLoading = false // Add a state variable to track loading state
    @State private var currentPage = 0 // Track the current page
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Press for Art") {
                    // Start loading indicator
                    isLoading = true
                    fetchArt(myKey: "6c461233-f25c-46f0-89a0-8b565588d5b7", baseURL: "https://api.harvardartmuseums.org") { paintings, error in
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
                .padding()
                
                if isLoading {
                    ProgressView() // Show loading indicator if data is being fetched
                } else {
                    TabView(selection: $currentPage) {
                        ForEach(paintings, id: \.self) { painting in
                            pageView(for: painting)
                                .tag(painting.id) // Use painting's id as tag for selection
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
            .navigationTitle("Art Gallery")
        }
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


/*struct SecondView: View {
    @State private var paintings: [Painting] = []
    @State private var isLoading = false // Add a state variable to track loading state'
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Press for Art") {
                    // Start loading indicator
                    isLoading = true
                    fetchArt(myKey: "6c461233-f25c-46f0-89a0-8b565588d5b7", baseURL: "https://api.harvardartmuseums.org") { paintings, error in
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
                .padding()
                
                if isLoading {
                    ProgressView() // Show loading indicator if data is being fetched
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 50) {
                            ForEach(paintings, id: \.imageUrl) { painting in
                                VStack(alignment: .center) {
                                    URLImage(URL(string: painting.imageUrl)!) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            
                                    }
                                    .frame(width: 500, height: 500)
                                    
                                    Text(painting.title)
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Art Gallery")
        }
    }
}*/



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

func fetchArt(myKey: String, baseURL: String, completion: @escaping ([Painting]?, Error?) -> Void) {
    // Define the endpoint for retrieving random objects
    let endpoint = "/object"

    // Define the query parameters for the API request
    let queryParams = [
        "apikey": myKey,
        "size": "10", // Specify the number of random paintings to retrieve
        "sort": "random", // Sort the results randomly
        "fields": "title,primaryimageurl,people,datebegin"
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

            if let records = json?["records"] as? [[String: Any]] {
                var paintings = [Painting]()
                for record in records {
                    if let title = record["title"] as? String,
                       let imageUrl = record["primaryimageurl"] as? String,
                       let people = record["people"] as? [[String: Any]],
                       let person = people.first,
                       let artistName = person["name"] as? String,
                       let dateBegin = record["datebegin"] as? Int {
                            print(title + imageUrl + artistName + String(dateBegin))
                            let painting = Painting(title: title, imageUrl: imageUrl, artistName: artistName, yearOfCreation: dateBegin)
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

