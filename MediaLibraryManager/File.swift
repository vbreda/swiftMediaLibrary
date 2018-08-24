//
//  Media.swift
//  MediaLibraryManager
//
//  Created by Vivian Breda and Nikolah Pearce on 13/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

extension MMFile {
	
	static func == (lhs: Self, rhs: MMFile) -> Bool {
		return lhs.filename == rhs.filename && lhs.path == rhs.path
	}
	
	static func != (lhs: Self, rhs: MMFile) -> Bool{
		return !(lhs == rhs)
	}
}

// here we're actually keeping track of the concrete instances
//private var _metadata: [ConcreteMetadata] = []

// here we're converting the instances so that we can obey the
// MMFile protocol
//var metadata: [MMMetadata] {
//	get{
//		var result: [MMMetadata] = []
//		for m in self._metadata{
//			result.append(m as MMMetadata)
//		}
//		return result
//	}
//	set(value){
//		var result: [ConcreteMetadata] = []
//		for v in value {
//			if let m = v as? ConcreteMetadata{
//				result.append(m)
//			}
//		}
//		_metadata = result
//	}
//}
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
