import UIKit

class GoalsViewController: UIViewController {
    var speler: Speler!
    private var indexPathToEdit: IndexPath!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
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
            tableView.insertRows(at: [IndexPath(row: speler.kaarten.count - 1, section: 0)], with: .automatic)
        case "didEditGoal"?:
            tableView.reloadRows(at: [indexPathToEdit], with: .automatic)
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
