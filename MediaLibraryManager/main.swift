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
/// - returns: The result of `readLine`.
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
        
        switch(commandString) {
        case "load" :
            command = LoadCommand(loadfiles: parts, library: library)
            break
        case "list":
            command = ListCommand(keyword: parts, library: library)
            break
        case "add":
            command = AddCommand(data: parts, library: library, previousListFound: try last.getAll())
            break
        case "set", "del", "save-search", "save":
            command = UnimplementedCommand()
            break
        case "help":
            command = HelpCommand()
            break
        case "quit":
            command = QuitCommand()
            break
        default:
            throw MMCliError.unknownCommand
        }
        
        // try execute the command and catch any thrown errors below
        try command.execute()
        try print("\(last.getAll()) ----- printshow")
        
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
