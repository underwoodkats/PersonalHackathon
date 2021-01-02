//
//  Stage.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import Foundation

struct Stage {
    var name: String
    var durationInSeconds: Int
    var durationInMinutes: Int {
        return durationInSeconds / 60
    }
}
