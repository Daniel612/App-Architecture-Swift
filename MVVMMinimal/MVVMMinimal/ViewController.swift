//
//  ViewController.swift
//  MVVMMinimal
//
//  Created by daniel on 2018/7/31.
//  Copyright © 2018年 DanielDev. All rights reserved.
//

import UIKit

/**
 * MinimalViewModel 相当于把数据推送到 View 协议的实例中
 * 它需要一个可观察的值，把属性暴露出去。
 * 要实现 MVVM，我们需要使用 KVO 来作为一种绑定的模拟
 */
class MinimalViewModel: NSObject {
    var model: Model
    var observer: NSObjectProtocol?
    
    @objc dynamic var textFieldValue: String
    init(model: Model) {
        self.model = model
        textFieldValue = model.value
        super.init()
        observer = NotificationCenter.default.addObserver(forName: Model.textDidChange, object: nil, queue: nil) { [weak self] (note) in
            self?.textFieldValue = note.userInfo?[Model.textKey] as? String ?? ""
        }
    }
    
    func commit(value: String) {
        model.value = value
    }
}

class ViewController: UIViewController {
    
    // MARK: - 模型
    var model = Model(value: "写点有趣的东西")
    
    // MARK: - 界面
    @IBOutlet weak var mvvmmTextField: UITextField!
    @IBOutlet weak var mvvmmLabel: UILabel!
    
    // MARK: - 属性
    var minimalViewModel: MinimalViewModel?
    var minimalObserver: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        mvvmMinimalViewDidLoad()
    }
    
    func mvvmMinimalViewDidLoad() {
        minimalViewModel = MinimalViewModel(model: model)
        minimalObserver = minimalViewModel?.observe(\.textFieldValue, options: [.initial, .new], changeHandler: { [weak self] (_, change) in
            self?.mvvmmLabel.text = change.newValue
        })
    }

    @IBAction func mvvmmButtonPressed(_ sender: Any) {
        minimalViewModel?.commit(value: mvvmmTextField.text ?? "")
    }
    
}

