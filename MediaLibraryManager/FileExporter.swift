//
//  FileExporter.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce and Vivian Breda on 14/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

class FileExporter: MMFileExport {

	/**
	 Support exporting the media collection to a file (by name).
	
	- parameter filename: somthin.
	- parameter items:
	*/
    func write(filename: String, items: [MMFile]) throws {
		
        var expFiles = [Media]()
        var mdata = [String:String]()
		
		// Fill up the Media struct with the files and metadata to save
        for f in items {
            for m in f.metadata {
                mdata.updateValue(m.value, forKey: m.keyword)
            }
            let filetoAdd = Media(fullpath: "\(f.path)/\(f.filename)", type: f.type, metadata: mdata)
            expFiles.append(filetoAdd)
        }
		
		// Determine the directory of the users
        let documentsDirectoryURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileToWrite = documentsDirectoryURL.appendingPathComponent(filename)
		
		// Serialise the data out to file
        do {
            let encodedData = try JSONEncoder().encode(expFiles)
            try encodedData.write(to: fileToWrite)
        } catch {
            print("Unable to write", error)
			print("> Unable to write JSON file...")
			print("\tCheck your last search and try again.")
        }
    }
}
