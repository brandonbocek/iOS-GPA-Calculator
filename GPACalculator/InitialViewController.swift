//
//  InitialViewController.swift
//  GPACalculator
//
//  Created by Brandon Bocek on 8/1/17.
//  Copyright © 2017 brandon. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    @IBOutlet weak var currentGPATextField: UITextField!

    @IBOutlet weak var numCreditHoursTextField: UITextField!

    fileprivate var model: CourseListModelInterface = CourseListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //model.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toCourseListTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toCourseList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listController = segue.destination as! CourseListViewController
        listController.gpa = currentGPATextField.text!
        listController.hours = numCreditHoursTextField.text!
        listController.model = model as! CourseListModel
    }
    
}
