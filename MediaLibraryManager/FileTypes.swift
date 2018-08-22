//
//  FileTypes.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce and Vivian Breda on 22/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

/**
Image class extends file.
Required metadata fields: creator and resolution
*/
class Image : File {
	
	// the resolution of the image, as specified at load time
    var originalResolution : String
	
	// the image's current resolution
	var resolution : String? {
		var res: String?
		for m in metadata {
			if m.keyword.lowercased() == "resolution" {
				//return m.keyword
				res = m.keyword
			}
		}
		return res
	}
    
    init(metadata: [MMMetadata], filename: String, path: String, creator: String, resolution: String) {
        self.originalResolution = resolution
        super.init(metadata: metadata, filename: filename, path: path, creator: creator)
    }
	
    override var description: String {
        return super.description + ", resolution: \(resolution)"
    }
}

/**
Video class extends file.
Required metadata fields: creator, resolution and runtime.
*/
class Video : File {
	
	// the resolution of the video, as specified at load time
    var originalResolution : String
	
	// the runtime of the video, as specified at load time
    var originalRuntime: String
	
	// the video's current resolution
	var resolution : String {
		for m in metadata {
			if m.keyword.lowercased() == "resolution" {
				return m.keyword
			}
		}
	}
	
	// the video's current runtime
	var runtime : String {
		for m in metadata {
			if m.keyword.lowercased() == "runtime" {
				return m.keyword
			}
		}
	}
	
    init(metadata: [MMMetadata], filename: String, path: String, creator: String, resolution: String, runtime: String) {
        self.originalResolution = resolution
        self.originalRuntime = runtime
        super.init(metadata: metadata, filename: filename, path: path, creator: creator)
    }
	
    override var description: String {
        return super.description + ", resolution: \(resolution), runtime: \(runtime)"
    }
}

/**
Audio class extends file.
Required metadata fields: creator and runtime
*/
class Audio : File {
	
	// the runtime of the audio, as specified at load time
    var originalRuntime: String
	
	// the audio's current runtime
	var runtime : String {
		for m in metadata {
			if m.keyword.lowercased() == "runtime" {
				return m.keyword
			}
		}
	}
	
    init(metadata: [MMMetadata], filename: String, path: String, creator: String, runtime: String) {
        self.originalRuntime = runtime
        super.init(metadata: metadata, filename: filename, path: path, creator: creator)
    }
	
    override var description: String {
        return super.description + ", runtime: \(runtime)"
    }
}

/**
Audio class extends file.
Required metadata fields: creator
*/
class Document : File {
    
    
}
