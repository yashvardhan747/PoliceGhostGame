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
        if 1 < viewModel.row && 1 < viewModel.col {
            let vm = SecondScreenViewModel(row: viewModel.row, col: viewModel.col)
            guard let vc = SecondScreenViewController(viewModel: vm) else {return}
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let alert = UIAlertController(title: "Invalid Input", message: "Try again!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    private var viewModel = FirstScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rowNumberTextField.delegate = self
        colNumberTextField.delegate = self
        rowNumberTextField.keyboardType = .numberPad
        colNumberTextField.keyboardType = .numberPad
    }
}

extension FirstScreenViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let str = textField.text, let int = Int(str) else {return}
        if textField == rowNumberTextField {
            viewModel.row = int
        }
        
        if(textField == colNumberTextField) {
            viewModel.col = int
        }
        
        return
    }
}
