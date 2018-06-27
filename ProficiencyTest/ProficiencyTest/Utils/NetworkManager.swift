//
//  NetworkManager.swift
//  ProficiencyTest
//
//  Created by Mac_Admin on 20/06/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import Foundation


class NetworkManager {
    
    static func getDataFromServer(completion: @escaping (CountryFacts?, Error?) -> Void) {
        
        let task: URLSessionDataTask?
        
        //   Check that our URL is valid
        
        guard let url = URL(string: Constants.BaseURL + Constants.GetFacts) else {
            print ("Bad URL")
            
            let err = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(nil, err)
            return
        }
        
        // Create a default Session.
        
        let session = URLSession(configuration: .default)
        
        // Setup A Task to get Data from our URL
        
        task = session.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                // If we have errors or no data... get out of here !
                
                guard let data = data, error == nil else {
                    
                    completion(nil, error)
                    return
                }
                
                // Check that we have a Success Response
                
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    
                    // Convert Data to the ascii / utf8 format.
                    if let value = String(data: data, encoding: .ascii) {
                        if let responseDataUTF8 = value.data(using: .utf8) {
                            
                            do {
                                let jsonData = try JSONDecoder().decode(CountryFacts.self, from: responseDataUTF8)
                                completion(jsonData, nil)
                            } catch let jsonError {
                                completion(nil, jsonError)
                            }
                        }
                    }
                } else {
                    
                    completion(nil, error)
                }
            }
        }
        task?.resume()
    }
}
