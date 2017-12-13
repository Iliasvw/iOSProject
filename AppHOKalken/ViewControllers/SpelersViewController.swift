import UIKit
import Firebase
import FirebaseDatabase

class SpelersViewController: UIViewController {
    var spelers: [Speler]! = []
    private var indexPathToEdit: IndexPath!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var teamnaam: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    var ref: DatabaseReference!
    var userID: String!
    
    override func viewDidLoad() {
        userID = Auth.auth().currentUser!.uid
        ref = Database.database().reference()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.resetButton.layer.cornerRadius = 8
    }
    
    @IBAction func resetTeam() {
        let alert = UIAlertController(title: "Reset team", message: "Bent u zeker dat u alle goals en kaarten van alle spelers wilt verwijderen?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .`default`, handler: { _ in
            for i in self.spelers {
                i.goals = []
                i.kaarten = []
            }
            self.ref.child("teams").child(self.userID).child("spelers").setValue(Ploeg.spelersToDict(spelers: self.spelers))
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Annuleer", comment: "Annuleer"), style: .`default`, handler: { _ in
            return
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func logout() {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "didLogout", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addSpeler"?:
            break
        case "editSpeler"?:
            let editController = segue.destination as! AddSpelerViewController
            editController.speler = spelers[indexPathToEdit.row]
            editController.navigationItem.title = "Speler wijzigen"
        case "spelerMenu"?:
            let menuController = segue.destination as! MenuViewController
            let selection = tableView.indexPathForSelectedRow!
            menuController.speler = spelers[selection.row]
            let index = selection.row
            menuController.index = index
            tableView.deselectRow(at: selection, animated: true)
        case "didLogout"?:
            break
        default:
            fatalError("Unkown segue")
        }
    }
    
    @IBAction func unwindFromAddSpeler(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didAddSpeler"?:
            let addSpelerController = segue.source as! AddSpelerViewController
            spelers.append(addSpelerController.speler!)
            tableView.insertRows(at: [IndexPath(row: spelers.count - 1, section: 0)], with: .automatic)
            ref.child("teams").child(userID).child("spelers").setValue(Ploeg.spelersToDict(spelers: self.spelers))
        case "didEditSpeler"?:
            tableView.reloadRows(at: [indexPathToEdit], with: .automatic)
            ref.child("teams").child(userID).child("spelers").setValue(Ploeg.spelersToDict(spelers: self.spelers))
        default:
            fatalError("Unkown segue")
        }
    }
}

extension SpelersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            (action, view, completionHandler) in
            self.indexPathToEdit = indexPath
            self.performSegue(withIdentifier: "editSpeler", sender: self)
            completionHandler(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            self.spelers.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.ref.child("teams").child(self.userID).child("spelers").setValue(Ploeg.spelersToDict(spelers: self.spelers))
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

extension SpelersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spelers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spelerCell", for: indexPath) as! SpelerCell
        cell.speler = spelers[indexPath.row]
        return cell
    }
}
