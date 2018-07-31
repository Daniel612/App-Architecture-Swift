//
//  Model.swift
//  MVC
//
//  Created by daniel on 2018/7/30.
//  Copyright © 2018年 DanielDev. All rights reserved.
//

import Foundation

class Model {
    static let textDidChange = Notification.Name("textDidChange")
    static let textKey = "text"
    
    var value: String {
        didSet {
            NotificationCenter.default.post(name: Model.textDidChange, object: self, userInfo: [Model.textKey: value])
        }
    }
    
    init(value: String) {
        self.value = value
    }
}
