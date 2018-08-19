//
//  main.swift
//  MediaLibraryManager
//
//  Created by Paul Crane on 18/06/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

/// Generate a friendly prompt and wait for the user to enter a line of input
/// - parameter prompt: The prompt to use
/// - parameter strippingNewline: Strip the newline from the end of the line of
///   input (true by default)
/// - return: The result of `readLine`.
/// - seealso: readLine
func prompt(_ prompt: String, strippingNewline: Bool = true) -> String? {
	print(prompt, terminator:"")
	return readLine(strippingNewline: strippingNewline)
}

var library : Library = Library()

var last = MMResultSet()

while let line = prompt("> ") {
	var commandString : String = ""
	var parts = line.split(separator: " ").map({String($0)})
	var command: MMCommand
	
	do {
		
		guard parts.count > 0 else {
			throw MMCliError.unknownCommand
		}
		
		commandString = parts.removeFirst();
		
		switch(commandString){
		case "load" :
			
			let oldCount = Library.files.count
			let fileName: String

			// Ensure the user passed at least one parameter
			guard parts.count > 0 else {
				throw MMCliError.invalidParameters
			}
			
			fileName = parts.removeFirst()

			//print ("Provided file: \(fileName)")
			
			// Pass the file to an importer instance
			let importer : FileImporter = FileImporter()
			let newFiles : [MMFile] = try importer.read(filename: fileName)
			
			for f in newFiles {
				library.add(file: f)
			}
			
			//Library.files = newFiles

			// Confirm to the user that the Library grew in size
			let newCount = Library.files.count
			if newCount >= oldCount {
				print ("\(newCount-oldCount) files loaded successfully.")
			}
			
			command = UnneededCommand()
			break;
		case "list", "add", "set", "del", "save-search", "save":
			command = UnimplementedCommand()
			break
		case "help":
			command = HelpCommand()
			break
		case "quit":
			command = QuitCommand()
			break
		default:
			command = UnneededCommand()
			throw MMCliError.unknownCommand
		}
		
		// try execute the command and catch any thrown errors below
		try command.execute()
		
		// if there are any results from the command, print them out here
		if let results = command.results {
			results.show()
			last = results
		}
		
	} catch MMCliError.unknownCommand {
		print("command \"\(commandString)\" not found -- see \"help\" for list")
	} catch MMCliError.invalidParameters {
		print("invalid parameters for \"\(commandString)\" -- see \"help\" for list")
	} catch MMCliError.unimplementedCommand {
		print("\"\(commandString)\" is unimplemented")
	} catch MMCliError.missingResultSet {
		print("no previous results to work from... ")
	} catch MMCliError.unneededCommand {
		print("")
	}
}

// The while-loop below implements a basic command line interface. Some
// examples of the (intended) commands are as follows:
//
// load foo.json bar.json
//  from the current directory load both foo.json and bar.json and
//  merge the results
//
// list foo bar baz
//  results in a set of files with metadata containing foo OR bar OR baz
//
// add 3 foo bar
//  using the results of the previous list, add foo=bar to the file
//  at index 3 in the list
//
// add 3 foo bar baz qux
//  using the results of the previous list, add foo=bar and baz=qux
//  to the file at index 3 in the list
