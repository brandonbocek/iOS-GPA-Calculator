//
//  CoursePersistence.swift
//  GPACalculator
//
//  Created by Brandon Bocek on 8/1/17.
//  Copyright © 2017 brandon. All rights reserved.
//

import Foundation
protocol CoursePersistenceInterface {
    var savedCourses: [Course] { get }
    func save(course: Course)
    func remove(course: Course) -> Bool
}

class CoursePersistence: JsonStoragePersistence, CoursePersistenceInterface {
    let directoryUrl: URL
    
    init?(atUrl baseUrl: URL, withDirectoryName name: String) {
        guard let directoryUrl = FileManager.default.createDirectory(atUrl: baseUrl, appendingPath: name) else { print("fail")
            return nil }
        self.directoryUrl = directoryUrl
        print(directoryUrl)
    }
    
    var savedCourses: [Course] {
        let jsonDicts = names.flatMap { read(jsonFileWithId: $0) }
        return jsonDicts.flatMap { Course.createFrom(dict: $0) }
    }
    
    func save(course: Course) {
        save(data: course.toDictionary(), withId: course.id.uuidString)
    }
    
    func remove(course: Course) -> Bool {
        return delete(jsonFileWithId: String(describing: course.id))
    }

}
