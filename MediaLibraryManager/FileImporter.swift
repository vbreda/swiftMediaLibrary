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
	
		var filesValidated : [MMFile] = []
		
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
	func validateMedia(media: Media) -> MMFile? {
		
		let type: String = media.type
		let filename: String = getFilename(fullpath: media.fullpath)
		let path: String = getPath(fullpath: media.fullpath)
		var creator: String? 	//= ""
		var res: String? 		//= ""
		var runtime: String? 	//= ""
		
		var mdata: [Metadata] = []
		
		// File to hold media once validated
		var validatedFile: MMFile
		
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

		// No need to validate the media path or media name
        // Paul 22/08/18
		
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
					validatedFile = Document(metadata: mdata, filename: filename, path: path, creator: creatorU)
					return validatedFile
				case "video":
					if let videoRes = res, let videoRuntime = runtime {
                        validatedFile = Video(metadata: mdata, filename: filename, path: path, creator: creatorU, resolution: videoRes, runtime: videoRuntime)
                        return validatedFile
                    
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

/**
 The list of exceptions that can be thrown by the Validation handler
 */
enum MMValidationError : Error {
        
    // Thrown if there is something wrong with the JSON file
    // e.g. grammar or incorrect file path
    case invalidJSONfilie
    
    // Thrown if there is something wrong with the type of media
    case invalidType
    
    // Thrown if there is something wrong with metadata for a specific type
    // e.g. image does not have resolution
    case invalidMetadataForType
    
    // Thrown if a file to be added is already in the library
    case duplicatMedia
}
