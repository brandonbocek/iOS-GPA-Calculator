//
//  TableViewController.swift
//  GPACalculator
//
//  Created by Brandon Bocek on 8/1/17.
//  Copyright © 2017 brandon. All rights reserved.
//

import UIKit


class CourseListViewController: UIViewController {
    
    @IBOutlet weak fileprivate var tableView: UITableView!
    @IBOutlet weak var projectedGPALabel: UILabel!
    
    var gpa = String()
    var hours = String()
    var model: CourseListModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = 64
        model.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        //getting the calculated GPA
        projectedGPALabel.text = String(model.getProjectedGPA(startingGPA: Double(gpa), startingHours: Int(hours)))
    }

    //when the user taps to add a new course
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let creationViewController = segue.destination as? AddCourseViewController {
            creationViewController.delegate = self
        }
        guard let destination = segue.destination as? AddCourseViewController,
            let index = sender as? Int,
            let course = model.course(atIndex: index)
            else { return }
        
        destination.course = course
        print("🐼 MoviesViewController: \(#function)")
    }
    
    deinit {
        print("🐼 MoviesViewController: \(#function)")
    }

    
    //allows for deletion of a course
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            model.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

//allows the user to edit a course
extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editCourse", sender: indexPath.row)
    }
}
extension CourseListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as? CourseListTableViewCell,
            let course = model.course(atIndex: indexPath.row)
            else {
                return UITableViewCell() }
        
        cell.decorate(with: course)
        
        return cell
    }
}
extension CourseListViewController: AddCourseViewControllerDelegate {
    func save(course: Course) {
        model.save(course: course)
    }
}
    
extension CourseListViewController: CourseListModelDelegate {
    func dataRefreshed() {
        tableView.reloadData()
    }
}


