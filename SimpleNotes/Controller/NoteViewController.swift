//
//  NoteViewController.swift
//  SimpleNotes
//
//  Created by Priyanka PS on 2/2/21.
//

import UIKit
import Firebase

class NoteViewController: UIViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnSaveButton(_ sender: Any) {
        let db = Firestore.firestore()
                    var docRef: DocumentReference? = nil
                    docRef = db.collection("notes").addDocument(data: [
                        "title": titleTextField.text ?? "empty task",
                        "Description": noteTextView.text ?? "Empty Desc"
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(docRef!.documentID)")
                        }
                    }
        
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
