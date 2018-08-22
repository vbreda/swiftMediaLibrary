//
//  FileTypes.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce and Vivian Breda on 22/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

class Image : File {
    
    var resolution : String
    
    init(metadata: [MMMetadata], filename: String, path: String, creator: String, resolution: String) {
        self.resolution = resolution
        super.init(metadata: metadata, filename: filename, path: path, creator: creator)
    }
    
    override var description: String {
        return super.description + ", resolution: \(resolution)"
    }
}

class Video : File {
    
    var resolution : String
    var runtime: String
    
    init(metadata: [MMMetadata], filename: String, path: String, creator: String, resolution: String, runtime: String) {
        self.resolution = resolution
        self.runtime = runtime
        super.init(metadata: metadata, filename: filename, path: path, creator: creator)
    }
    
    override var description: String {
        return super.description + ", resolution: \(resolution), runtime: \(runtime)"
    }
}

class Audio : File {
    
    var runtime: String
    
    init(metadata: [MMMetadata], filename: String, path: String, creator: String, runtime: String) {
        self.runtime = runtime
        super.init(metadata: metadata, filename: filename, path: path, creator: creator)
    }
    
    override var description: String {
        return super.description + ", runtime: \(runtime)"
    }
}

class Document : File {
    
    
}
