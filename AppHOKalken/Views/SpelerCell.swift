import UIKit

class SpelerCell: UITableViewCell {
    
    @IBOutlet weak var nummerLabel: UILabel!
    @IBOutlet weak var naamLabel: UILabel!
    @IBOutlet weak var positieLabel: UILabel!
    
    var speler: Speler! {
        didSet {
            nummerLabel.text = speler.nummer
            naamLabel.text = "\(speler.naam), \(speler.voornaam)"
            positieLabel.text = speler.positie.rawValue
        }
    }
    
    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if !project.isInvalidated {//kijkt of project nog geldig is
            colorView.backgroundColor = project.color
        }
    }*/
}

