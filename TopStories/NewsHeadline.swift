//
//  NewsHeadline.swift
//  TopStories
//
//  Created by Maitree Bain on 11/25/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import Foundation

// top level JSON - HeadlineData.self because top level JSON is a dictionary
struct HeadlinesData: Codable {
    let results: [NewsHeadline] // "results" represents the JSON array of stories
    //results is a an array of struct NewsHeadline
}

struct NewsHeadline: Codable {
    let title: String
    let abstract: String
}

extension HeadlinesData {
    
    // parse the "topStoriesTechnology.json" into [NewsHeadline] objects
    
    static func getHeadlines() -> [NewsHeadline] {
        var headlines = [NewsHeadline]()
        
        //get the URL to the intended resource
        // here we need the URL to topStoriesTechnology.json file
        guard let fileURL = Bundle.main.url(forResource: "TopStoriesTechnology", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        
        //get the data from the contents of the fileURL
        
        do {
        let data = try Data.init(contentsOf: fileURL)
            //parse data to our swift [NewHeadline]
            
            let headlinesData = try JSONDecoder().decode(HeadlinesData.self, from: data)
            headlines = headlinesData.results // [NewsHeadline]
        } catch {
            fatalError("catch error - \(error)")
        }
        //Bundle() allows to access in app resources and files, e.g mp3 file or in our case teh topStoriesTechnology.json
        
        return headlines
    }
}
