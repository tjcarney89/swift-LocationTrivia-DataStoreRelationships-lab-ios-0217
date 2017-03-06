//
//  AddTriviaViewController.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by TJ Carney on 3/6/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

protocol AddTriviaDelegate: class {
    func addTrivia(_ trivia: Trivium)
}

class AddTriviaViewController: UIViewController {

    @IBOutlet weak var triviumTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    weak var delegate: AddTriviaDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        triviumTextField.accessibilityLabel = "Trivium Text Field"
        triviumTextField.accessibilityIdentifier = "Trivium Text Field"
        
        cancelButton.accessibilityLabel = "Cancel Button"
        cancelButton.accessibilityIdentifier = "Cancel Button"
        
        saveButton.accessibilityLabel = "Save Button"
        saveButton.accessibilityIdentifier = "Save Button" 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismissView()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        var fact = String()
        if let newFact = triviumTextField.text {
            fact = newFact
        }
        let newTrivia = Trivium(content: fact, likes: 0)
        if let receiver = delegate {
            receiver.addTrivia(newTrivia)
            dismissView()
        }
    }
}
