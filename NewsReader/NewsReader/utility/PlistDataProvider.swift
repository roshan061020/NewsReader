//
//  PlistDataProvider.swift
//  NewsReader
//
//  Created by Roshan yadav on 07/10/24.
//

import Foundation


class plistDataFetcher {
    private func getPlistData(from fileName: String, bundle: Bundle = .main) -> [String: AnyObject]? {
        // Get the path to the plist file
        if let path = bundle.path(forResource: fileName, ofType: "plist") {
            // Create a dictionary from the plist file
            return NSDictionary(contentsOfFile: path) as? [String: AnyObject]
        }
        return nil
    }
    
    func getValueFromConfig(for key: String) -> String? {
        guard let plist = getPlistData(from: "config") else {return nil}
        // Get the Key value from the dictionary
        return plist[key] as? String
    }
    
}
