//
//  MediaLibraryTests.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce on 28/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

class MediaLibraryTests {
	
	let numberOfTests: Int = 17
	
	var library: Library
	var f1: MMFile
	var f2: MMFile
	var m1: [MMMetadata] = []
	var m2: [MMMetadata] = []
	
	let kv11: Metadata = Metadata(keyword: "creator", value: "cre1")
	let kv12: Metadata = Metadata(keyword: "resolution", value: "res1")
	let kv21: Metadata = Metadata(keyword: "creator", value: "cre2")
	let kv22: Metadata = Metadata(keyword: "resolution", value: "res2")
	
	init() {
		library = Library()

		m1.append(kv11)
		m1.append(kv12)
		f1 = Image(metadata: m1, filename: "image1", path: "/346/to/", creator: "cre1", resolution: "res1")

		m2.append(kv21)
		m2.append(kv22)
		f2 = Image(metadata: m2, filename: "image2", path: "/346/to/", creator: "cre2", resolution: "res2")
	}
	
	func setUp() {
		library = Library()
		
		m1 = []
		m1.append(kv11)
		m1.append(kv12)
		f1 = Image(metadata: m1, filename: "image1", path: "/346/to/", creator: "cre1", resolution: "res1")
		
		m2 = []
		m2.append(kv21)
		m2.append(kv22)
		f2 = Image(metadata: m2, filename: "image2", path: "/346/to/", creator: "cre2", resolution: "res2")
	}
	
	func tearDown() {
		library.removeAllFiles()
	}
	
	// Calls all tests and runs them.
	func runAllTests() {
		
		setUp()
		testMetadata()
		print("\ttestMetadata() passed")
		tearDown()
		
		setUp()
		testFile()
		print("\ttestFile() passed")
		tearDown()

		setUp()
		testAdd()
		print("\ttestAdd() passed")
		tearDown()
		
		setUp()
		testAddMetadataToFile()
		print("\ttestAddMetadataToFile() passed")
		tearDown()
		
		setUp()
		
		tearDown()
		
		setUp()
		
		tearDown()
		
		setUp()
		
		tearDown()

	}
	
	func testFile() {
		
		let kv11: Metadata = Metadata(keyword: "creator", value: "cre1")
		let kv12: Metadata = Metadata(keyword: "resolution", value: "res1")
		
		var m: [MMMetadata] = []
		m.append(kv11)
		m.append(kv12)
		
		let f = Image(metadata: m, filename: "f1", path: "p1", creator: "cre1", resolution: "res1")
		
		assert(f.type == "image", "File should be of type image")
		assert(f.path == "p1", "File should have correct path")
		assert(f.filename == "f1", "File should have correct filename ")
		assert(f.creator == "cre1", "File should have the same creator ")
		
		var metadata: [MMMetadata] = f.metadata
		var kv = metadata[0]
		var kv2 = metadata[1]
		
		assert(kv as! Metadata == kv11, "File metadata should be the same")
		assert(kv.keyword == "creator", "File m3 Keyword should match")
		assert(kv.value == "cre1", "File m3 Value should match")
		assert(kv2 as! Metadata == kv12, "File metadata should be the same")
		assert(kv2.keyword == "resolution", "File m3 Keyword should match")
		assert(kv2.value == "res1", "File m3 Value should match")
		
	}
	
	func testMetadata() {
		let m3 = Metadata(keyword: "key3", value: "val3")
		assert(m3.keyword == "key3", "Keyword should match")
		assert(m3.value == "val3", "Value should match")
	}
	
	func testAdd() {
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
