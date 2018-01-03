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
}

