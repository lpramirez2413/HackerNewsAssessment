//
//  String+Extensions.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import Foundation

extension String {
    
    var timeElapsedFormatted: String {
        guard let date = getDate(), let elapsedTimeString = date.string() else {
            return "Unknown date"
        }
        return elapsedTimeString
    }
    
    func getDate(from format: String? = nil) -> Date? {
        guard let format = format else {
            let dateFormatter = ISO8601DateFormatter()
            return dateFormatter.date(from: self)
        }
        /** If different format is needed, add here and return it */
        return nil
    }
}


