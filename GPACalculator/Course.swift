

import Foundation

struct Course {
    let id: UUID
    var courseName: String
    var numOfCreditHours: Int
    var courseGrade: String
//    var gradeValue: Double
    var isProjected: Bool
}

extension Course {
    
    func getGradeValue() -> Double {
        switch courseGrade {
        case "A":
            return 4
        case "A-":
            return 3.7
        case "B+":
            return 3.3
        case "B":
            return 3
        case "B-":
            return 2.7
        case "C+":
            return 2.3
        case "C":
            return 2
        case "C-":
            return 1.7
        case "D+":
            return 1.3
        case "D":
            return 1
        case "D-":
            return 0.7
        case "F":
            return 0
        default: return 0
        }
    }
    
    func getGradePoints() -> Double {
        
        return Double(numOfCreditHours) * getGradeValue()
    }
}

extension Course {
    func toDictionary() -> JsonDictionary {
        return [
            "id": self.id.uuidString,
            "courseName": self.courseName,
            "numOfCreditHours": self.numOfCreditHours,
            "courseGrade": self.courseGrade,
            "isProjected": self.isProjected
        ]
    }
    
    static func createFrom(dict: JsonDictionary) -> Course? {
        guard
            let idString = dict["id"] as? String,
            let id = UUID(uuidString: idString),
            let courseName = dict["courseName"] as? String,
            let numOfCreditHours = dict["numOfCreditHours"] as? Int,
            let courseGrade = dict["courseGrade"] as? String,
            let isProjected = dict["isProjected"] as? Bool
            else {
                return nil
        }
        return Course(id: id, courseName: courseName,numOfCreditHours: numOfCreditHours, courseGrade: courseGrade, isProjected: isProjected)
    }
}
