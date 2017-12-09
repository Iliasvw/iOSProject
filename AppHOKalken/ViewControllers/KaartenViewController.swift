import UIKit

class KaartenViewController: UIViewController {
    
    var speler: Speler!
    private var indexPathToEdit: IndexPath!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.allowsSelection = false;
    }
    
    @IBAction func unwindFromAddKaarten(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didAddKaart"?:
            let addKaartController = segue.source as! AddKaartViewController
            speler.kaarten.append(addKaartController.kaart!)
            tableView.insertRows(at: [IndexPath(row: speler.kaarten.count - 1, section: 0)], with: .automatic)
        case "didEditKaart"?:
            tableView.reloadRows(at: [indexPathToEdit], with: .automatic)
        default:
            fatalError("Unknown segue")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "editKaart"?:
                let editController = segue.destination as! AddKaartViewController
                editController.kaart = speler.kaarten[indexPathToEdit.row]
                editController.navigationItem.title = "Kaart wijzigen"
            case "addKaart"?:
                break
            default:
                fatalError("No segue found!")
        }
    }
}

extension KaartenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            (action, view, completionHandler) in
            self.indexPathToEdit = indexPath
            self.performSegue(withIdentifier: "editKaart", sender: self)
            completionHandler(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            self.speler.kaarten.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

extension KaartenViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speler.kaarten.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kaartCell", for: indexPath) as! KaartCell
        cell.kaart = speler.kaarten[indexPath.row]
        return cell
    }
}
