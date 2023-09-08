//
//  ThirdViewController.swift
//  DataBinding
//
//  Created by Chun-Li Cheng on 2021/12/8.
//

import UIKit
import RxSwift
import RxCocoa

class ThirdViewController: UIViewController {
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet var inputTextFields: [UITextField]!
    private var areFieldsFilled: Bool {
        inputTextFields.allSatisfy { textField in
            !(textField.text?.isEmpty ?? true)
        }
    }
    private var buttonStateObserver: Observer<Bool>?
    
    private var textFields = [UITextField]()
    private var allFieldsObserver: Observer<[UITextField]>?
    
    private var fieldsFilledRelay = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        // MARK: -方法零
        // rx bind
//        fieldsFilledRelay
//            .distinctUntilChanged()     // 確保值改變時才發出事件
//            .bind(to: loginButton.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        
        // rx bind
//        let combinedTexts: Observable<[String]> = Observable.combineLatest(inputTextFields.map { $0.rx.text.orEmpty })
//        let textsAllNotEmpty = combinedTexts.map { textArray in
//            textArray.allSatisfy { !$0.isEmpty }
//        }
//
//        textsAllNotEmpty
//            .distinctUntilChanged()
//            .bind(to: loginButton.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        
        // rx subscribe
        // 將每一個 textField 的 text 轉為 Observable 並合併它們
//        let textChanges = Observable.merge(inputTextFields.map { $0.rx.text.orEmpty.asObservable() })
//
//        // 當任何 textField 的內容變更時，更新按鈕的狀態
//        textChanges.subscribe(onNext: { [weak self] _ in
//            let areAllFieldsFilled = self?.inputTextFields.allSatisfy { !$0.text!.isEmpty }
//            self?.loginButton.isEnabled = areAllFieldsFilled ?? false
//        }).disposed(by: disposeBag)
        
        
        // rx drive
//        let fieldsFilledDriver = Driver.combineLatest(inputTextFields.map { $0.rx.text.orEmpty.asDriver() })
//
//        fieldsFilledDriver.drive(onNext: { [weak self] texts in
//            let areAllFieldsFilled = texts.allSatisfy { !$0.isEmpty }
//            self?.loginButton.isEnabled = areAllFieldsFilled
//        }).disposed(by: disposeBag)

        
        // MARK: -方法一
//        loginButton.isEnabled = false
        
        // MARK: -方法二
//        buttonStateObserver = Observer(false)
//        buttonStateObserver?.bind{ [weak self] isFilled in
//            self?.loginButton.isEnabled = isFilled ?? false
//        }
        
        // MARK: -方法三
//        textFields.append(contentsOf: [firstTextField, secondTextField, thirdTextField])
//        allFieldsObserver = Observer(textFields)
//
//        allFieldsObserver?.bind { textFields in
//            let fieldArray = textFields?.filter { $0.text != "" }
//            self.loginButton.isEnabled = (fieldArray?.count == 3)
//        }
        
    }
    
    @IBAction func judgeBtnState() {
        // MARK: -方法零
//        fieldsFilledRelay.accept(areFieldsFilled)
        
        // MARK: -方法一
        updateLoginButtonState()
        
//        if firstTextField.text != "" && secondTextField.text != "" && thirdTextField.text != "" {
//            loginButton.isEnabled = true
//        } else {
//            loginButton.isEnabled = false
//        }
        
        // MARK: -方法二
//        buttonStateObserver?.value = areFieldsFilled
        
        // MARK: -方法三
//        allFieldsObserver?.value = [firstTextField, secondTextField, thirdTextField]

        
    }
    
    private func updateLoginButtonState() {
        loginButton.isEnabled = inputTextFields.allSatisfy { !$0.text!.isEmpty }
//        loginButton.isEnabled = areFieldsFilled
    }

}

// MARK: - Boxing
class Observer<T> {
    typealias listener = (T?) -> Void
    
    var value: T? {
        didSet {
            listeners.forEach {
                $0(value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private var listeners: [ listener ] = []
    
    func bind(_ listener: @escaping listener) {
        listener(value)
        self.listeners.append(listener)
    }
    
}
