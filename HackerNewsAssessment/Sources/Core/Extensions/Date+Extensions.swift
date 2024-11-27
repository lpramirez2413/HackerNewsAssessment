//
//  Date+Extensions.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import Foundation

extension Date {
    
    func string(from format: String? = nil) -> String? {
        guard let format = format else {
            let relativeDateFormatter = RelativeDateTimeFormatter()
            relativeDateFormatter.unitsStyle = .full
            return relativeDateFormatter.localizedString(for: self, relativeTo: Date())
        }
        /** If different format is needed, add here and return it */
        return nil
    }

}
