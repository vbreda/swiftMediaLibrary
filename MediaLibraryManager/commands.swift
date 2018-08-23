//
//  commands.swift
//  MediaLibraryManager
//
//  Created by Paul Crane on 15/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

// I'm reusing the MMCliError enum and MMResultSet class. If you want to
// *replace* the cli.swift, then you need to uncomment the parts below. If you
// *add* this file to your project, you can leave it as is.

/// The list of exceptions that can be thrown by the CLI command handlers
enum MMCliError: Error {
    
    /// Thrown if there is something wrong with the input parameters for the command
    case invalidParameters
    
    /// Thrown if there is no result set to work with (and this command depends
    /// on the previous command)
    case missingResultSet
    
    /// Thrown when the command is not understood
    case unknownCommand
    
    /// Thrown if the command has yet to be implemented
    /// - Note: You'll need to implement these to get the CLI working properly
    case unimplementedCommand
}

/// This class represents a set of results. It could be extended to include
/// the command and a history of commands and the results.

class MMResultSet {
    
    /// The list of files produced by the command
    fileprivate var results: [MMFile]
    
    /// Constructs a new result set.
    /// - parameter results: the list of files produced by the executed
    /// command, could be empty.
    init(_ results:[MMFile]){
        self.results = results
    }
    /// Constructs a new result set with an empty list.
    convenience init(){
        self.init([MMFile]())
    }
    
    /// If there are some results to show, enumerate them and print them out.
    /// - note: this enumeration is used to identify the files in subsequent
    /// commands.
    func show(){
        guard self.results.count > 0 else{
            return
        }
        for (i,file) in self.results.enumerated() {
            print("\(i): \(file)")
        }
    }
    
    func get(index: Int) throws -> MMFile{
        return self.results[index]
    }
    
    func getAll() throws -> [MMFile] {
        return self.results
    }
}


/// This protocol specifies the new 'Command' pattern, and is more
/// Object Oriented.
protocol MMCommand {
    var results: MMResultSet? {get}
    func execute() throws
}

// The main difference between this and the previous style is that to use this
// style you first create an instance of the command:
//
//      var command = ListCommand(library, terms)
//
// then you call execute on that instance:
//
//      command.execute()
//
// and finally, the results are stored within the command object:
//
//      command.results?
//
//
// This means that the execute function doesn't need to know about all the
// possible combinations of parameters, libraries, previous result sets. This
// is the problem with the previous implementation. Previously, if *any*
// command needed to have previous result sets, then they *all* needed to know
// about it.

/// Handle unimplemented commands by throwing an exception when trying to
/// execute this command.
class UnimplementedCommand: MMCommand {
    var results: MMResultSet? = nil
    func execute() throws {
        throw MMCliError.unimplementedCommand
    }
}

/// Handle the help command.
class HelpCommand: MMCommand {
    var results: MMResultSet? = nil
    func execute() throws{
        print("""
\thelp                              - this text
\tload <filename> ...               - load file into the collection
\tlist <term> ...                   - list all the files that have the term specified
\tlist                              - list all the files in the collection
\tadd <number> <key> <value> ...    - add some metadata to a file
\tset <number> <key> <value> ...    - this is really a del followed by an add
\tdel <number> <key> ...            - removes a metadata item from a file
\tsave-search <filename>            - saves the last list results to a file
\tsave <filename>                   - saves the whole collection to a file
\tquit                              - exit the program (without prompts)
""")
        // for example:
        
        // load foo.json bar.json
        //      from the current directory load both foo.json and bar.json and
        //      merge the results
        
        // list foo bar baz
        //      results in a set of files with metadata containing foo OR bar OR baz
        
        // add 3 foo bar
        //      using the results of the previous list, add foo=bar to the file
        //      at index 3 in the list
        
        // add 3 foo bar baz qux
        //      using the results of the previous list, add foo=bar and baz=qux
        //      to the file at index 3 in the list
        
        // set 0 keyword newValue differentKeyword anotherNewValu
        
        // list val1 key1 val2
        // show any file/metadata with KEYWORD or VALUE val1/key1/val2. 
    }
}

/// Handle the quit command. Exits the program (with exit code 0) without
/// checking if there is anything to save.
class QuitCommand : MMCommand {
    var results: MMResultSet? = nil
    func execute() throws{
        exit(0)
    }
}

// Handle the load command. It loads files into the collection.
// TODO make load work with multiple calls.
class LoadCommand: MMCommand {
    var results: MMResultSet? = nil
    var library : Library
    
    var loadfiles : [String]
    
    /**
     Constructs a new load file handler.
     
     - parameter files: the file to be loaded.
     - parameter library: the target collection.
     */
    init(loadfiles: [String], library: Library) {
        self.library = library
        self.loadfiles = loadfiles
    }
    
    func execute() throws {
        let oldCount = library.count
        let importer : FileImporter = FileImporter()
        var newFiles : [MMFile] = []
        
        // Ensure the user passed at least one parameter
        guard loadfiles.count > 0 else {
            throw MMCliError.invalidParameters
        }
        
        // While there are filenames to read from
        var i = loadfiles.count
        while i > 0 {
            
            // Get the filename from the parameters
            let fileName: String = loadfiles.removeFirst()
            
            // Pass the file to the importer
            newFiles = try importer.read(filename: fileName)
            
            // Add the files to the library
            for f in newFiles {
                library.add(file: f)
            }
            i = i-1
        }
        
        // Confirm to the user that the Library grew in size
        let newCount = library.count
        let diff = newCount-oldCount
        print ("\(diff) files loaded successfully.")
        if newCount > oldCount {
            // Print out the names of the added files
            var allFiles = library.all()
            for i in library.count-diff...library.count-1 {
                print("\(i+1): \(allFiles[i].filename)")
            }
        }
    }
}

// Handle the list command. It lists all the files contained in the collection.
class ListCommand : MMCommand {
    var results: MMResultSet? = nil
    var library: Library
    var keywords: [String]
    
    /**
     Constructs a new list handler.
     
     - parameter keyword: filter the files according to the given keyword.
     - parameter library: the collection from which the files will be listed.
     */
    
    init(keyword: [String], library: Library) {
        self.keywords = keyword;
        self.library = library
    }
    
    func execute() throws {
        
        // lists all the files in the library ("list")
        if (keywords.count == 0) {
            print(library)
            let allFiles = library.all()
            self.results = MMResultSet(allFiles)
            
            // lists all the files that have the given term ("list <term>")
        } else {
            let word: String = keywords.removeFirst()
            
            //TODO implement search in Library.swift
            let listresults = library.search(term: word)
            print("Using search")
            self.results = MMResultSet(listresults)
        }
    }
}

// Handle the add command. It add the given metadata to the file at given position.
class AddCommand : MMCommand{
    var results: MMResultSet? = nil
    var library: Library
    var data: [String]
    var previousListFound: [MMFile]
    
    /**
     Constructs a new add handler.
     
     - parameter data: the position of file and metadata to be added.
     - parameter library: the collection from which the files will be listed.
     */
    init(data: [String], library: Library, previousListFound: [MMFile]) {
        self.data = data
        self.library = library
        self.previousListFound = previousListFound
    }
    
    func execute() throws {
        // Ensure the user passed at least two parameters.
        guard data.count > 2 else {
            throw MMCliError.invalidParameters
        }
        
        let index = Int(data.removeFirst())!
        //TODO put in a while loop so adds more than one metadata
        let key = data.removeFirst()
        let value = data.removeFirst()
        let newdata = Metadata(keyword: key, value: value)
        let fileToAddTo = previousListFound[index]
        print("Adding to file: \(fileToAddTo)")
        
        //TODO implement add(metadata)
        library.add(metadata: newdata, file: fileToAddTo)
        print("Add seems to be working") //test
        print("Index: \(index), Key: \(key), Value: \(value)") //test
    }
}

class SetCommand : MMCommand{
    var results: MMResultSet? = nil
    var library: Library
    var data: [String]
    var previousListFound: [MMFile]
    
    /**
     Constructs a new set handler.
     
     - parameter data: the position of file and metadata to be added.
     - parameter library: the collection from which the files will be listed.
     */
    init(data: [String], library: Library, previousListFound: [MMFile]) {
        self.data = data
        self.library = library
        self.previousListFound = previousListFound
    }
    
    func execute() throws {
        // Ensure the user passed at least two parameters
        guard data.count > 2 else {
            throw MMCliError.invalidParameters
        }
        
        //TODO add a loop to set more than one at a time.
        let index = Int(data.removeFirst())!
        let key : String = data.removeFirst()
        let valueToModify : String = data.removeFirst()
        let dataToAdd = Metadata(keyword: key, value: valueToModify)
        let fileToModify : MMFile = previousListFound[index]
        let fileMetadata : [MMMetadata] = fileToModify.metadata
        
        
        //TODO throw an exception isntead of using i
        var i = 0
        for d in fileMetadata {
            if (d.keyword == key) {
                library.remove(metadata: d, file: fileToModify)
                library.add(metadata: dataToAdd, file: fileToModify)
                i = 1
            }
        }
        if (i == 0) {
            print ("Keyword not found.")
        }
    }
}

class DeleteCommand : MMCommand{
    var results: MMResultSet? = nil
    var library: Library
    var data: [String]
    var previousListFound: [MMFile]
    
    init(data: [String], library: Library, previousListFound: [MMFile]) {
        self.data = data
        self.library = library
        self.previousListFound = previousListFound
    }
    
    func execute() throws {
        // Ensure the user passed at least two parameters
        guard data.count > 2 else {
            throw MMCliError.invalidParameters
        }
        
        //TODO add a loop to delete more than one at a time.
        let index = Int(data.removeFirst())!
        let key : String = data.removeFirst()
        let valueToDel : String = data.removeFirst()
        let dataToDel = Metadata(keyword: key, value: valueToDel)
        let delFile : MMFile = previousListFound[index]
        
        library.remove(metadata: dataToDel, file: delFile)
    }
}
