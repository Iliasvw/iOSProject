import UIKit

class AddKaartViewController: UITableViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var omschrijvingField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var kaart: Kaart?
    
    override func viewDidLoad() {
        let loc = Locale(identifier: "nl")
        datepicker.locale = loc
        if let kaart = kaart {
            let statusIndex = Kaart.KaartType.values.index(of: kaart.kaartType)!
            pickerView.selectRow(statusIndex, inComponent: 0, animated: false)
            datepicker.setDate(kaart.datum, animated: true)
            omschrijvingField.text = kaart.omschrijving
        }
        omschrijvingField.addTarget(self, action: #selector(checkOmschrijving), for: .editingChanged)
    }
    
    @IBAction func save() {
        if kaart == nil {
            performSegue(withIdentifier: "didAddKaart", sender: self)
        } else {
            performSegue(withIdentifier: "didEditKaart", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "didAddKaart"?:
            let kaartType = Kaart.KaartType.values[pickerView.selectedRow(inComponent: 0)]
            let datum = datepicker.date
            kaart = Kaart(kaartType: kaartType, datum: datum, omschrijving: omschrijvingField.text!)
        case "didEditKaart"?:
            let kaartType = Kaart.KaartType.values[pickerView.selectedRow(inComponent: 0)]
            kaart!.omschrijving = omschrijvingField.text!
            kaart!.kaartType = kaartType
            kaart!.datum = datepicker.date
        default:
            fatalError("Unknown segue")
        }
    }
    
    @objc func checkOmschrijving() {
        if let text = omschrijvingField.text {
            if text.count > 40 {
                saveButton.isEnabled = false
            } else {
                saveButton.isEnabled = true
            }
        } else {
            saveButton.isEnabled = true
        }
    }
}

extension AddKaartViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Kaart.KaartType.values.count
    }
}

extension AddKaartViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Kaart.KaartType.values[row].rawValue
    }
}
