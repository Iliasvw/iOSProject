import UIKit

class AddGoalViewController: UITableViewController {
    var goal: Goal?
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var omschrijvingField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        let loc = Locale(identifier: "nl")
        datepicker.locale = loc
        if let goal = goal {
            let statusIndex = Goal.GoalType.values.index(of: goal.goalType)!
            pickerView.selectRow(statusIndex, inComponent: 0, animated: false)
            datepicker.setDate(goal.datum, animated: true)
            omschrijvingField.text = goal.omschrijving
        }
        omschrijvingField.addTarget(self, action: #selector(checkOmschrijving), for: .editingChanged)
    }
    
    @IBAction func save() {
        if goal == nil {
            performSegue(withIdentifier: "didAddGoal", sender: self)
        } else {
            performSegue(withIdentifier: "didEditGoal", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "didAddGoal"?:
            let goalType = Goal.GoalType.values[pickerView.selectedRow(inComponent: 0)]
            let datum = datepicker.date
            goal = Goal(datum: datum, goalType: goalType, omschrijving: omschrijvingField.text!)
        case "didEditGoal"?:
            let goalType = Goal.GoalType.values[pickerView.selectedRow(inComponent: 0)]
            goal!.omschrijving = omschrijvingField.text!
            goal!.goalType = goalType
            goal!.datum = datepicker.date
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

extension AddGoalViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Goal.GoalType.values.count
    }
}

extension AddGoalViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Goal.GoalType.values[row].rawValue
    }
}
