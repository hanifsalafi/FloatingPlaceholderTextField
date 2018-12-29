//
//  ViewController.swift
//  FloatingPlaceholderTextField
//
//  Created by Hanif Salafi on 29/12/18.
//  Copyright © 2018 Ursabyte. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var txtFieldUsername: UITextField!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    private var lblUsernameYAnchorConstraint: NSLayoutConstraint!
    private var lblUsernameLeadingAnchor: NSLayoutConstraint!
    private var lblPasswordYAnchorConstraint: NSLayoutConstraint!
    private var lblPasswordLeadingAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFieldUsername.delegate = self
        txtFieldPassword.delegate = self
        
        configureConstraint()
    }
    
    func configureConstraint() {
        lblUsernameYAnchorConstraint = lblUsername.centerYAnchor.constraint(equalTo: self.txtFieldUsername.centerYAnchor, constant: 0)
        lblUsernameLeadingAnchor = lblUsername.leadingAnchor.constraint(equalTo: self.usernameView.leadingAnchor, constant: 7)
        lblPasswordYAnchorConstraint = lblPassword.centerYAnchor.constraint(equalTo: self.txtFieldPassword.centerYAnchor, constant: 0)
        lblPasswordLeadingAnchor = lblPassword.leadingAnchor.constraint(equalTo: self.passwordView.leadingAnchor, constant: 7)
        
        NSLayoutConstraint.activate([
            txtFieldUsername.topAnchor.constraint(equalTo: self.usernameView.topAnchor, constant: 30),
            txtFieldUsername.bottomAnchor.constraint(equalTo: self.usernameView.bottomAnchor, constant: 5),
            txtFieldUsername.trailingAnchor.constraint(equalTo: self.usernameView.trailingAnchor),
            txtFieldUsername.leadingAnchor.constraint(equalTo: self.usernameView.leadingAnchor),
            
            txtFieldPassword.topAnchor.constraint(equalTo: self.passwordView.topAnchor, constant: 30),
            txtFieldPassword.bottomAnchor.constraint(equalTo: self.passwordView.bottomAnchor, constant: 5),
            txtFieldPassword.trailingAnchor.constraint(equalTo: self.passwordView.trailingAnchor),
            txtFieldPassword.leadingAnchor.constraint(equalTo: self.passwordView.leadingAnchor),
            
            lblUsernameYAnchorConstraint,
            lblUsernameLeadingAnchor,
            lblPasswordYAnchorConstraint,
            lblPasswordLeadingAnchor
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldUsername {
            return txtFieldUsername.resignFirstResponder()
        } else {
            return txtFieldPassword.resignFirstResponder()
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtFieldUsername {
            lblUsernameYAnchorConstraint.constant = -30
            lblUsernameLeadingAnchor.constant = -10
            performAnimation(transform: CGAffineTransform(scaleX: 0.9, y: 0.9),  forField: "username")
        } else {
            lblPasswordYAnchorConstraint.constant = -30
            lblPasswordLeadingAnchor.constant = -10
            performAnimation(transform: CGAffineTransform(scaleX: 0.9, y: 0.9),  forField: "password")
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtFieldUsername {
            if let text = textField.text, text.isEmpty {
                lblUsernameYAnchorConstraint.constant = 0
                lblUsernameLeadingAnchor.constant = 7
                performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1), forField: "username")
            }
        } else {
            if let text = textField.text, text.isEmpty {
                lblPasswordYAnchorConstraint.constant = 0
                lblPasswordLeadingAnchor.constant = 7
                performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1), forField: "password")
            }
        }
        
    }
    
    func performAnimation(transform: CGAffineTransform, forField: String) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if forField == "username" {
                self.lblUsername.transform = transform
            } else {
                self.lblPassword.transform = transform
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        self.view.window?.endEditing(true)
        self.txtFieldUsername.text = ""
        self.txtFieldPassword.text = ""
    }
    
    
    
}

