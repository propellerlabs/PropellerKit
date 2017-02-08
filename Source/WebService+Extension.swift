//
//  WebService+Extension.swift
//  PropellerKit
//
//  Created by Roy McKenzie on 2/3/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import Foundation
import PropellerNetwork
import PropellerPromise

extension WebService {
    
    /// Request a `Resource<A>` by returning a Promise
    /// - Parameters: 
    ///     - resource: The `Resource<A>` to request
    /// - Returns: `Promise<A>`
    public static func request<A>(_ resource: Resource<A>) -> Promise<A> {
        let promise = Promise<A>()
        request(resource) { object, error in
            if let error = error {
                promise.reject(error)
                return
            }
            
            if let object = object {
                promise.fulfill(object)
                return
            }
            
            let error = WebServiceError.unknown
            promise.reject(error)
        }
        return promise
    }
}
