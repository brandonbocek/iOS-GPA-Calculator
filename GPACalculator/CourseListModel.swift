//
//  CourseListModel.swift
//  GPACalculator
//
//  Created by Brandon Bocek on 8/1/17.
//  Copyright © 2017 brandon. All rights reserved.
//

import Foundation

protocol CourseListModelDelegate: class {
    func dataRefreshed()
}

protocol CourseListModelInterface {
    weak var delegate: CourseListModelDelegate? { get set }
    var count: Int { get }
    func course(atIndex index: Int) -> Course?
    func save(course: Course)
    func remove(at row: Int)
    func edit(course: Course, at row: Int)
    func courseNameDoesNotAlreadyExist(course toCheck: Course) -> Bool
    func getProjectedGPA(startingGPA: Double?, startingHours: Int?) -> Double
}


class CourseListModel: CourseListModelInterface {
    weak var delegate: CourseListModelDelegate?
    
    private let persistence: CoursePersistenceInterface?
    private var courses = [Course]()
    
    init() {
        self.persistence = ApplicationSession.sharedInstance.persistence
        courses = self.persistence?.savedCourses ?? []
    }
    
    func course(atIndex index: Int) -> Course? {
        return courses.element(at: index)
    }
    
    var count: Int {
        return courses.count
    }
    
    var index = -1
    func courseNameDoesNotAlreadyExist(course toCheck: Course) -> Bool {
        index = -1
        for course in courses{
            index = index + 1
            if course.courseName == toCheck.courseName {
                return false
            }
        }
        return true
    }
    

    func save(course: Course) {
        if courseNameDoesNotAlreadyExist(course: course) {
            courses.append(course)
            persistence?.save(course: course)
            delegate?.dataRefreshed()
        } else {
            edit(course: course, at: index)
        }
    }
    
    func remove(at row: Int) {
        persistence?.remove(course: courses.element(at: row)!)
        courses.remove(at: row)
    }
    
    func edit(course: Course, at row: Int) {
        remove(at: row)
        courses.append(course)
        persistence?.save(course: course)
        delegate?.dataRefreshed()
    }
    
    func getProjectedGPA(startingGPA: Double?, startingHours: Int?) -> Double {
        var totalGradePoints: Double = 0.00
        var totalHours: Int = 0
        if let hours = startingHours, let gpa = startingGPA {
            totalGradePoints = Double(gpa * Double(hours))
            totalHours = Int(hours)
            print("grade points -> \(Double(gpa * Double(hours))) and hours -> \(Int(hours))")
        }
        if courses.count > 0 {
            for course in courses {
                if course.isProjected {
                    totalGradePoints = totalGradePoints + Double(course.getGradePoints())
                    totalHours = totalHours + Int(course.numOfCreditHours)
                }
            }
        }
        print("The GPA is \(totalGradePoints / Double(totalHours))")
        return totalGradePoints / Double(totalHours)
    }
}
