//
//  Metadata.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce and Vivian Breda on 13/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

/**
Creates the metadata for a media file.

*/
class Metadata: MMMetadata {
	
	var keyword: String    // metadata property
	var value: String      // value of the metadata property
	
	/**
	Designated initialiser
	
	Metadata property/value pair is passed in the arguments of the initialiser.
	
	- parameter keyword: Metadata's keyword
	- parameter value: Metadata's value
	*/
	init(keyword: String, value: String) {
		self.keyword = keyword
		self.value = value
	}
	
	/**
	String representation of the metadata
	
	- returns: String String representation of the metadata.
	*/
	var description: String {
		return "One Metadata keypair. \(self.keyword): \(self.value)"
	}
}
