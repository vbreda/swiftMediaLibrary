//
//  FileImporter.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce and Vivian Breda on 14/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

/**
 The list of exceptions that can be thrown by the Validation handler
 */
enum MMValidationError : Error {
    
    // Thrown if there is something wrong with the JSON file
    // e.g. grammar or incorrect file path
    case invalidJSONfile
    
    // Thrown if there is something wrong with the type of media
    case invalidType
    
    // Thrown if there is something wrong with metadata for a specific type
    // e.g. image does not have resolution
    case invalidMetadataForType
    
    // Thrown if a file to be added is already in the library
    case duplicateMedia
}

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
	Constructs a new File Validator
	*/
	init() {
		
	}
	
	/**
	Support importing the media collection from a file (by name)
	
	- parameter filename: the full path to the file including file name.
	- returns: [MMFile]: the array of files read successfully
	*/
	func read(filename: String) throws -> [MMFile] {
	
		var filesValidated : [MMFile] = []
		
        do {
			
			let fileManager = FileManager.default
			var filePath: URL
			
			// Create full file path depending on user input
			if filename.hasPrefix("/") || filename.hasPrefix("~") {
				let directory = NSString(string: filename).expandingTildeInPath
				filePath = URL(fileURLWithPath: directory)
			} else {
				let working = fileManager.currentDirectoryPath
				let workingDirectory = URL(fileURLWithPath: working)
				
				// TODO remove this when you've got it ;)
				print()
				print("\tVivian put your files here: ")
				print("\t\(workingDirectory)")
				print()
				
				filePath = workingDirectory.appendingPathComponent(filename)
			}

			// Decode the json data into array of Media structs
            let decoder = JSONDecoder()
            var mediaArray : [Media] = []
            
            do {
                let data = try Data(contentsOf: filePath)
				mediaArray = try decoder.decode([Media].self, from: data)
            } catch {
                print("> Invalid JSON file...")
				print("\tCheck your filename, path and/or contents and try again.")
            }
			
			
			// Convert from Media struct into true File, if valid
			let validator: FileValidator = FileValidator()
			
			for m in mediaArray {
					// TODO check our current library for duplicate path&file.
					// We do not want duplicates.
				if let validatedFile = try validator.validate(media: m) {
					filesValidated.append(validatedFile)
				} else {
					print("Made it inside errors")
					let errors = validator.getErrorMessages()
					for e in errors {
						print("\t\(e)")
					}
				}
			}
        } catch MMValidationError.invalidType {
            print("> Invalid file type, expecting image document audio or video.")
        } catch MMValidationError.invalidMetadataForType {
            print("> Invalid metadata for provided media type.")
        } catch MMValidationError.duplicateMedia {
            print("> File not loaded - identical file already in library.")
        }
		
		return filesValidated
	}
}

class FileValidator {
	
	// Dictionaries that store valid metadata needed
	private let validImage = ["resolution": true, "runtime": false,"creator": true]
	private let validDocument = ["resolution": false, "runtime": false,"creator": true]
	private let validVideo = ["resolution": true, "runtime": true,"creator": true]
	private let validAudio = ["resolution": false, "runtime": false,"creator": true]

	private var errorMessages: [String] = []
	
	private var type: String = ""
	private var filename: String = ""
	private var path: String = ""
	private var creator: String?
	private var res: String?
	private var runtime: String?
	
	private var mdata: [Metadata] = []
	private var keys: [String] = []
	private var validatedFile: MMFile? = nil

	
	/**
	Sets up the Validator for the new File
	
	- parameter Media: the Media struct to validate as a File
	*/
	init() {
		clearFields()
	}

	func validate(media: Media) throws -> MMFile? {
		
		clearFields()

		type = media.type
		filename = getFilename(fullpath: media.fullpath)
		path = getPath(fullpath: media.fullpath)
		
		
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
			keys.append(key)
		}
		
		let validType = try validateType()
		if validType {
			validatedFile = try createFile()
		}
		return validatedFile
	}
	
	/**
	Designed to validate Files depending upon their type.
	
	Performs type checking and required metadata checking.
	Throws MMValidationErrors where media does not conform.
	
	- parameter Media: the Media struct to validate as a File
	- returns: MMFile? the validated File
	*/
	func validateType() throws -> Bool {
		
		var typeValid: Bool = true
		
		switch(type) {
		case "image" :
			for (keyword, compulsory) in validImage {
				if compulsory == true && !keys.contains(keyword) {
					typeValid = false
				}
			}
			break
		case "document":
			for (keyword, compulsory) in validDocument {
				if compulsory == true && !keys.contains(keyword) {
					typeValid = false
				}
			}
			break
		case "video":
			for (keyword, compulsory) in validVideo {
				if compulsory == true && !keys.contains(keyword) {
					typeValid = false
				}
			}
			break
		case "audio":
			for (keyword, compulsory) in validAudio {
				if compulsory == true && !keys.contains(keyword) {
					typeValid = false
				}
			}
			break
		default:
			// Missing compulsory metadata keys
			errorMessages.append("\(filename) not loaded. Missing required metadata.")
		}
		return typeValid
	}
	
	/**
	Creates the MMFile if type is valid.
	
	- returns: MMFile? the file created.
	*/
	func createFile() throws -> MMFile? {
		switch(type) {
			case "image" :
				validatedFile = Image(metadata: mdata, filename: filename, path: path, creator: creator!, resolution: res!)
				break
			case "document":
				validatedFile = Document(metadata: mdata, filename: filename, path: path, creator: creator!)
				break
			case "video":
				validatedFile = Video(metadata: mdata, filename: filename, path: path, creator: creator!, resolution: res!, runtime: runtime!)
				break
			case "audio":
				validatedFile = Audio(metadata: mdata, filename: filename, path: path, creator: creator!, runtime: runtime!)
				break
			default:
				throw MMValidationError.invalidType
		}
		return validatedFile!
	}
	
	/**
	Clears and resets all data fields.
	*/
	func clearFields() {
		type = ""
		filename = ""
		path = ""
		creator = nil
		res = nil
		runtime = nil
		mdata = []
		keys = []
		validatedFile = nil
	}
	
	/**
	Returns any error message created.
	- returns: String the error message created
	*/
	func getErrorMessages() -> [String] {
		return errorMessages
	}
	
	/**
	Calculates a filename of a file from the fullpath string.
	
	- parameters: fullpath: the full path to the file including file name.
	- returns: String: the name of the file.
	*/
	func getFilename(fullpath: String) -> String {
		
		var parts = fullpath.split(separator: "/")
		let name = String(parts[parts.count-1])
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
		return path
	}

}




// "No need to validate the media path or media name, we won't
// be testing with bad data of these" - Paul 22/08/18

//        if let unwrappedCreator = creator {
//
//            // Validate specific data for each type
//            switch(type) {
//                case "image" :
//                    if let imageRes = res {
//                        validatedFile = Image(metadata: mdata, filename: filename, path: path, creator: unwrappedCreator, resolution: imageRes)
//                    } else {
//                        throw MMValidationError.invalidMetadataForType
//                    }
//                    break
//            case "document":
//                    validatedFile = Document(metadata: mdata, filename: filename, path: path, creator: unwrappedCreator)
//                    break
//                case "video":
//                    if let videoRes = res, let videoRuntime = runtime {
//                        validatedFile = Video(metadata: mdata, filename: filename, path: path, creator: unwrappedCreator, resolution: videoRes, runtime: videoRuntime)
//                    } else {
//                        throw MMValidationError.invalidMetadataForType
//                    }
//                    break
//                case "audio":
//                    if let audioRuntime = runtime {
//                        validatedFile = Audio(metadata: mdata, filename: filename, path: path, creator: unwrappedCreator, runtime: audioRuntime)
//                    } else {
//                        throw MMValidationError.invalidMetadataForType
//                    }
//                    break
//                default:
//                    throw MMValidationError.invalidType
//                }
//            return validatedFile
//        } else {
//            throw MMValidationError.invalidMetadataForType
//        }

