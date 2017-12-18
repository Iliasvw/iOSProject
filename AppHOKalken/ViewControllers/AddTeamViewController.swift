import UIKit
import Firebase
import FirebaseDatabase

class AddTeamViewController: UITableViewController {
    var ploeg: Ploeg?
    
    @IBOutlet weak var naamField: UITextField!
    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var adresField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        saveButton.isEnabled = false
        websiteField.addTarget(self, action: #selector(checkForm), for: .editingChanged)
        adresField.addTarget(self, action: #selector(checkForm), for: .editingChanged)
        emailField.addTarget(self, action: #selector(checkForm), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(checkForm), for: .editingChanged)
        confirmPasswordField.addTarget(self, action: #selector(checkForm), for: .editingChanged)
    }
    
    @objc func checkForm() {
        if let naam = naamField.text, let website = websiteField.text, let adres = adresField.text,
            let email = emailField.text, let password = passwordField.text, let confirmPass = confirmPasswordField.text {
            if naam.isEmpty || website.isEmpty || adres.isEmpty || email.isEmpty || password.isEmpty || confirmPass.isEmpty {
                saveButton.isEnabled = false
            } else {
                saveButton.isEnabled = true
            }
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func save() {
        validateUser()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .`default`, handler: { _ in
            return
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "didAddTeam"?:
            ploeg = Ploeg(naam: naamField.text!, website: websiteField.text!, adres: adresField.text!, email: emailField.text!)
            let userID = Auth.auth().currentUser!.uid
            print("Logged in user: " + userID)
            self.ref.child("teams").child(userID).setValue(JSONConverter.toPloegDict(ploeg: ploeg!))
        default:
            fatalError("Unknown segue")
        }
    }
    
    func validateUser() {
        let email = emailField.text!
        let pass = passwordField.text!
        let confirmPass = confirmPasswordField.text!
        if !isValidEmail(testStr: email) {
            self.showAlert(title: "Ongeldig e-maildres", message: "Gelieve een geldig e-mailadres in te geven!")
        } else if pass != confirmPass {
            self.showAlert(title: "Error!", message: "De wachtwoorden komen niet overeen. Geef de wachtwoorden opnieuw in.")
            passwordField.text = ""
            confirmPasswordField.text = ""
        } else {
            if pass.count < 6 {
                self.showAlert(title: "Error!", message: "De minimumlengte van het wachtwoord is 6 karakters.")
                passwordField.text = ""
                confirmPasswordField.text = ""
            } else {
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    print("User created!")
                    self.performSegue(withIdentifier: "didAddTeam", sender: self)
                }
            }
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}
