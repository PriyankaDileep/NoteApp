//
//  NotesListTableViewController.swift
//  SimpleNotes
//
//  Created by Priyanka PS on 2/2/21.
//

import UIKit
import Firebase

class NotesListTableViewController: UITableViewController {
    var notes: [Note] = []
    private var documents: [DocumentSnapshot] = []
    private var listener : ListenerRegistration!
    fileprivate func baseQuery() -> Query {
            return Firestore.firestore().collection("notes").limit(to: 50)
        }
        
        fileprivate var query: Query? {
            didSet {
                if let listener = listener {
                    listener.remove()
                }
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        getNotes()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotes()
    }

    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.listener.remove()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.notes.count)
        return self.notes.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddNotes", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel!.text = note.Title
        cell.detailTextLabel?.text = note.Description
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getNotes() {
        self.query = baseQuery()
        self.listener =  query?.addSnapshotListener { (documents, error) in
                    guard let snapshot = documents else {
                        print("Error fetching documents results: \(error!)")
                        return
                    }
                    
                    let results = snapshot.documents.map { (document) -> Note in
                        if let note = Note(dictionary: document.data()) {
                            return note
                        } else {
                            fatalError("Unable to initialize type \(Note.self) with dictionary \(document.data())")
                        }
                    }
                    self.notes = results
                    self.documents = snapshot.documents
                    self.tableView.reloadData()
                }
    }
}
