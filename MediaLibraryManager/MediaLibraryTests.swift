//
//  MediaLibraryTests.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce on 28/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

/**
tst.json contains:

[{"fullpath": "/346/to/image1","type": "image","metadata": {"creator": "cre1","resolution": "res1"}},{"fullpath": "/346/to/image2","type": "image","metadata": {"creator": "cre2","resolution": "res2"}},{"fullpath": "/346/to/video3","type": "video","metadata": {"creator": "cre3","resolution": "res3","runtime": "run3"}}]

test2.json contains:

[{"fullpath": "/346/to/doc1","type": "document","metadata": {"creator": "cre1"}},{"fullpath": "/346/to/doc2","type": "document","metadata": {"creator": "cre2"}},{"fullpath": "/346/to/vid3","type": "video","metadata": {"creator": "cre3","resolution": "res3","runtime": "run3"}}]

Located in the working directory and Home Directory of user in order to test.
*/

import Foundation

/**
Runs tests that ignore user prompt.
Exhausts all action paths in MediaLibrary project.
*/
class MediaLibraryTests {
	
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
	
	/**
	Initialiser that sets all datafields to base form
	*/
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
		f1 = Image(metadata: m1, filename: "image1", path: "/346/to", creator: "cre1", resolution: "res1")
		f2 = Image(metadata: m2, filename: "image2", path: "/346/to", creator: "cre2", resolution: "res2")
		f3 = Video(metadata: m3, filename: "video3", path: "/346/to", creator: "cre3", resolution: "res3", runtime: "run3")
	}
	
	/**
	Set up called before each tests.
	Ensures all data fields in their base form.
	*/
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
		f1 = Image(metadata: m1, filename: "image1", path: "/346/to", creator: "cre1", resolution: "res1")
		f2 = Image(metadata: m2, filename: "image2", path: "/346/to", creator: "cre2", resolution: "res2")
		f3 = Video(metadata: m3, filename: "video3", path: "/346/to", creator: "cre3", resolution: "res3", runtime: "run3")
	}
	
	/**
	Tear down called after each test.
	Ensure state is restored to base.
	*/
	func tearDown() {
		m1 = []
		m2 = []
		m3 = []
		f1.metadata = m1
		f2.metadata = m2
		f3.metadata = m3
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
		testRemove()
		print("\t✅ testRemove() passed")
		tearDown()
		
		setUp()
		testRemoveAllFiles()
		print("\t✅ testRemoveAllFiles() passed")
		tearDown()
		
		setUp()
		testSearch()
		print("\t✅ testSearch() passed")
		tearDown()

		setUp()
		testAll()
		print("\t✅ testAll() passed")
		tearDown()
		
		setUp()
		testFileValidator()
		print("\t❌ testFileValidator() passed")
		tearDown()

		setUp()
		testFileImporter()
		print("\t✅ testFileImporter() passed")
		tearDown()
		
		setUp()
		testFileExporter()
		print("\t❌ testFileExporter() passed")
		tearDown()
		
		setUp()
		testListCommand()
		print("\t✅ testListCommand() passed")
		tearDown()
		
		setUp()
		testListAllCommand()
		print("\t✅ testListAllCommand() passed")
		tearDown()
		
		setUp()
		testSetCommand()
		print("\t❌ testSetCommand() passed")
		tearDown()
		
		setUp()
		testDeleteCommand()
		print("\t❌ testDeleteCommand() passed")
		tearDown()
		
		setUp()
		testSaveSearchCommand()
		print("\t❌ testSaveSearchCommand() passed")
		tearDown()
		
		setUp()
		testSaveCommand()
		print("\t❌ testSaveCommand() passed")
		tearDown()

		setUp()
		testLoadCommand()
		print("\t✅ testLoadCommand() passed")
		tearDown()
	}
	
	/**
	Tests that creating a Metadata works as it should.
	*/
	func testMetadata() {
		let m3 = Metadata(keyword: "key3", value: "val3")
		assert(m3.keyword == "key3", "Keyword should match")
		assert(m3.value == "val3", "Value should match")
	}
	
	/**
	Tests that creating a File works as it should.
	*/
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

	/**
	Tests that adding a file to the Library works as it should.
	*/
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
	
	/**
	Tests that adding metadata to a file works as it should.
	*/
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
	
	/**
	Tests that removing a metadata from a file works as it should.
	*/
	func testRemove() {
		precondition(library.count == 0, "Library should be empty.")
		precondition(f1.metadata.count == 2, "f1 Metadata 1 should have two kv pairs.")
		precondition(m1.count == 2, "Metadata 1 should have two kv pairs.")
		
		let newKV: Metadata = Metadata(keyword: "test", value: "test1")
		let dummyKV: Metadata = Metadata(keyword: "dummy", value: "dummy1")
		
		m1.append(newKV)
		f1.metadata.append(newKV)
		library.add(file: f1)
		library.add(file: f2)
		
		assert(library.count == 2, "Library should contain two files.")
		assert(f1.metadata.count == 3, "f1 Metadata 1 should have three kv pairs.")
		assert(m1.count == 3, "Metadata 1 should have three kv pairs.")
		
		// remove not existing shouldn't crash
		library.remove(key: dummyKV.keyword, file: f1)
		assert(f1.metadata.count == 3, "f1 Metadata 1 should have three kv pairs still.")
		
		// remove a required should still be there
		// - except this check is never done in Library, only in DeleteCommand.
		//library.remove(key: kv11.keyword, file: f1)
		//assert(f1.metadata.count == 3, "f1 Metadata 1 should have three kv pairs still.")
		
		// remove existing should work
		library.remove(key: newKV.keyword, file: f1)
		assert(library.count == 2, "Library should contain two files.")
		assert(f1.metadata.count == 2, "f1 Metadata 1 should have two kv pairs after removing.")
		assert(m1.count == 3, "Metadata 1 should have three kv pairs.")
	}
	
	/**
	Tests that remove all files in library is working
	*/
	func testRemoveAllFiles() {
		precondition(library.count == 0, "Library should be empty.")
		library.add(file: f1)
		library.add(file: f2)
		assert(library.count == 2, "Library should contain two files.")
		library.removeAllFiles()
		assert(library.count == 0, "Library should contain 0 files after removing.")
	}
	
	/**
	Tests that searching for terms in metadata works as it should.
	*/
	func testSearch() {
		precondition(library.count == 0, "Library should be empty.")
		library.add(file: f1)
		library.add(file: f2)
		assert(library.count == 2, "Library should contain two files.")

		// search for value should return 1 file
		var result: [MMFile] = library.search(term: "cre1")
		assert(result.count == 1, "search for value cre1 should return 1 file")
		assert(result[0] as! File == f1, "results should be f1")
		
		//search for requried mdata should return 2 files
		result = library.search(term: "creator")
		assert(result.count == 2, "search for key creator should return 2 files")
		assert(result[0] as! File == f1, "results should be f1")
		assert(result[1] as! File == f2, "results should be f2")
		
		// search for non existing should return nil
		result = library.search(term: "test")
		assert(result.count == 0, "search should be 0 files")
		
		// TODO
		// search for added metadata should return f1
//		let newKV: MMMetadata = Metadata(keyword: "newKey", value: "newVal")
//		library.add(metadata: newKV, file: f1)
//		assert(library.count == 2, "Library should contain two files.")
//		result = library.search(term: "newVal")
//		assert(result.count == 1, "search should be 1 file")
//		assert(result[0] as! File == f1, "search should be 1 file")
//		result = library.search(term: "newKey")
//		assert(result.count == 1, "search should be 1 file")
//		assert(result[0] as! File == f1, "search should be 1 file")
//
		// Search for removed metadata should return nil
//		library.remove(key: "newKey", file: f1)
//		result = library.search(term: "newVal")
//		assert(result.count == 0, "search should be 0 files")
//		result = library.search(term: "newKey")
//		assert(result.count == 0, "search should be 0 files")
	}
	
	/**
	Tests that the get all files in Library works as it should.
	*/
	func testAll() {
		precondition(library.count == 0, "Library should be empty.")
		library.add(file: f1)
		library.add(file: f2)
		assert(library.count == 2, "Library should contain two files.")
		
		var result = library.all()
		assert(result.count == 2, "search for key creator should return 2 files")
		assert(result[0] as! File == f1, "results should be f1")
		assert(result[1] as! File == f2, "results should be f2")
		
		library.add(file: f3)
		result = library.all()
		assert(result.count == 3, "search for key creator should return 2 files")
		assert(result[0] as! File == f1, "results should be f1")
		assert(result[1] as! File == f2, "results should be f2")
		assert(result[2] as! File == f3, "results should be f3")
	}
	
	/**
	Tests that the file validator works as it should.
	e.g. does not validate invalid files
	*/
	func testFileValidator() {
		
	}
	
	/**
	Tests that the file importer and read function works as it should.
	*/
	func testFileImporter() {
		let testFilename = "test.json"
		let testHomeFilename = "~/test.json"
		let dummyFilename = "doesntexist.json"
		
		let importer: FileImporter = FileImporter()
		var results: [MMFile] = []
		
		precondition(results.count == 0, "results should be empty.")

		do {
			// import from working directory should work
			results = try importer.read(filename: testFilename)
			assert(results.count == 3, "Results should have three files after read.")
			assert(results[0] as! File == f1, "results should be f1")
			assert(results[1] as! File == f2, "results should be f2")
			assert(results[2] as! File == f3, "results should be f3")
			
			// import from home directory also should work
			results = try importer.read(filename: testHomeFilename)
			assert(results.count == 3, "Results should have three files after read.")
			assert(results[0] as! File == f1, "results should be f1")
			assert(results[1] as! File == f2, "results should be f2")
			assert(results[2] as! File == f3, "results should be f3")
			
			// import from full path should work as well - but cannot test automatically
			
			// import from nonexist file should fail
			results = []
			results = try importer.read(filename: dummyFilename)
			
		} catch {
			assert(results.count == 0, "No files should be returned")
		}
	}
	
	/**
	Tests that file exporter works as it should.
	*/
	func testFileExporter() {
		
	}
	
	/**
	Tests that the load command works as it should.
	*/
	func testLoadCommand() {
		precondition(library.count == 0, "Library should be empty.")

		let testFilename = "test.json"
		let testHomeFilename = "test2.json"
		let dummyFilename = "doesntexist.json"
		
		let oneFile: [String] = [testFilename]
		let twoFiles: [String] = [testFilename, testHomeFilename]
		let dummyFile: [String] = [dummyFilename]
		
		var command: MMCommand
		
		do {
			// Test working directory file loads
			command = LoadCommand(loadfiles: oneFile, library: library)
			try command.execute()
			assert(library.count == 3, "Library should be contain 3 files after loading.")
			library.removeAllFiles()
			assert(library.count == 0, "Library should be contain 0 files.")
			
			// Test home directory file loads
			command = LoadCommand(loadfiles: twoFiles, library: library)
			try command.execute()
			assert(library.count == 6, "Library should be contain 6 files after loading.")
			library.removeAllFiles()
			assert(library.count == 0, "Library should be contain 0 files.")
			
			// Test invalid file does not load
			command = LoadCommand(loadfiles: dummyFile, library: library)
			do {
				try command.execute()
			} catch {
				assert(library.count == 0, "Library should be contain 0 files.")
			}
			
		} catch {
			assertionFailure()
		}
	}
	
	/**
	Tests that the list command works as it should.
	*/
	func testListCommand() {
		precondition(library.count == 0, "Library should be empty.")
		library.add(file: f1)
		library.add(file: f2)
		assert(library.count == 2, "Library should contain two files.")
		
		var command: MMCommand
		var results: [MMFile]
		var rSet: MMResultSet
		do {
			// Test listing via key
			command = ListCommand(keyword: ["creator"], library: library)
			try command.execute()
			rSet = command.results!
			results = try rSet.getAll()
			assert(results.count == 2, "results should be two files")
			
			// Test listing via value
			command = ListCommand(keyword: ["cre1"], library: library)
			try command.execute()
			rSet = command.results!
			results = try rSet.getAll()
			assert(results.count == 1, "results should be 1 file")
			assert(results[0] as! File == f1, "File found should be f1")
			
			// Test listing results to two terms
			command = ListCommand(keyword: ["cre1", "cre2"], library: library)
			try command.execute()
			rSet = command.results!
			results = try rSet.getAll()
				//TODO
//			assert(results.count == 2, "results should be two files")
			

			// Test listing results for terms that dont exist
			command = ListCommand(keyword: ["none"], library: library)
			var errorThrown: Bool = false
			do {
				try command.execute()
			} catch {
				errorThrown = true
				if (command.results) != nil {
					assertionFailure("No results should exist")
				}
			}
			assert(errorThrown, "Data doesnt exist error should have been thrown")
			
			// TODO
			// Test listing results for one exist one not
//			errorThrown = false
//			command = ListCommand(keyword: ["cre1", "none"], library: library)
//			do {
//				try command.execute()
//			} catch {
//				errorThrown = true
//				rSet = command.results!
//				results = try rSet.getAll()
//				assert(results.count == 1, "results should be 1 file")
//			}
//			assert(errorThrown, "Error should have been thrown")
			
			// TODO
			// Test listing for added metadata
//			let newKV: MMMetadata = Metadata(keyword: "newKey", value: "newVal")
//			library.add(metadata: newKV, file: f1)
//			command = ListCommand(keyword: ["newKey"], library: library)
//			do {
//				try command.execute()
//			} catch {
//				assertionFailure()
//			}
//			rSet = command.results!
//			results = try rSet.getAll()
//			assert(results.count == 1, "results should be 1 file")
//			assert(results[0] as! File == f1, "File found should be f1")
//			print("inside")
			
			
			// Test listing for removed metadata
			errorThrown = false
			library.remove(key: "newKey", file: f1)
			command = ListCommand(keyword: ["newKey"], library: library)
			do {
				try command.execute()
			} catch {
				errorThrown = true
			}
			assert(errorThrown, "Data doesnt exist error should have been thrown")
		} catch {
			assertionFailure()
		}
		
	}
	
	/**
	Tests that the list all command works as it should.
	*/
	func testListAllCommand() {
		precondition(library.count == 0, "Library should be empty.")
		library.add(file: f1)
		library.add(file: f2)
		assert(library.count == 2, "Library should contain two files.")
		
		var command: MMCommand
		var results: [MMFile]
		var rSet: MMResultSet
		do {
			command = ListCommand(keyword: [], library: library)
			try command.execute()
			rSet = command.results!
			results = try rSet.getAll()
			assert(results.count == 2, "Entire library should be returned")
		} catch {
			assertionFailure()
		}
	}
	
	/**
	Tests that the set command works as it should.
	*/
	func testSetCommand() {
		precondition(library.count == 0, "Library should be empty.")
		library.add(file: f1)
		library.add(file: f2)
		assert(library.count == 2, "Library should contain two files.")
		
		var command: MMCommand
		do {
//			command =
//				try command.execute()
		} catch {
			assertionFailure()
		}
	}
	
	/**
	Tests that the delete command works as it should.
	*/
	func testDeleteCommand() {
		precondition(library.count == 0, "Library should be empty.")
		library.add(file: f1)
		library.add(file: f2)
		assert(library.count == 2, "Library should contain two files.")
		
		var command: MMCommand
		do {
//			command =
//				try command.execute()
		} catch {
			assertionFailure()
		}
	}
	
	/**
	Tests that the save search command works as it should.
	*/
	func testSaveSearchCommand() {
		precondition(library.count == 0, "Library should be empty.")
		library.add(file: f1)
		library.add(file: f2)
		assert(library.count == 2, "Library should contain two files.")
		
		var command: MMCommand
		do {
//			command =
//				try command.execute()
		} catch {
			assertionFailure()
		}
	}
	
	/**
	Tests that the save command works as it should.
	*/
	func testSaveCommand() {
		precondition(library.count == 0, "Library should be empty.")
		library.add(file: f1)
		library.add(file: f2)
		assert(library.count == 2, "Library should contain two files.")
		
	
		var command: MMCommand
		do {
//			command = SaveCommand(data: )
//			try command.execute()
		} catch {
			assertionFailure()
		}
	}
	
}
