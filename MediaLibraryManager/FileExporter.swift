//
//  FileExporter.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce and Vivian Breda on 14/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

class FileExporter: MMFileExport {
	
	///
	/// Support exporting the media collection to a file (by name)
    // TODO make sure the filename exists.
	func write(filename: String, items: [MMFile]) throws {
		print("I am the file exporter") //TEST
	}
	
}
