//
//  HError.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 31/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import Foundation

enum HError: Error {
    case uploadError
}

extension HError: CustomStringConvertible {
    var description: String {
        switch self {
        case .uploadError:
            return "Error uploading image to server"
        }
    }
}
