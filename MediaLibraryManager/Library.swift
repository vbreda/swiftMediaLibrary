//
//  MediaLibrary.swift
//  MediaLibraryManager
//
//  Created by Vivian Breda and Nikolah Pearce on 13/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

class Library : MMCollection {
    
    private var files: [MMFile] = []
    var dictionary : [String:[MMFile]] = [:]
    
    /**
     String representation of the Media Library collection
     - Returns: String: String representation of the library.
     */
    var description: String {
        return "> Media library contains \(count) files."
    }
    
    /**
     The size of the library.
     - Returns: Count: number of files in the library.
     */
    var count: Int {
        return files.count
    }
    
    /**
     Default initialiser
     
     */
    init() {
        
    }
    
    
    /**
     Adds a file's metadata to the media metadata collection.
     
     - Parameters: file: The file and associated metadata to add to the collection.
     - Returns: none.
     */
    func add(file: MMFile) {
        
        // Some file that already has metadata mapped?
        files.append(file)
        
        //create an inverted dictionary
        var array : [MMFile] = []
        dictionary = [:]
        for f in files {
            for m in f.metadata {
                if(dictionary.keys.contains(m.value.lowercased())){
                    array = dictionary[m.value.lowercased()]!
                    array.append(f)
                    dictionary.updateValue(array, forKey: m.value.lowercased())
                } else {
                    dictionary.updateValue([f], forKey: m.value.lowercased())
                }
            }
        }
    }
    
    /**
     Adds a specific instance of a metadata to the collection.
     
     - Parameters: metadata: The item to add to the collection.
     - Returns: none.
     */
    func add(metadata: MMMetadata, file: MMFile)  {
        
        // Some metadata and the file to add it to?
        var i: Int = 0
        for f in files {
            if f as! File == file as! File {
                //f.metadata.append(metadata)
                files[i].metadata.append(metadata)
            }
            i += 1
        }
        
    }
    
    /**
     Removes a specific instance of a metadata from the collection.
     
     - Parameters: metadata: The item to remove from the collection.
     - Returns: none.
     */
    func remove(metadata: MMMetadata)  {
        print("Removing .....")
    }
    
    /**
     Finds all the files associated with the keyword.
     
     - Parameters:
     - keyword: The keyword to search for.
     - Returns: [MMFile]: A list of all the metadata associated with the
     keyword, possibly an empty list.
     */
    func search(term: String) -> [MMFile]  {
        let searchterm : String = term.lowercased()
        
        return dictionary[searchterm]!
    }
    
    /**
     Returns a list of all the files in the index
     
     - Parameters: none
     - Returns: [MMFile]: A list of all the files in the index, possibly an empty list.
     */
    func all() -> [MMFile]  {
        return files
    }
    
    /**
     / Finds all the metadata associated with the keyword of the item
     /
     - Parameters: item: The item's keyword to search for.
     - Returns: [MMFiles]: A list of all the metadata associated with the item's
     keyword, possibly an empty list.
     */
    func search(item: MMMetadata) -> [MMFile]  {
        
        return []
    }
    
    /**
     Removes a specific instance of a metadata from a file in the collection.
     Note not in protocols.swift - added this method ourselves.
	
     - Parameters: metadata: The item to remove from the file.
     - Parameters: file: file to remove metadata from.
     - Returns: none.
     */
    func remove(metadata: MMMetadata, file: MMFile)  {
        var i: Int = 0
        var index: Int = 0
        var valremoved: MMMetadata
        
        for f in files {
            if f as! File == file as! File {
                for m in files[i].metadata {
                    if m as! Metadata == metadata as! Metadata {
                        valremoved = files[i].metadata.remove(at: index)
                        print("'\(valremoved)' removed from file \(i)")
                    }
                    index += 1
                }
            }
            i += 1
        }
    }
	
	/**
	Checks the current library for this exact file.
	Note not in protocols.swift - added this method ourselves.
	
	- Parameters: file: file to look for in the Library
	- Returns: true if file already exists in the Library
	*/
	func isDuplicate(file: MMFile) -> Bool {
		var found: Bool = false
		
		for f in files {
			if f as! File == file as! File {
				found = true
			}
		}
		
		return found
	}
	
	
}
