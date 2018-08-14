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

struct MyData : Codable {
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
            
            let path = URL(fileURLWithPath: filename)
            let data = try Data(contentsOf: path)
            
            print("Raw Data \(data)")

            let parsedData = try JSONSerialization.jsonObject(with: data)
            
            print("parsed Data: ")
            
            print(parsedData)
            
            // Do the commands to get it into the struct here
            
        } catch let error as NSError {
            print(error)
        }

		return []
	}
	
	
}
