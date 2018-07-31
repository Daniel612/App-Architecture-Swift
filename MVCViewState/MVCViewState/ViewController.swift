//
//  ViewController.swift
//  MVCViewState
//
//  Created by daniel on 2018/7/31.
//  Copyright © 2018年 DanielDev. All rights reserved.
//

import UIKit

class ViewState {
    var textFieldValue: String = ""
    init(textFieldValue: String) {
        self.textFieldValue = textFieldValue
    }
}

class ViewController: UIViewController {
    
    // MARK: - 模型
    var model = Model(value: "写点有趣的东西")
    
    // MARK: - 视图
    @IBOutlet weak var mvcvsTextField: UITextField!
    @IBOutlet weak var mvcvsLabel: UILabel!
    
    // MARK: - 属性
    var viewState: ViewState?
    var viewStateObserver: NSObjectProtocol?
    var viewStateModelObserver: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        mvcvsViewDidLoad()
    }
    
    func mvcvsViewDidLoad() {
        viewState = ViewState(textFieldValue: model.value)
        viewStateObserver = NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: mvcvsTextField, queue: nil, using: { [viewState] (note) in
            viewState?.textFieldValue = (note.object as? UITextField)?.text ?? ""
        })
        viewStateModelObserver = NotificationCenter.default.addObserver(forName: Model.textDidChange, object: nil, queue: nil, using: { [mvcvsLabel] (note) in
            mvcvsLabel?.text = note.userInfo?[Model.textKey] as? String
        })
    }

    @IBAction func mvcvsButtonPressed(_ sender: Any) {
        model.value = viewState?.textFieldValue ?? ""
    }
    
}

