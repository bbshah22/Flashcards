//
//  ViewController.swift
//  Flashcards
//
//  Created by Bhuvni Shah on 2/27/21.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // Array to hold flashcards
    var flashcards = [Flashcard]()
    // current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // since the card is clipped, the shaddows will not show up
        card.layer.cornerRadius = 20.0
//        card.clipsToBounds = true
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        frontLabel.layer .cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        
        backLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds = true
        
        // Read saved flashcards
        readSavedFlashcards()
        
        // Adding initial flashcard if necessary
        if flashcards.count == 0 { updateFlashcard(question: "What is the Capital of Brazil?", answer: "Brasilia")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    func readSavedFlashcards() {
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            // if we have a dictionary
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // put all the recovered cards in flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func saveAllFlashcardsToDisk() {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question":card.question, "answer": card.answer]
        }
        
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // dont ask the flashcaard array save a dictionary instead
        print("Flashcards saved to UserDefaults")
    }

    // when you tap on the flashcard it flips
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden){
            frontLabel.isHidden = false;
        }
        else{
            frontLabel.isHidden = true;
        }
    }
    
    func updateLabels(){
        // Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    // previous button functionality
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Decrease current index
        currentIndex = currentIndex - 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    // next button functionality
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    // you can change the flashcard
    func updateFlashcard(question: String, answer: String) {
        // create flashcard struct
        let flashcard = Flashcard(question: question, answer: answer)
        
        // add flashcard to the flashcards array
        flashcards.append(flashcard)
        
        print("added a flashcard")
        print("now we have \(flashcards.count) flashcards")
        
        // update currentIndex
        currentIndex = flashcards.count-1
        print("our current index is \(currentIndex)")
        
        // Update prev/next buttons
        updateNextPrevButtons()
        
        // Update Labels
        updateLabels()
        
        // save the flashcards to disk
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons(){
        // Disable the next button if you are at the end and disable the prev button if you are at the beginning
        if currentIndex == (flashcards.count - 1) {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // destination for the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // set flashcardController prpperty to self
        creationController.flashcardsController = self
        
        // for edit button
        if segue.identifier == "EditSegue"{
        creationController.initialQuestion = frontLabel.text
        creationController.initialAnswer = backLabel.text
        }
        
    }
    
}

