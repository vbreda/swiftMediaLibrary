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


//class Exporter: MMFileExport {
//	struct Files: Codable{
//		let fullpath: String
//		let type: String
//		let metadata: [String: String]
//		
//		init(path: String, type: String, metadata: [String:String]) {
//			self.fullpath = path
//			self.type = type
//			self.metadata = metadata
//		}
//	}
//	
//	///
//	/// Supports exporting the media collection to a file (by name)
//	///
//	/// - Parameters:
//	/// - filename: The file to save the data
//	/// - items: The data to save inside the file
//	func write(filename: String, items: [MMFile]) throws{
//		var export = [Files]()
//		//for each file in collection
//		for file in items {
//			var mToAdd = [String:String]()
//			//for each meta in metadata array
//			for meta in file.metadata{
//				mToAdd.updateValue(meta.value, forKey: meta.keyword)
//			}
//			//determine file type while creating new file
//			let f = Files(path: file.path, type: try checkType(check: file), metadata: mToAdd)
//			export.append(f)
//		}
//		
//		guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
//		let fileUrl = documentDirectoryUrl.appendingPathComponent(filename)
//		
//		// Transform array into data and save it into file
//		do {
//			let encoder = JSONEncoder()
//			let exportData = try encoder.encode(export)
//			try exportData.write(to: fileUrl, options: [])
//		} catch {
//			throw MMCliError.saveError
//		}
//	}
//	

