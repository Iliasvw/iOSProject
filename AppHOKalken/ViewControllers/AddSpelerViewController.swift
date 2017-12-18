import UIKit

class AddSpelerViewController: UITableViewController {
    var speler: Speler?
    @IBOutlet weak var naamField: UITextField!
    @IBOutlet weak var voornaamField: UITextField!
    @IBOutlet weak var nummerField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        if let speler = speler {
            naamField.text = speler.naam
            voornaamField.text = speler.voornaam
            nummerField.text = speler.nummer
            let statusIndex = Speler.Positie.values.index(of: speler.positie)!
            pickerView.selectRow(statusIndex, inComponent: 0, animated: false)
        } else {
            saveButton.isEnabled = false
        }
        
        naamField.addTarget(self, action: #selector(checkForm), for: .editingChanged)
        voornaamField.addTarget(self, action: #selector(checkForm), for: .editingChanged)
        nummerField.addTarget(self, action: #selector(checkForm), for: .editingChanged)
    }
    
    @IBAction func save() {
        if speler != nil {
            performSegue(withIdentifier: "didEditSpeler", sender: self)
        } else {
            performSegue(withIdentifier: "didAddSpeler", sender: self)
        }
    }
    
    @objc func checkForm() {
        if let naam = naamField.text, let voornaam = voornaamField.text, let nummer = nummerField.text {
            if naam.isEmpty || voornaam.isEmpty || nummer.isEmpty {
                saveButton.isEnabled = false
            } else {
                saveButton.isEnabled = true
            }
        } else {
            saveButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "didAddSpeler"?:
            let positie = Speler.Positie.values[pickerView.selectedRow(inComponent: 0)]
            speler = Speler(naam: naamField.text!, voornaam: voornaamField.text!, nummer: nummerField.text!, positie: positie)
        case "didEditSpeler"?:
            speler!.naam = naamField.text!
            speler!.voornaam = voornaamField.text!
            speler!.nummer = nummerField.text!
            let positie = Speler.Positie.values[pickerView.selectedRow(inComponent: 0)]
            speler!.positie = positie
        default:
            fatalError("Unknown segue")
        }
    }
}

extension AddSpelerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Speler.Positie.values.count
    }
}

extension AddSpelerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Speler.Positie.values[row].rawValue
    }
}
