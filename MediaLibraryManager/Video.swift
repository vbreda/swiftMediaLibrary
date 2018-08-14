//
//  Video.swift
//  MediaLibraryManager
//
//  Created by Vivian Breda and Nikolah Pearce on 8/14/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

class Video : File {
    
    var resolution : String
    var runtime: Int
    
    init(metadata: [MMMetadata], filename: String, path: String, creator: String, resolution: String, runtime: Int) {
        self.resolution = resolution
        self.runtime = runtime
        super.init(metadata: metadata, filename: filename, path: path, creator: creator)
    }
    
    override var description: String {
        return super.description + ", resolution: \(resolution), runtime: \(runtime)"
    }
}
