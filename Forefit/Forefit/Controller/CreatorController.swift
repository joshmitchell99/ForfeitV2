//
//  creatorController.swift
//  Forefit
//
//  Created by Edward Raven on 21/09/2020.
//  Copyright © 2020 Edward Raven. All rights reserved.
//

import UIKit
import Foundation

class CreatorController: UIViewController {
    
    // Runs when the program loads
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var forefeitTitle = ""
    var completeBy = ""
    var forefeitAmmount = 0
    
    let dateFormatter = DateFormatter()
    
    
    @IBOutlet weak var textEntry: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var forefeitAmountLabel: UILabel!
    
    @IBOutlet weak var forefeitAmountStepper: UIStepper!
    
    
    @IBAction func forefeitAmountStepperPressed(_ sender: UIStepper) {

        
        didUpdate()
    }
    
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        didUpdate()
        
    }
    
    func didUpdate() {
        self.forefeitTitle = textEntry.text ?? "Enter your forefeit here"
        self.completeBy = dateFormatter.string(from: datePicker.date)
        self.forefeitAmmount = Int(forefeitAmountStepper.value)
        print(self.forefeitTitle, self.completeBy, self.forefeitAmmount)
    }
    
    
    
}
