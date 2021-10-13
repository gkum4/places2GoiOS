//
//  TextLimiter.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 11/10/21.
//

import SwiftUI

class TextLimiter: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 5){
        characterLimit = limit
    }
}
