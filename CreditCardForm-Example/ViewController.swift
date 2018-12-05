//
//  ViewController.swift
//  CreditCardForm-Example
//
//  Created by Apple on 12/4/18.
//  Copyright © 2018 Amir Farsad. All rights reserved.
//

import UIKit
import Stripe
import CreditCardForm

class ViewController: UIViewController,STPPaymentCardTextFieldDelegate {
    @IBOutlet weak var cardStatusLabel: UILabel!
    @IBOutlet weak var creditCardForm: CreditCardFormView!
    let paymentTextField = STPPaymentCardTextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width-30, height: 44)
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height-width, width: paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true
        view.addSubview(paymentTextField)
        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: creditCardForm.bottomAnchor, constant: 20),
            paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
            paymentTextField.heightAnchor.constraint(equalToConstant: 44)
            ])
        paymentTextField.delegate = self
    }
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationMonth, cvc: textField.cvc)
        if (textField.cardNumber?.count == 16) {
            let isValidCard =             CreditCardValidator().validate(string: (textField.cardNumber)!)
            if (isValidCard) {
                cardStatusLabel.textColor = UIColor.green
                cardStatusLabel.text = "Valid Card Number"
            } else {
                cardStatusLabel.textColor = UIColor.red
                cardStatusLabel.text = "Invalid Card Number!"
            }
        }
    }
    
    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
    }
    
    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidBeginEditingCVC()
    }
    
    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidEndEditingCVC()
    }

}

