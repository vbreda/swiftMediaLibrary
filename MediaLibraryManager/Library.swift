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
	private var keysDictionary: [String:[MMFile]] = [:]
	private var valuesDictionary: [String:[MMFile]] = [:]
	
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
		
        files.append(file)
		//loadDictionaries(file: file)
		
		// This currently executes EVERY time add is called. loops through entire files as each 1 added.
		//e.g. I add 2 files, below is executed twice - redundant. Just execute per file added!
		// e.g. remove the for f in files part  - no need to loop
		
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
		var i: Int = 0
        for f in files {
            if f as! File == file as! File {
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
		for f in files {
			remove(metadata: metadata, file: f)
		}
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
		
		// check if either return results and return the one that does? or combine
		var results: [MMFile] = []
		if let keyResults = keysDictionary[searchterm] {
			results.append(contentsOf: keyResults)
		}
		if let valueResults = valuesDictionary[searchterm] {
			results.append(contentsOf: valueResults)
		}
		
		return results
		// Need to account for WHAT IF NO SEARCH TERM exists? I accidentally through a lldb bug lol sorry
//		if let found = dictionary[searchterm] {
//			return found
//		} else {
//			// catch the error?
//		}
//
//		do {
//			return dictionary[searchterm]!
//		} catch {
//			throw MMCliError.dataDoesntExist
//		}
        //return dictionary[searchterm]!
    }
	
	/**
	/ Finds all the metadata associated with the keyword of the item
	/
	- Parameters: item: The item's metadata keypair to search for.
	- Returns: [MMFiles]: A list of all the metadata associated with the item's
	keyword, possibly an empty list.
	*/
	func search(item: MMMetadata) -> [MMFile]  {
		let res1 = search(term: item.keyword)
		let res2 = search(term: item.value)
		// See which are in both lists?
		return []
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
	
	/**
	Loads the metadata dictionaries of the new file.
	Adds both keywords and values to the Library dictionaries.
	
	- parameter file: the new file added to the library.
	*/
	func loadDictionaries(file: MMFile) {
		
		var copy: [MMFile] = []
		
		for m in file.metadata {
			
			// Add to the keys Dictionary
			if keysDictionary.keys.contains(m.keyword.lowercased()) {
				copy = keysDictionary[m.keyword.lowercased()]!
				copy.append(file)
				keysDictionary.updateValue(copy, forKey: m.keyword.lowercased())
			} else {
				keysDictionary.updateValue([file], forKey: m.keyword.lowercased())
			}
			
			// Add to the values Dictionary
			if valuesDictionary.keys.contains(m.value.lowercased()) {
				copy = valuesDictionary[m.value.lowercased()]!
				copy.append(file)
				valuesDictionary.updateValue(copy, forKey: m.value.lowercased())
			} else {
				valuesDictionary.updateValue([file], forKey: m.value.lowercased())
			}
		}
		
	}
	
}
