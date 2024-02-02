//
//  IOSNis.swift
//  Seminar1
//
//  Created by Aubkhon Abdullaev on 14.09.2023.
//

final class Student {
    var grades: [Double] = []
    var fullName: String

    init(grades: [Double] = [], fullName: String) {
        self.grades = grades
        self.fullName = fullName
    }

    func getGrade() -> Double {
        var sum = 0.0

        for grade in grades {
            sum += grade
        }

        return sum / (grades.count != 0 ? Double(grades.count) : 1)
    }
}

final class IOSNis {
    static var students: [Student] = []
    
    static func getMaxGrade() -> Double {
        if (students.count == 0){
            return 0
        }
        
        return students.map{$0.getGrade()}.max()!;
    }
    
    static func normalizeGrade(maxGrade : Double) -> [String : Double] {
        var gradeDict : [String : Double] = [:]
        
        for student in students {
            gradeDict[student.fullName] = student.getGrade() * 10 / maxGrade
        }
        
        return gradeDict
    }
    
}
