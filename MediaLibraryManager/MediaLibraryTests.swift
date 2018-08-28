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
	var m1: [MMMetadata]
	var m2: [MMMetadata]
	
	init() {
		library = Library()
		
		let kv11: Metadata = Metadata(keyword: "creator", value: "cre1")
		let kv12: Metadata = Metadata(keyword: "resolution", value: "res1")
		let kv21: Metadata = Metadata(keyword: "creator", value: "cre2")
		let kv22: Metadata = Metadata(keyword: "resolution", value: "res2")
		
		m1 = []
		m1.append(kv11)
		m1.append(kv12)
		f1 = Image(metadata: m1, filename: "image1", path: "/346/to/", creator: "cre1", resolution: "res1")
		
		m2 = []
		m2.append(kv21)
		m2.append(kv22)
		f2 = Image(metadata: m2, filename: "image2", path: "/346/to/", creator: "cre2", resolution: "res2")
	}
	
	func setUp() {
		library = Library()
		
		let kv11: Metadata = Metadata(keyword: "creator", value: "cre1")
		let kv12: Metadata = Metadata(keyword: "resolution", value: "res1")
		let kv21: Metadata = Metadata(keyword: "creator", value: "cre2")
		let kv22: Metadata = Metadata(keyword: "resolution", value: "res2")
		
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
		testFile()
		print("\ttestFile() passed")
		tearDown()
		
		setUp()
		testMetadata()
		print("\ttestMetadata() passed")
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
		let m31 = Metadata(keyword: "key3", value: "val3")
		let m32 = Metadata(keyword: "creator", value: "testC")
		var m: [MMMetadata] = []
		m.append(m31)
		m.append(m32)
		
		let f3 = File(metadata: m, filename: "testF", path: "testP", creator: "testC")
		assert(f3.type == "document", "File should be of type document ")
		assert(f3.path == "testP", "File should have correct path")
		assert(f3.filename == "testF", "File should have correct filename ")
		assert(f3.creator == "testC", "File should have the same creator ")
		
		var metadata: [MMMetadata] = f3.metadata
		var mdata = metadata[0]
		
		assert(mdata as! Metadata == m31, "File metadata should be the same")
		assert(mdata.keyword == "key3", "File m3 Keyword should match")
		assert(mdata.value == "val3", "File m3 Value should match")
		
		assert(f3.metadata[0].keyword == "key3", "Keyword should match")
		assert(f3.metadata[0].value == "val3", "Value should match")
	}
	
	func testMetadata() {
		let m3 = Metadata(keyword: "key3", value: "val3")
		assert(m3.keyword == "key3", "Keyword should match")
		assert(m3.value == "val3", "Value should match")
	}
	
	func testAdd() {
		
	}
	
	func testAddMetadataToFile() {
		
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
