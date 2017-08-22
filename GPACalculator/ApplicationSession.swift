//
//  ApplicationSession.swift
//  GPACalculator
//
//  Created by Brandon Bocek on 8/1/17.
//  Copyright © 2017 brandon. All rights reserved.
//

import Foundation

// Application Session singleton
class ApplicationSession {
    static let sharedInstance = ApplicationSession()
    
    var persistence: CoursePersistenceInterface?
    
    private init() {
        if let appStorageUrl = FileManager.default.createDirectoryInUserLibrary(atPath: "GPACalculator"),
            let persistence = CoursePersistence(atUrl: appStorageUrl, withDirectoryName: "courses") {
            self.persistence = persistence
        }
    }
}
