//
//  ImageClient.swift
//  TopStories
//
//  Created by Maitree Bain on 11/26/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

struct ImageClient {
    
    //takes in an urlString -> an image and uses a completion handler to capture
    //processed image from the url source e.g "https://.....jpg"
    
    //we cannot simply return an image from this function
    //why?
    //because URLSession performs an asynchronous network call, which means the call relies
    //on the network and is done on the background, not performed instantaneously (concurrent)
    static func fetchImage(for urlString: String,
                           completion: @escaping (Result<UIImage?, Error>) -> ()) {
        
        guard let url = URL(string: urlString) else {
            print("no image url found \(urlString)")
            return
        }
        
        //create a data task using the URLSession() class
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
           
            //check if an error exists
            if let error = error {
                print("error: \(error)")
                //add enum error
            }
            //check valid status code 200..299
            
            //check mime type
            if let data = data {
                // use data to create an image
                let image = UIImage(data: data)
                
                //capture result of image
                completion(.success(image))
                
            }
           
            
        }
        dataTask.resume() //executes network request
        
        
        
    }
    
}
