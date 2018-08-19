//
//  FileImporter.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce and Vivian Breda on 14/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

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
		
		/**

		Further code emailed out from Paul 17/08/18


			let filename = “/path/to/people.json"
			let url = URL(fileURLWithPath: filename)
			let data = try Data(contentsOf: url)

			// the struct mirrors the JSON data
			struct Person: Codable {
				var name: String
				var office: String
				var languages: [String]
			}
		
			let decoder = JSONDecoder()
			let people = try! decoder.decode([Person].self, from: data)
		*/
		
        do {
            //print ("Reading file...")
            
            let path = URL(fileURLWithPath: filename)
            let data = try Data(contentsOf: path)
            
            //print("Raw Data \(data)")

            //let parsedData = try JSONSerialization.jsonObject(with: data)
            
            //print("parsed Data: ")
            //print(parsedData)
            
            // Do the commands to get it into the struct here
			
			struct Media : Codable {
				let fullpath: String
				let type: String
				let metadata: [String: String]
			}
			
			
			print("Decoder creating...")
			let decoder = JSONDecoder()
			print("Decoding.... ")
			
			var mediaArray : [Media] = []
			mediaArray = try! decoder.decode([Media].self, from: data)
			
			print("Printing..")
			var i = 0
			for m in mediaArray {
				var j = 0
				print("#\(i) : \(m)")
				for d in m.metadata {
					print("keypair #\(j) : \(d)")
					j += 1
				}
				i += 1
			}
			//print(mediaArray)
            
        } catch let error as NSError {
            print("Whoops, an error! \(error)")
        }

		return []
	}
	
	
}
