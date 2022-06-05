//
//  ViewController.swift
//  TestDrivenDevelopment
//
//  Created by Anjas Dwi on 05/06/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var tipsSegmented: UISegmentedControl!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var result: UILabel!
    
    let tipCalculator = TipCalculator()
    
    var total: String = ""
    var tipPercentage: Double = 0.1
    var tip: String?
    var message: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navbar
        self.title = "Tip Calculator"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.setupView()
    }

    @IBAction func onCalculate(_ sender: Any) {
        self.result.text = ""

        guard let amount = self.amount.text,
              let total = Double(amount)
        else { return }
        
        do {
            let result = try tipCalculator.calculate(total: total, tipPercentage: self.tipPercentage)
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            self.result.text = formatter.string(from: NSNumber(value: result))
        } catch TipCalculatorError.invalidInput {
            self.result.text = "Invalid Input"
            self.amount.text = ""
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func indexPercentageChanged(_ sender: UISegmentedControl) {
        let selected = sender.selectedSegmentIndex + 1
        self.tipPercentage = Double(selected*10) / 100.0
    }

    @objc
    private func didChange(_ textField: UITextField) {
        
    }

    func setupView() {
        // Amount
        self.amount.font = .systemFont(ofSize: 18)
        self.amount.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        self.amount.placeholder = "Enter amount"
        self.amount.accessibilityIdentifier = "amount"
        
        // Segmented Controller
        self.tipsSegmented.accessibilityIdentifier = "tipPercentageSegmentedControl"
        // Button
        self.submit.setTitle("Calculate", for: .normal)
        self.submit.layer.cornerRadius = 4
        self.submit.tintColor = .white
        self.submit.backgroundColor = .init(red: 0, green: 0.6588, blue: 0.4824, alpha: 1)
        self.submit.accessibilityIdentifier = "calculateButton"
        
        // Result
        self.result.font = .systemFont(ofSize: 32)
        self.result.accessibilityIdentifier = "resultTextField"
    }
}

