import UIKit

class AddTeamViewController: UITableViewController {
    var ploeg: Ploeg?
    
    @IBOutlet weak var naamField: UITextField!
    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var adresField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func save() {
        performSegue(withIdentifier: "didAddTeam", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "didAddTeam"?:
            ploeg = Ploeg(naam: naamField.text!, website: websiteField.text!, adres: adresField.text!, email: emailField.text!)
        default:
            fatalError("Unknown segue")
        }
    }
}
