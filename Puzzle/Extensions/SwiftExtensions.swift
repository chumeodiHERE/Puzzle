//
//  SwiftExtensions.swift
//  Puzzle
//
//  Created by Gia Huy on 02/11/2022.
//

import Foundation

extension NSAttributedString {
    
    static func createHyperLink(for path: String, in string: String, as subString: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let subStringRange = nsString.range(of: subString)
        let attString = NSMutableAttributedString(string: string)
        attString.addAttribute(.link, value: path, range: subStringRange)
        return attString
    }
}
