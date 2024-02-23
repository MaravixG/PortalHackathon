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
    
    var body: some View {
            NavigationView {
                VStack {
                    Button("Press for Art") {
                        fetchArt(myKey: "6c461233-f25c-46f0-89a0-8b565588d5b7", baseURL: "https://api.harvardartmuseums.org") { paintings, error in
                            if let error = error {
                                print("Error: \(error)")
                                return
                            }

                            if let paintings = paintings {
                                self.paintings = paintings
                            }
                        }
                    }

                    List(paintings, id: \.imageUrl) { painting in
                        VStack(alignment: .leading) {
                            URLImage(URL(string: painting.imageUrl)!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            .frame(width: 100, height: 100)

                            Text(painting.title)
                                .font(.headline)
                        }
                    }
                }
                .navigationTitle("Art Gallery")
            }
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

struct Painting {
    let title: String
    let imageUrl: String
}

func fetchArt(myKey: String, baseURL: String, completion: @escaping ([Painting]?, Error?) -> Void) {
    // Define the endpoint for retrieving random objects
    let endpoint = "/object"

    // Define the query parameters for the API request
    let queryParams = [
        "apikey": myKey,
        "size": "5", // Specify the number of random paintings to retrieve
        "sort": "random" // Sort the results randomly
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

        // Check if response is received
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            completion(nil, NSError(domain: "InvalidResponse", code: -1, userInfo: nil))
            return
        }

        // Check if data is received
        guard let responseData = data else {
            completion(nil, NSError(domain: "NoData", code: -1, userInfo: nil))
            return
        }

        // Convert the data to JSON
        do {
            let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]

            // Extract information about the paintings from the JSON response
            if let records = json?["records"] as? [[String: Any]] {
                for record in records {
                    if let title = record["title"] as? String, let imageUrl = record["primaryimageurl"] as? String {
                        // Create a Painting object and add it to the array
                        let painting = Painting(title: title, imageUrl: imageUrl)
                        paintings.append(painting)
                    }
                }
            }

            // Call the completion handler with the array of paintings
            completion(paintings, nil)
        } catch {
            completion(nil, error)
        }
    }

    // Start the data task
    task.resume()
}

