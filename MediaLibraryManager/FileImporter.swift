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
		
        // Can load multiple files at once
		// read the JSON file and call Library.files.add(file) method
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
			
			let decoder = JSONDecoder()
			var mediaArray : [Media] = []
			mediaArray = try! decoder.decode([Media].self, from: data)
//
//			var i = 0
//			for m in mediaArray {
//				var j = 0
//				print("#\(i) : \(m)")
//				for d in m.metadata {
//					print("keypair #\(j) : \(d)")
//					j += 1
//				}
//				i += 1
//			}
			var filesValidated : [File] = []
			
			for m in mediaArray {
				
				var type: String = m.type
				var filename: String = getFilename(fullpath: m.fullpath)
				var path: String = getPath(fullpath: m.fullpath)
				var creator: String
				
				//var mdata: [Metadata]
				
				
				print("Type of file: \(type)")
				
				for (key, value) in m.metadata {
					print("Key: '\(key)' and value: '\(value)'.")
					if key.lowercased()=="creator" {
						creator = value
					}
				}
				
				//init(metadata: [MMMetadata], filename: String, path: String, creator: String)
				//var f : File = File(, filename, path, creator)
				//filesValidated.append(f: File)

			}
			
			/**
				Loop through each 'Media' struct in the mediaArray
				pull out the type
				validate the item for that type
				create a new File
				load the Metadata
				Add to the list of Files
				return list
			*/
			
        } catch let error as NSError {
            print("Whoops, an error! \(error)")
        }

		return []
	}
	
	// Takes one string of fullpath
	// Returns [string] of name at 0 and path at 1
	func getFilename(fullpath: String) -> String {
		
		// This is finding the first index, need the last!
		let index = fullpath.index(of: "/") ?? fullpath.endIndex
		let nameSubstring = fullpath[index...]
		let name = String(nameSubstring)
		print ("Name found: \(name)")
		return name
	}
	
	// Takes one string of fullpath
	func getPath(fullpath: String) -> String {
		
		// This is finding the first index, need the last!
		let index = fullpath.index(of: "/") ?? fullpath.endIndex
		let nameSubstring = fullpath[..<index]
		let name = String(nameSubstring)
		print ("fullpath found: \(name)")
		return name
	}
	
	// Returns not the first, but last index of '/'
	// WIP - not finished
	func findLastIndexOf(fullpath: String) -> Int {
		
		var slashCount = 0
		for character in fullpath {
			if character == "/" {
				slashCount += 1
			}
		}
		return 0
	}
	
	func validateMedia() -> Bool {
		
		return false;
	}
}
