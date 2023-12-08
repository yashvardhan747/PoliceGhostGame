//
//  ViewController.swift
//  INDMoney
//
//  Created by Astrotalk on 08/12/23.
//

import UIKit

class FirstScreenViewController: UIViewController {

    @IBOutlet weak var rowNumberTextField: UITextField!
    @IBOutlet var colNumberTextField: UITextField!
    
    @IBAction func generateButtonTapped(_ sender: UIButton) {
//        TODO
    }
    
    private var viewModel = FirstScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rowNumberTextField.delegate = self
        colNumberTextField.delegate = self
    }
}

extension FirstScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let str = textField.text, let int = Int(str) else {return false}
        if textField == rowNumberTextField {
            viewModel.row = int
        }
        
        if(textField == colNumberTextField) {
            viewModel.col = int
        }
        
        return true
    }
}
