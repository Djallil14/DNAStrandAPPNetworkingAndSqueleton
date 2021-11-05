//
//  Gene.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-05.
//

import Foundation

enum Gene: String, CaseIterable {
    case Insulin
    case Titin
    case Vasopressin
    case Prolactin
    case CReactiveProtein
    case Erythropoietin
    case ParathyroidHormone
    case Leptin
    case Glucagon
    case Calcitonin
    
    var urlAddition: String {
        switch self {
        case .Insulin:
            return "Insulin"
        case .Titin:
            return "Titin"
        case .Vasopressin:
            return "Vasopressin"
        case .Prolactin:
            return "Prolactin"
        case .CReactiveProtein:
            return "C-reactive%20protein"
        case .Erythropoietin:
            return "Erythropoietin"
        case .ParathyroidHormone:
            return "Parathyroid%20hormone"
        case .Leptin:
            return "Leptin"
        case .Glucagon:
            return "Glucagon"
        case .Calcitonin:
            return "Calcitonin"
        }
    }
}
