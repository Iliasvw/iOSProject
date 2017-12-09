import UIKit

class SpelerInfoViewController: UIViewController {
    @IBOutlet weak var nummerLabel: UILabel!
    @IBOutlet weak var naamLabel: UILabel!
    @IBOutlet weak var voornaamLabel: UILabel!
    @IBOutlet weak var positieLabel: UILabel!
    @IBOutlet weak var goalsLabel: UILabel!
    @IBOutlet weak var geleKaartenLabel: UILabel!
    @IBOutlet weak var rodeKaartenLabel: UILabel!
    
    var speler: Speler!
    
    override func viewDidLoad() {
        nummerLabel.text = speler.nummer
        naamLabel.text = speler.naam
        voornaamLabel.text = speler.voornaam
        positieLabel.text = speler.positie.rawValue
        goalsLabel.text = "\(speler.goals.count)"
        geleKaartenLabel.text = "\(speler.geleKaarten().count)"
        rodeKaartenLabel.text = "\(speler.rodeKaarten().count)"
    }
}
