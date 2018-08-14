//
//  Image.swift
//  MediaLibraryManager
//
//  Created by Vivian Breda and Nikolah Pearce on 8/14/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

class Image : File {
    
    var resolution : String

    init(metadata: [MMMetadata], filename: String, path: String, creator: String, type: String, resolution: String) {
        self.resolution = resolution
        super.init(metadata: metadata, filename: filename, path: path, creator: creator, type: type)
    }
    
    override var description: String {
        return super.description + "resolution: \(resolution)"
    }
}
