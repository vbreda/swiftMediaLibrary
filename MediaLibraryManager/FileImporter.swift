//
//  FileImporter.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce and Vivian Breda on 14/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

struct MData : Codable {
    let keyword: String
    let value: String
}

struct Data : Codable {
    let path: String
    let type: String
    let mdata: [MData]
}

class FileImporter : MMFileImport {
	
	///
	/// Support importing the media collection from a file (by name)
	func read(filename: String) throws -> [MMFile] {
		
		// read the JSON file and call Library.files.add(file) method
 
        /**
         Potential method here:
         - path to file provided as second paramater
         - load JSON file and pull out the metadata
         - create a File of type X (as recorded in Metadata)
         - Add the metadata to the file
         - Add the File to the library using MediaLibary.add(file: newFile)
         */
        
        // Can load multiple files at once
        // Probably want to LOOP while there are >0 left in PARTS
        
        do {
            print ("made it inside imorter")
            
//            let decoder = JSONDecoder()
//
//            let parsedData = try JSONSerialization.jsonObject(with: filename) as! [String: Any]
//
//            var i: Int = 0
//            for (key, value) in parsedData {
//
//                print (" ")
//                print (" ")
//                print ("count: \(i)")
//                print ("\(key) ---> \(value)")
//                i += 1
//            }
//            
            
        } catch let error as NSError {
            print(error)
        }
        
        //let jsonData = data.json(encoding: .utf8)!
        //let decoder = JSONDecoder()
        //let file1 = try! decoder.decode(Beer.self, for: jsonData)
        
        
		return Library.files
	}
	
	
}
