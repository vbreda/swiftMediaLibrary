//
//  FileImporter.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce and Vivian Breda on 14/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

/**
Support struct for reading JSON data in.
*/
struct Media : Codable {
	let fullpath: String
	let type: String
	let metadata: [String: String]
}

class FileImporter : MMFileImport {
	
	/**
	Support importing the media collection from a file (by name)
	
	- parameters: filename: the full path to the file including file name.
	- returns: [MMFile]: the array of files read successfully
	*/
	func read(filename: String) throws -> [MMFile] {
		
        // Can load multiple files at once
		// read the JSON file and call Library.files.add(file) method
        // Probably want to LOOP while there are >0 left in PARTS
		
		
		/**
		Loop through each 'Media' struct in the mediaArray
		pull out the type
		validate the item for that type
			create a new File
			load the Metadata
			return that file???
		Add it to the list of Files
		return list
		*/
		
		var filesValidated : [File] = []
		
        do {
			
            let path = URL(fileURLWithPath: filename)
            let data = try Data(contentsOf: path)
			
            //print("Raw Data \(data)")
            //let parsedData = try JSONSerialization.jsonObject(with: data)
            //print("parsed Data: ")
            //print(parsedData)
			
			let decoder = JSONDecoder()
			var mediaArray : [Media] = []
			mediaArray = try! decoder.decode([Media].self, from: data)
			
			for m in mediaArray {
				
				let type: String = m.type
				let filename: String = getFilename(fullpath: m.fullpath)
				let path: String = getPath(fullpath: m.fullpath)
				var creator: String = ""
				
				var mdata: [Metadata] = []
				
				for (key, value) in m.metadata {
					if key.lowercased()=="creator" {
						creator = value
					}
					let tempMetadata : Metadata = Metadata(keyword: key, value: value)
					mdata.append(tempMetadata)
					
				}
				
				// Validate it here, only creating if pass tests
				
				// Create a new file or type IMAGE DOCUMENT VIDEO AUDIO
				// Here the validation isn't set up yet, so creating of type generic File instead
				let f : File = File(metadata: mdata, filename: filename, path: path, creator: creator)
				filesValidated.append(f)
				
			}
        } catch let error as NSError {
            print("Whoops, an error! \(error)")
			// Will need to fill these in
			// e.g. invalid json file path reaches here
        }
		
		return filesValidated
	}
	
	/**
	Calculates a filename of a file from the fullpath string.
	
	- parameters: fullpath: the full path to the file including file name.
	- returns: String: the name of the file.
	*/
	func getFilename(fullpath: String) -> String {
		
		var parts = fullpath.split(separator: "/")
		let name = String(parts[parts.count-1])
		//print ("Name found: \(name)")
		return name
	}
	
	/**
	Calculates a path to a file from the fullpath string.
	
	- parameters: fullpath: the full path to the file including file name.
	- returns: String: the path to the file.
	*/
	func getPath(fullpath: String) -> String {
		
		var parts = fullpath.split(separator: "/")
		var path: String = ""
		let lastIndex = parts.count-2
		for i in 0...lastIndex {
			if parts[i] != "~" {
				path += "/"
			}
			path += parts[i]
		}
		//print ("PATH found: \(path)")
		return path
	}
	
	/**
	Designed to validate Files depending upon their type.
	Needs assert statements added.
	
	- returns: Bool: true if the file is valid
	*/
	func validateMedia() -> Bool {
		
		return false;
	}
}
