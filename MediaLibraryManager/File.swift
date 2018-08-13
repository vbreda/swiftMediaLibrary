//
//  Media.swift
//  MediaLibraryManager
//
//  Created by Vivian Breda and Nikolah Pearce on 13/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

/**
Creates a media file with metadata.

*/
class File: MMFile {
	
	var metadata: [MMMetadata]    // the collection of the file's metadata
	var filename: String          // the name of the file
	var path: String              // the path to the file
	
	/**
	Designated initialiser
	
	The properties of the file.
	
	- parameter metadata: all the metadata of a file.
	- parameter filename: the name of the file.
	- parameter path: File's path.
	*/
	init(metadata: [MMMetadata], filename: String, path: String) {
		self.metadata = metadata
		self.filename = filename
		self.path = path
	}
	
	/**
	String representation of the file
	
	- returns: String String representation of the file.
	*/
	var description: String {
		return "\(filename)"
	}
}
