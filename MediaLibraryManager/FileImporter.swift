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
			
				// Validate it here, only creating if pass tests
				
				if let validatedFile = validateMedia(media: m) {
					filesValidated.append(validatedFile)
				} else {
					// Invalid, not added
					//TODO
				}
				
				
				// Create a new file or type IMAGE DOCUMENT VIDEO AUDIO
				// Here the validation isn't set up yet, so creating of type generic File instead
				//let f : File = File(metadata: mdata, filename: filename, path: path, creator: creator)
				//filesValidated.append(f)
				
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
	
	- returns: File
	*/
	func validateMedia(media: Media) -> File? {
		
		let type: String = media.type
		let filename: String = getFilename(fullpath: media.fullpath)
		let path: String = getPath(fullpath: media.fullpath)
		var creator: String? 	//= ""
		var res: String? 		//= ""
		var runtime: String? 	//= ""
		
		var mdata: [Metadata] = []
		
		// File to hold media once validated
		var validatedFile: File
		
		// Loop through to fill the required values
		for (key, value) in media.metadata {
			if key.lowercased()=="creator" {
				creator = value.lowercased()
			}
			if key.lowercased()=="runtime" {
				runtime = value.lowercased()
			}
			if key.lowercased()=="resolution" {
				res = value.lowercased()
			}
			let tempMetadata : Metadata = Metadata(keyword: key, value: value)
			mdata.append(tempMetadata)
			
		}
		
		// Validate creator, filename, path for all

		// VALIDATE PATH AND FILENAME
		
		if let creatorU = creator {
			
			// Validate specific data for each type
			switch(type) {
				case "image" :
					if let imageRes = res {
						validatedFile = Image(metadata: mdata, filename: filename, path: path, creator: creatorU, resolution: imageRes)
						return validatedFile
					}
					
					break
				case "document":
					//validatedFile = Document(metadata: mdata, filename: filename, path: path, creator: creatorU)
					//return validatedFile
					break
				case "video":
					if let videoRes = res {
						if let videoRuntime = runtime {
							validatedFile = Video(metadata: mdata, filename: filename, path: path, creator: creatorU, resolution: videoRes, runtime: videoRuntime)
							return validatedFile
						}
					}
					break
				case "audio":
					if let audioRuntime = runtime {
						validatedFile = Audio(metadata: mdata, filename: filename, path: path, creator: creatorU, runtime: audioRuntime)
						return validatedFile
					}
					break
				default:
					print("Default - no  type so no file created")
					// Invalid type error
				}
		}
		return nil
	}
}
