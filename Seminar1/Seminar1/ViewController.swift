//
//  ViewController.swift
//  Seminar1
//
//  Created by Aubkhon Abdullaev on 14.09.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(normalizeGrades())
    }


    func normalizeGrades() -> [String: Double] {
        IOSNis.students = [
            Student(grades: [3.51, 10, 9], fullName: "Ушакова Ангелина"),
            Student(grades: [7, 8, 7.5], fullName: "Алибек Адхамов")
        ]

        return IOSNis.normalizeGrade(maxGrade: IOSNis.getMaxGrade())
    }
}
