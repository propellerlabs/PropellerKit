//
//  FlickrResult.swift
//  FlickrExample
//
//  Created by Roy McKenzie on 2/10/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import Foundation
import JSONCodable
import PropellerNetwork

struct FlickrResult {
    let page: Int
    let photos: [FlickrPhoto]
}

extension FlickrResult: JSONCodable {
    
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        do {
            self.page = try decoder.decode("photos.page")
            self.photos = try decoder.decode("photos.photo")
        } catch {
            throw error
        }
    }
}

extension FlickrResult {
    
    static func search(query: String) -> Resource<FlickrResult> {
        let params: Parameters = [
            "text" : query,
            "method": "flickr.photos.search",
            "format": "json",
            "nojsoncallback": 1
        ]
        return FlickrResult.resource(configuration: NetworkConfiguration.default, urlPath: "", parameters: params,encoding: QueryStringEncoder.default)
    }
}


struct FlickrPhoto {
    let id: String
    let title: String
    let farm: Int
    let secret: String
    let server: String
}

extension FlickrPhoto {
    
    private var urlPath: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
    var url: URL? {
        return URL(string: urlPath)
    }
}

extension FlickrPhoto: JSONCodable {
    
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        do {
            self.id = try decoder.decode("id")
            self.title = try decoder.decode("title")
            self.farm = try decoder.decode("farm")
            self.secret = try decoder.decode("secret")
            self.server = try decoder.decode("server")
        } catch {
            throw error
        }
    }
}
