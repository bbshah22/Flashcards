//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Bhuvni Shah on 3/12/21.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    var initialQuestion: String?
    var initialAnswer: String?
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        // get text in the question text field
        let questionText = questionTextField.text
        // get text in the answer text field
        let answerText = answerTextField.text
        
        print("before if statement")
        // Check if fields are empty
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty{
            // create an alert
            print("entered if statement")
            let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            // add OK button
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            // present the alert
            present(alert, animated: true)
        } else {
            // update the flashcard UI
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
            
            dismiss(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
