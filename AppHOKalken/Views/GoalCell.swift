import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var datumLabel: UILabel!
    @IBOutlet weak var omschrijvingLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var goal: Goal! {
        didSet {
            datumLabel.text = "\(goal.formatDate())"
            omschrijvingLabel.text = goal.omschrijving
            typeLabel.text = goal.goalType.rawValue
        }
    }
}
