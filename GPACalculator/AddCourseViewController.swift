//
//  AddCourseController.swift
//  GPACalculator
//
//  Created by Brandon Bocek on 8/1/17.
//  Copyright © 2017 brandon. All rights reserved.
//

import UIKit
protocol AddCourseViewControllerDelegate: class {
    func save(course: Course)
}

class AddCourseViewController: UIViewController {

    weak var delegate: AddCourseViewControllerDelegate?
    
    @IBOutlet private weak var courseNameTextField: UITextField!
    @IBOutlet weak var numCreditHoursLbl: UILabel!
    @IBOutlet weak var numCreditHoursStepper: UIStepper!
    @IBOutlet weak var gradeLbl: UILabel!
    @IBOutlet weak var gradeStepper: UIStepper!
    
    private var gradeNumber = 0
    var course: Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseNameTextField.text = course?.courseName
        if let hours = course?.numOfCreditHours {
            numCreditHoursLbl.text = "\(hours)"
        }
        if course?.courseGrade != nil {
            gradeLbl.text = course?.courseGrade
        }
        
       // courseNameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func creditHoursChanged(_ sender: UIStepper) {
        numCreditHoursLbl.text = String(Int(sender.value))
    }

    @IBAction func gradeStepperTapped(_ sender: UIStepper) {
        gradeNumber = Int(sender.value)
        switch gradeNumber{
        case 1:
            gradeLbl.text = "FN"
        case 2:
            gradeLbl.text = "F"
        case 3:
            gradeLbl.text = "D-"
        case 4:
            gradeLbl.text = "D"
        case 5:
            gradeLbl.text = "D+"
        case 6:
            gradeLbl.text = "C-"
        case 7:
            gradeLbl.text = "C"
        case 8:
            gradeLbl.text = "C+"
        case 9:
            gradeLbl.text = "B-"
        case 10:
            gradeLbl.text = "B"
        case 11:
            gradeLbl.text = "B+"
        case 12:
            gradeLbl.text = "A-"
        case 13:
            gradeLbl.text = "A"
        default:
            gradeLbl.text = "Error"
        }
    }
    
    @IBAction func courseDescriptorTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            gradeStepper.maximumValue = 6
            if gradeNumber > 6 {
                gradeStepper.value = 6
                gradeLbl.text = "C-"
            }
        }else {
            gradeStepper.maximumValue = 13
        }
        
    }
    
    @IBAction func submitCourseTapped(_ sender: UIButton) {
        var name = courseNameTextField.text ?? ""
        if name == "" { name = "No Name" }
        
        let creditHours = Int(numCreditHoursLbl.text!)
        let grade = String(gradeLbl.text!)
        let projected = gradeStepper.maximumValue == 13
        let course = Course(id: UUID(), courseName: name, numOfCreditHours: creditHours!, courseGrade: grade!, isProjected: projected)
       
        delegate?.save(course: course)
        let _ = navigationController?.popViewController(animated: true)
    }
    
}
