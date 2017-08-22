

import UIKit

class CourseListTableViewCell: UITableViewCell {
    @IBOutlet weak var courseNameLbl: UILabel!
    @IBOutlet weak var courseCreditHoursLbl: UILabel!
    @IBOutlet weak var courseGradePointsLbl: UILabel!
    
    func decorate(with course: Course) {
        courseNameLbl.text = course.courseName
        courseCreditHoursLbl.text = String(course.numOfCreditHours)
        courseGradePointsLbl.text = String(course.getGradePoints())
    }

}
