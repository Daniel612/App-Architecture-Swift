//
//  ViewController.swift
//  MVP
//
//  Created by daniel on 2018/7/31.
//  Copyright © 2018年 DanielDev. All rights reserved.
//

import UIKit

protocol ViewProtocol: class {
    var textFieldValue: String { get set }
}

class ViewPresenter {
    let model: Model
    weak var view: ViewProtocol?
    let observer: NSObjectProtocol
    init(model: Model, view: ViewProtocol) {
        self.model = model
        self.view = view
        
        view.textFieldValue = model.value
        observer = NotificationCenter.default.addObserver(forName: Model.textDidChange, object: nil, queue: nil) { [view] (note) in
            view.textFieldValue = note.userInfo?[Model.textKey] as? String ?? ""
        }
    }
    
    func commit() {
        model.value = view?.textFieldValue ?? ""
    }
}

class ViewController: UIViewController, ViewProtocol {
    
    // MARK: - 模型
    
    var model = Model(value: "写点有趣的东西")
    
    // MARK: - 界面
    @IBOutlet weak var mvpTextField: UITextField!
    @IBOutlet weak var mvpLabel: UILabel!
    
    // MARK: - 属性
    var presenter: ViewPresenter?
    var textFieldValue: String {
        get {
            return mvpTextField.text ?? ""
        }
        set {
            mvpLabel.text = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mvpDidLoad()
    }
    
    func mvpDidLoad() {
        presenter = ViewPresenter(model: model, view: self)
    }
    
    @IBAction func mvpButtonPressed(_ sender: Any) {
        presenter?.commit()
    }
    

}

