//
//  FetchData.swift
//  Fish
//
//  Created by Aaron Zheng (student LM) on 1/18/23.
//

import Foundation

class FetchData: ObservableObject {
    @Published var response: [Response] = []
    
    func getData() async {
        let URLString =
        "https://www.fishwatch.gov/api/species"
        
        guard let url = URL(string: URLString) else {return}
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            response = try JSONDecoder().decode([Response].self, from: data)
            
            let dataString = String(data:data, encoding: .utf8)
            print(dataString)
            
            self.response = response
            
           
        } catch {
            print(error)
        }
    }
}

struct Response: Decodable {
    var fishingManagement: String? = ""
    var Habitat: String? = ""
    var habitatImpacts: String? = ""
    var Location: String? = ""
    var populationStatus: String? = ""
    var scientificName: String = "Lutjanus campechanus"
    var photo: FishImage = FishImage()
    var name: String = "Red Snapper"
    
    private enum CodingKeys: String, CodingKey {
        case fishingManagement = "Fishery Management"
        case habitatImpacts = "Habitat Impacts"
        case populationStatus = "Population Status"
        case scientificName = "Scientific Name"
        case photo = "Species Illustration Photo"
        case name = "Species Name"
    }
}

struct FishImage: Decodable {
    var src: String = "https://origin-east-01-drupal-fishwatch.woc.noaa.gov/sites/default/files/snapperred_1.jpg"
    var alt: String? = ""
    var title: String? = ""
}

extension Response : Identifiable {
    var id : String{name}
}
