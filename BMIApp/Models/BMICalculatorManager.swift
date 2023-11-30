//
//  BMICalculatorManager.swift
//  BMIApp
//
//  Created by 예찬 on 11/27/23.
//

import UIKit

// BMI 계산만을 위한 로직으로 이루어져 있는가?
struct BMICalculatorManager {
    private var bmi: BMI?
    
    // 계산된 BMI값 반환해줄 메서드
    mutating func getBMI(height: String,
                         weight: String) -> BMI? {
        guard let bmi = bmi else { return BMI(bmiValue: 0.0,
                                              bmiColor: .black,
                                              bmiAdvice: "Error") }
        return bmi
    }
    
    // bmi 계산 비즈니스 로직
    mutating func calculateBMI(height: String,
                               weight: String) {
        guard let height = Double(height),
              let weight = Double(weight) else {
            bmi = BMI(bmiValue: 0.0,
                      bmiColor: .black,
                      bmiAdvice: "Error")
            return
        }
        
        var bmiNumber = weight / (height * height) * 10000
        bmiNumber = round(bmiNumber * 10) / 10
        
        switch bmiNumber {
        case ..<18.6:
            let color = UIColor(displayP3Red: 22/255,
                                green: 231/255,
                                blue: 207/255,
                                alpha: 1)
            bmi = BMI(bmiValue: bmiNumber,
                      bmiColor: color,
                      bmiAdvice: "저체중")
        case 18.6..<23.0:
            let color = UIColor(displayP3Red: 212/255,
                                green: 251/255,
                                blue: 121/255,
                                alpha: 1)
            bmi = BMI(bmiValue: bmiNumber,
                      bmiColor: color,
                      bmiAdvice: "표준")
        case 23.0..<25.0:
            let color = UIColor(displayP3Red: 218/255,
                                green: 127/255,
                                blue: 163/255,
                                alpha: 1)
            bmi = BMI(bmiValue: bmiNumber,
                      bmiColor: color,
                      bmiAdvice: "과체중")
        case 25.0..<30.0:
            let color = UIColor(displayP3Red: 25/255,
                                green: 150/255,
                                blue: 141/255,
                                alpha: 1)
            bmi = BMI(bmiValue: bmiNumber,
                      bmiColor: color,
                      bmiAdvice: "중도비만")
        case 30.0...:
            let color = UIColor(displayP3Red: 25/255,
                                green: 100/255,
                                blue: 78/255,
                                alpha: 1)
            bmi = BMI(bmiValue: bmiNumber,
                      bmiColor: color,
                      bmiAdvice: "고도비만")
        default:
            bmi = BMI(bmiValue: 0.0,
                      bmiColor: .black,
                      bmiAdvice: "Error!")
        }
    }
    
//    func showBMIColor() -> UIColor {
//        guard let bmi = bmi else { return .black }
//        switch bmi {
//        case ..<18.6:
//            return .systemBlue
//        case 18.6..<23.0:
//            return .systemYellow
//        case 23.0..<25.0:
//            return .systemPink
//        case 25.0..<30.0:
//            return .systemPurple
//        case 30.0...:
//            return .systemRed
//        default:
//            return .black
//        }
//    }
//    
//    func getBMIResultString() -> String {
//        guard let bmi = bmi else { return "" }
//        switch bmi {
//        case ..<18.6:
//            return "저체중"
//        case 18.6..<23.0:
//            return "표준"
//        case 23.0..<25.0:
//            return "과체중"
//        case 25.0..<30.0:
//            return "중도비만"
//        case 30.0...:
//            return "고도비만"
//        default:
//            return ""
//        }
//    }
}
