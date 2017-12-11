import UIKit
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        ref = Database.database().reference()
    }
    
    @IBAction func login() {
        if let email = self.emailField.text, let password = self.passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    if(email.isEmpty || password.isEmpty) {
                        self.showAlert(title: "Inloggegevens", message: "Gelieve het e-mailadres en wachtwoord in te vullen.")
                    } else {
                        self.showAlert(title: "Ongeldige login", message: "Geen gebruiker gevonden met deze logingegevens.")
                    }
                } else {
                    self.emailField.text = ""
                    self.passwordField.text = ""
                    self.performSegue(withIdentifier: "showSpelers", sender: self)
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .`default`, handler: { _ in
            return
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwindFromSpelers(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didLogout"?:
            break
        default:
            fatalError("Unknown segue")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "showSpelers"?:
                //let controller = segue.destination as! SpelersViewController
                break
            case "addTeam"?:
                break
            default:
                fatalError("No segue found!")
        }
    }
    
    @IBAction func unwindFromAddTeam(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didAddTeam"?:
            let addTeamController = segue.source as! AddTeamViewController
            let team = addTeamController.ploeg!
            print("\(team.naam), \(team.email), \(team.website), \(team.adres)")
        default:
            fatalError("Unkown segue")
        }
    }
}
