//
//  ViewController.swift
//  MVVM
//
//  Created by daniel on 2018/7/31.
//  Copyright © 2018年 DanielDev. All rights reserved.
//

import UIKit

class ViewModel {
    let model: Model
    init(model: Model) {
        self.model = model
    }
    
    var textFieldValue: Signal<String> {
        return Signal.notifications(name: Model.textDidChange)
            .compactMap { note in
                note.userInfo?[Model.textKey] as? String
                }.continuous(initialValue: model.value)
    }
    
    func commit(value: String) {
        model.value = value
    }
}

class MVVMViewController: UIViewController {
    
    // MARK: - 模型
    var model = Model(value: "写点有趣的东西")
    
    // MARK: - 视图
    
    @IBOutlet weak var mvvmTextField: UITextField!
    @IBOutlet weak var mvvmLabel: UILabel!
    
    
    // MARK: - 属性
    var viewModel: ViewModel?
    var mvvmObserver: Cancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        mvvmViewDidLoad()
    }
    
    func mvvmViewDidLoad() {
        viewModel = ViewModel(model: model)
        mvvmObserver = viewModel?.textFieldValue.subscribeValues({ [unowned self] (str) in
            self.mvvmLabel.text = str
        })
    }

    @IBAction func mvvmButtonPressed(_ sender: Any) {
        viewModel?.commit(value: mvvmTextField.text ?? "")
    }

}

