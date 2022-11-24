//
//  UploadQuizModel.swift
//  Puzzle
//
//  Created by Gia Huy on 06/11/2022.
//

import Foundation

struct UploadQuiz: Codable {
    var name: String
    var image: String
    var photographer_name: String
    var license: String
    var photographer_link: String
    var computer_link: String
}
