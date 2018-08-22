//
//  MediaLibrary.swift
//  MediaLibraryManager
//
//  Created by Vivian Breda and Nikolah Pearce on 13/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

class Library : MMCollection {
	
	// Static array of files, only want one instance ever
	//static var files: [MMFile] = []
	var files: [MMFile] = []
	
	/**
	String representation of the Media Library collection
	- Returns: String: String representation of the library.
	*/
	var description: String {
		return "Your media library contains \(files.count) files."
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
	}
	
	/**
	Adds a specific instance of a metadata to the collection.
	
	- Parameters: metadata: The item to add to the collection.
	- Returns: none.
	*/
	func add(metadata: MMMetadata, file: MMFile)  {
		
		// Some metadata and the file to add it to?
		for f in files {
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
		print("I'm searching!")
        return files //TEMPORARY
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
     
     - Parameters: metadata: The item to remove from the file.
     - Parameters: file: file to remove metadata from.
     - Returns: none.
     */
    func remove(metadata: MMMetadata, file: MMFile)  {
        print("Modifying .....")
    }
	
}
