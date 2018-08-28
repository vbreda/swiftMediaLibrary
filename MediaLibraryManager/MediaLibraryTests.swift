//
//  MediaLibraryTests.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce on 28/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

/**
JSON File for testing has these contents:

[{"fullpath": "/346/to/image1","type": "image","metadata": {"creator": "cre1","resolution": "res1"}},{"fullpath": "/346/to/image2","type": "image","metadata": {"creator": "cre2","resolution": "res2"}},{"fullpath": "/346/to/video3","type": "video","metadata": {"creator": "cre3","resolution": "res3","runtime": "run3"}}]

Located in the working directory and Home Directory of user in order to test.
*/

import Foundation

class MediaLibraryTests {
	
	let numberOfTests: Int = 17
	
	var library: Library
	var f1: MMFile
	var f2: MMFile
	var f3: MMFile
	var m1: [MMMetadata]
	var m2: [MMMetadata]
	var m3: [MMMetadata]
	
	var kv11: Metadata
	var kv12: Metadata
	var kv21: Metadata
	var kv22: Metadata
	var kv31: Metadata
	var kv32: Metadata
	var kv33: Metadata
	
	init() {
		library = Library()
		kv11 = Metadata(keyword: "creator", value: "cre1")
		kv12 = Metadata(keyword: "resolution", value: "res1")
		kv21 = Metadata(keyword: "creator", value: "cre2")
		kv22 = Metadata(keyword: "resolution", value: "res2")
		kv31 = Metadata(keyword: "creator", value: "cre3")
		kv32 = Metadata(keyword: "resolution", value: "res3")
		kv33 = Metadata(keyword: "runtime", value: "run3")
		m1 = [kv11, kv12]
		m2 = [kv21, kv22]
		m3 = [kv31, kv32, kv33]
		f1 = Image(metadata: m1, filename: "image1", path: "/346/to/", creator: "cre1", resolution: "res1")
		f2 = Image(metadata: m2, filename: "image2", path: "/346/to/", creator: "cre2", resolution: "res2")
		f3 = Video(metadata: m3, filename: "video3", path: "/346/to/", creator: "cre3", resolution: "res3", runtime: "run3")
	}
	
	func setUp() {
		library = Library()
		kv11 = Metadata(keyword: "creator", value: "cre1")
		kv12 = Metadata(keyword: "resolution", value: "res1")
		kv21 = Metadata(keyword: "creator", value: "cre2")
		kv22 = Metadata(keyword: "resolution", value: "res2")
		kv31 = Metadata(keyword: "creator", value: "cre3")
		kv32 = Metadata(keyword: "resolution", value: "res3")
		kv33 = Metadata(keyword: "runtime", value: "run3")
		m1 = [kv11, kv12]
		m2 = [kv21,kv22]
		m3 = [kv31, kv32, kv33]
		f1 = Image(metadata: m1, filename: "image1", path: "/346/to/", creator: "cre1", resolution: "res1")
		f2 = Image(metadata: m2, filename: "image2", path: "/346/to/", creator: "cre2", resolution: "res2")
		f3 = Video(metadata: m3, filename: "video3", path: "/346/to/", creator: "cre3", resolution: "res3", runtime: "run3")
	}
	
	func tearDown() {
		m1 = []
		m2 = []
		f1.metadata = m1
		f2.metadata = m2
		library.removeAllFiles()
	}
	
	// Calls all tests and runs them.
	func runAllTests() {
		
		setUp()
		testMetadata()
		print("\t✅ testMetadata() passed")
		tearDown()
		
		setUp()
		testFile()
		print("\t✅ testFile() passed")
		tearDown()

		setUp()
		testAddToLibrary()
		print("\t✅ testAddToLibrary() passed")
		tearDown()
		
		setUp()
		testAddMetadataToFile()
		print("\t✅ testAddMetadataToFile() passed")
		tearDown()
		
		setUp()
		testSearch()
		print("\ttestSearch() failed")
		tearDown()

		setUp()
		testAll()
		print("\ttestAll() failed")
		tearDown()
		
		setUp()
		testFileValidator()
		print("\ttestFileValidator() failed")
		tearDown()

		setUp()
		testFileImporter()
		print("\ttestFileImporter() failed")
		tearDown()
		
		setUp()
		testFileExporter()
		print("\ttestFileExporter() failed")
		tearDown()
		
		setUp()
		testLoadCommand()
		print("\ttestLoadCommand() failed")
		tearDown()
		
		setUp()
		testListCommand()
		print("\ttestListCommand() failed")
		tearDown()
		
		setUp()
		testListAllCommand()
		print("\ttestListAllCommand() failed")
		tearDown()
		
		setUp()
		testSetCommand()
		print("\ttestSetCommand() failed")
		tearDown()
		
		setUp()
		testDeleteCommand()
		print("\ttestDeleteCommand() failed")
		tearDown()
		
		setUp()
		testSaveSearchCommand()
		print("\ttestSaveSearchCommand() failed")
		tearDown()
		
		setUp()
		testSaveCommand()
		print("\ttestSaveCommand() failed")
		tearDown()

	}
	
	func testMetadata() {
		let m3 = Metadata(keyword: "key3", value: "val3")
		assert(m3.keyword == "key3", "Keyword should match")
		assert(m3.value == "val3", "Value should match")
	}
	
	func testFile() {
		let f = Image(metadata: m1, filename: "f1", path: "p1", creator: "cre1", resolution: "res1")
		
		assert(f.type == "image", "File should be of type image")
		assert(f.path == "p1", "File should have correct path")
		assert(f.filename == "f1", "File should have correct filename ")
		assert(f.creator == "cre1", "File should have the same creator ")
		
		var metadata: [MMMetadata] = f.metadata
		var kv = metadata[0]
		var kv2 = metadata[1]
		
		assert(metadata.count == m1.count, "Metadata shold have the same size")
		
		assert(kv as! Metadata == kv11, "File metadata should be the same")
		assert(kv.keyword == "creator", "File m1 kv Keyword should match")
		assert(kv.value == "cre1", "File m1 kv Value should match")
		
		assert(kv2 as! Metadata == kv12, "File metadata should be the same")
		assert(kv2.keyword == "resolution", "File m1 kv2 Keyword should match")
		assert(kv2.value == "res1", "File m1 kv2 Value should match")
	}

	func testAddToLibrary() {
		precondition(library.count == 0, "Library should be empty.")
		
		library.add(file: f1)
		library.add(file: f2)

		var files = library.all()
		assert(library.count == 2, "Library should contain two files.")
		assert(files.count == 2, "Library should contain two files.")
		
		assert(files[0] as! File == f1 as! File,"F1 should exist in library.")
		assert(files[1] as! File == f2 as! File,"F2 should exist in library.")
	}
	
	func testAddMetadataToFile() {
		precondition(library.count == 0, "Library should be empty.")
		
		library.add(file: f1)
		assert(library.count == 1, "Library should contain one file.")
		
		var files = library.all()
		var file1 = files[0]
		var mdata: [MMMetadata] = file1.metadata
		
		assert(mdata[0] as! Metadata == kv11 , "Metadata should match original")
		assert(mdata[1] as! Metadata == kv12 , "Metadata should match original")
		assert(mdata.count == 2, "Metadata should contai only two values")
		
		let newKV: MMMetadata = Metadata(keyword: "newKey", value: "newVal")
		library.add(metadata: newKV, file: file1)
		
		assert(library.count == 1, "Library should contain one file still.")
		var newfiles = library.all()
		var newfile1 = newfiles[0]
		var newmdata: [MMMetadata] = newfile1.metadata
		
		assert(newmdata[0] as! Metadata == kv11 , "Metadata should match original")
		assert(newmdata[1] as! Metadata == kv12 , "Metadata should match original")
		assert(newmdata[2] as! Metadata == newKV , "Metadata should contain new value")
		assert(newmdata.count == 3, "Metadata should contain three values now")
		
		
	}
	
	func testRemove() {
		
	}
	
	func testSearch() {
		
	}
	
	func testAll() {
		
	}
	
	func testFileValidator() {
		
	}
	
	func testFileImporter() {
		
	}
	
	func testFileExporter() {
		
	}
	
	func testLoadCommand() {
		
	}
	
	func testListCommand() {
	}
	
	func testListAllCommand() {

	}
	
	func testSetCommand() {
		
	}
	
	func testDeleteCommand() {
		
	}
	
	func testSaveSearchCommand() {
		
	}
	
	func testSaveCommand() {
		
	}
	
}
