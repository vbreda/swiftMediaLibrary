//
//  MediaLibrary.swift
//  MediaLibraryManager
//
//  Created by Vivian Breda and Nikolah Pearce on 13/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

class MediaLibrary : MMCollection {
	
	var library: [File]
	var libraryName : String
	
	/**
	String representation of the Media Library collection

	- returns: String String representation of the library.
	*/
	var description: String {
		return "Library: \(libraryName). Contains \(library.count) files."
	}
	
	/**
	Default initialiser
	
	Sets the library to be empty and the name to New Library
	*/
	init() {
		self.library = []
		self.libraryName = "New Library"
	}
	
	/**
	Designanted initialiser
	
	Sets the library to be empty and the name as specified by the user
	*/
	init(name : String) {
		self.library = []
		self.libraryName = name
	}
	
	///
	/// Adds a file's metadata to the media metadata collection.
	///
	/// - Parameters:
	/// - file: The file and associated metadata to add to the collection
	func add(file: MMFile) {
		
		// Some file that already has metadata mapped?
		
	}
	
	///
	/// Adds a specific instance of a metadata to the collection
	///
	/// - Parameters:
	/// - metadata: The item to add to the collection
	func add(metadata: MMMetadata, file: MMFile)  {
		
		// Some metadata and the file to add it to?
		
		// Or some file, and some metadata for that file
		// and both need to be added to collection?
		
	}
	
	///
	/// Removes a specific instance of a metadata from the collection
	///
	/// - Parameters:
	/// - metadata: The item to remove from the collection
	func remove(metadata: MMMetadata)  {
		
	}
	
	///
	/// Finds all the files associated with the keyword
	///
	/// - Parameters:
	/// - keyword: The keyword to search for
	/// - Returns:
	/// A list of all the metadata associated with the keyword, possibly an
	/// empty list.
	func search(term: String) -> [MMFile]  {
		return []
	}
	
	///
	/// Returns a list of all the files in the index
	///
	/// - Parameters:
	/// - Returns:
	/// A list of all the files in the index, possibly an empty list.
	func all() -> [MMFile]  {
		return []
	}
	
	///
	/// Finds all the metadata associated with the keyword of the item
	///
	/// - Parameters:
	/// - item: The item's keyword to search for.
	/// - Returns:
	/// A list of all the metadata associated with the item's keyword, possibly
	/// an empty list.
	func search(item: MMMetadata) -> [MMFile]  {
		return []
	}
	
}
