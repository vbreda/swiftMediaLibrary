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
        loadDictionaries(file: file)
    }
    
    /**
     Adds a specific instance of a metadata to the collection.
     
     - Parameters: metadata: The item to add to the collection.
     - Returns: none.
     */
    func add(metadata: MMMetadata, file: MMFile)  {
        var i: Int = 0
        var toUpdate: MMFile?
        for f in files {
            if f as! File == file as! File {
                files[i].metadata.append(metadata)
                toUpdate = files[i]
				updateDictionaries(metadata: metadata, file: file, update: toUpdate)
				break
            }
            i += 1
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
        let searchterm: String = term.lowercased()
        
        // check if either return results and return the one that does? or combine
        var results: [MMFile] = []
        if let keyResults = keysDictionary[searchterm] {
            results.append(contentsOf: keyResults)
        }
        if let valueResults = valuesDictionary[searchterm] {
            results.append(contentsOf: valueResults)
        }
        
        return results
    }
    
    /**
     / Finds all the metadata associated with the keyword of the item
     /
     - Parameters: item: The item's metadata keypair to search for.
     - Returns: [MMFiles]: A list of all the metadata associated with the item's
     keyword, possibly an empty list.
     */
    func search(item: MMMetadata) -> [MMFile]  {
		//Search unimplemented as our Library does not need this functionality
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
	Removes a specific instance of a metadata from the collection.
	
	- Parameters: metadata: The item to remove from the collection.
	- Returns: none.
	*/
	func remove(metadata: MMMetadata)  {
		// Remove metadata term from all files not a functionality in our library
		var i: Int = 0
		for _ in files {
			if let indexM = files[i].metadata.index(where: {$0.keyword == metadata.keyword && $0.value == metadata.value}) {
				files[i].metadata.remove(at: indexM)
			}
			i += 1
		}
	}
	
    /**
     Removes a specific instance of a metadata from a file in the collection.
     Note not in protocols.swift - added this method ourselves.
     
     - Parameters: metadata: The item to remove from the file.
     - Parameters: file: file to remove metadata from.
     - Returns: none.
     */
    func remove(key: String, file: MMFile)  {
		if let indexF = files.index(where: {$0.filename == file.filename}){
			if let indexM = files[indexF].metadata.index(where: {$0.keyword.lowercased() == key.lowercased()}) {
				let rmv = files[indexF].metadata.remove(at: indexM)
				rmvDictionaries(key: key, rmv: rmv, file: file)
			}
		}
    }
    
    /**
     Removes all files from this library.
     */
    func removeAllFiles() {
        files.removeAll()
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
	Checks the current file for this exact keyword
	Note not in protocols.swift - added this method ourselves.
	
	- Parameters: file: file to look in
	- Parameters: keyword: the key to check
	- Returns: true if file already exists in the Library
	*/
	func isMetadataDuplicate(file: MMFile, key: String) -> Bool {
		var found: Bool = false
		
		for m in file.metadata {
			if m.keyword == key {
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
        
        var copy = [MMFile]()
        
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
    
    /**
     Updates the dictionaries if either keywords or values are removed
     from the collection.
     
     - parameter key: the keyword which will be updated.
     - parameter rmv: value to be removed.
     - parameter update: the file which will be updated.
     */
    func rmvDictionaries(key: String, rmv: MMMetadata, file: MMFile) {
        
        var size = keysDictionary[key]?.count
        
        if size == 1 {
            keysDictionary.removeValue(forKey: key.lowercased())
        } else {
            var values = keysDictionary[key.lowercased()]
            let index = values?.index(where: {$0 as! File == file as! File})
            values?.remove(at: index!)
            keysDictionary.updateValue(values!, forKey: key.lowercased())
        }
        
        size = valuesDictionary[rmv.value.lowercased()]?.count
        
        if size == 1 {
            valuesDictionary.removeValue(forKey: rmv.value.lowercased())
        } else {
            var values = valuesDictionary[rmv.value.lowercased()]
            let index = values?.index(where: {$0 as! File == file as! File})
            values?.remove(at: index!)
            valuesDictionary.updateValue(values!, forKey: rmv.value.lowercased())
        }
    }
    
    /**
     Updates the dictionaries if either keywords or values are added
     to the collection.
     
     - parameter metadata: the value which will be updated.
     - parameter file: the file currently in dictionary.
     - parameter update: the modified file which will be updated in the dictionaries.
     */
    func updateDictionaries(metadata: MMMetadata, file: MMFile, update: MMFile?){
        var size = keysDictionary[metadata.keyword.lowercased()]?.count
        
        if size == nil {
            keysDictionary.updateValue([update!], forKey: metadata.keyword.lowercased())
        } else {
            var values = keysDictionary[metadata.keyword.lowercased()]
            let index = values?.index(where: {$0 as! File == file as! File})
            if index == nil {
                values?.append(update!)
            } else {
                values?[index!] = update!
            }
            keysDictionary.updateValue(values!, forKey: metadata.keyword.lowercased())
        }
        
        size = valuesDictionary[metadata.value.lowercased()]?.count
        
        if size == nil {
            valuesDictionary.updateValue([update!], forKey: metadata.value.lowercased())
        } else {
            var values = valuesDictionary[metadata.value.lowercased()]
            let index = values?.index(where: {$0 as! File == file as! File})
            if index == nil {
                values?.append(update!)
            } else{
                values?[index!] = update!
            }
            valuesDictionary.updateValue(values!, forKey: metadata.value.lowercased())
        }
    }
}
