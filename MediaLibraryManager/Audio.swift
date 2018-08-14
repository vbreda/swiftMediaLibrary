//
//  Audio.swift
//  MediaLibraryManager
//
//  Created by Vivian Breda and Nikolah Pearce on 8/14/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

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
