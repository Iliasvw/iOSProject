import UIKit
import Firebase
import FirebaseDatabase

class GoalsViewController: UIViewController {
    var speler: Speler!
    var index: Int!
    private var indexPathToEdit: IndexPath!
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
    var userID: String!
    
    override func viewDidLoad() {
        userID = Auth.auth().currentUser!.uid
        ref = Database.database().reference()
        tableView.allowsSelection = false;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "editGoal"?:
            let editController = segue.destination as! AddGoalViewController
            editController.goal = speler.goals[indexPathToEdit.row]
            editController.navigationItem.title = "Goal wijzigen"
        case "addGoal"?:
            break
        default:
            fatalError("No segue found!")
        }
    }
    
    @IBAction func unwindFromGoals(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didAddGoal"?:
            let addGoalController = segue.source as! AddGoalViewController
            speler.goals.append(addGoalController.goal!)
            tableView.insertRows(at: [IndexPath(row: speler.goals.count - 1, section: 0)], with: .automatic)
            ref.child("teams").child(userID).child("spelers").child(String(index)).setValue(Ploeg.spelerToDict(speler: self.speler))
        case "didEditGoal"?:
            tableView.reloadRows(at: [indexPathToEdit], with: .automatic)
            ref.child("teams").child(userID).child("spelers").child(String(index)).setValue(Ploeg.spelerToDict(speler: self.speler))
        default:
            fatalError("Unknown segue")
        }
    }
}

extension GoalsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            (action, view, completionHandler) in
            self.indexPathToEdit = indexPath
            self.performSegue(withIdentifier: "editGoal", sender: self)
            completionHandler(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            self.speler.goals.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.ref.child("teams").child(self.userID).child("spelers").child(String(self.index))
            .setValue(Ploeg.spelerToDict(speler: self.speler))
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

extension GoalsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speler.goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as! GoalCell
        cell.goal = speler.goals[indexPath.row]
        return cell
    }
}
