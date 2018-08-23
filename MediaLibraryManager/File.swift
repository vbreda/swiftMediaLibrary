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
    var originalCreator: String   // the creator of the file as at load time
	
	// Computed variable creator, returns the File's current creator
	var creator : String {
		var cr: String = ""
		for m in metadata {
			if m.keyword.lowercased() == "creator" {
				cr = m.value
			}
		}
		return cr
	}
	
	/**
	Designated initialiser
	
	The properties of the file.
	
	- parameter metadata: all the metadata of a file.
	- parameter filename: the name of the file.
	- parameter path: the File's path.
	- parameter creator: the File's creator.
	*/
    init(metadata: [MMMetadata], filename: String, path: String, creator: String) {
        self.metadata = metadata
		self.filename = filename
		self.path = path
        self.originalCreator = creator
	}
	
	/**
	String representation of the file
	
	- returns: String String representation of the File.
	*/
	var description: String {
        return "\(filename) creator: \(creator)"
	}
}
