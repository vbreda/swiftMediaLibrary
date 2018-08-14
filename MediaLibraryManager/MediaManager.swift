//
//  MediaManager.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce and Vivian Breda on 14/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

class MediaManager : MMFileImport, MMFileExport {
	
	
	var library = MediaLibrary();
	
	///
	/// Support importing the media collection from a file (by name)
	func read(filename: String) throws -> [MMFile] {
		
		// read the JSON file and call MediaManager.files.add()
		// library.files.add()
		
		return []
	}
	
	
	///
	/// Support exporting the media collection to a file (by name)
	func write(filename: String, items: [MMFile]) throws {
		
	}
	
}
