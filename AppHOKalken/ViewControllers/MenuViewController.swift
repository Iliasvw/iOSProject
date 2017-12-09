import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var cardsButton: UIButton!
    @IBOutlet weak var playerButton: UIButton!
    @IBOutlet weak var goalButton: UIButton!
    @IBOutlet weak var statisticsButton: UIButton!
    @IBOutlet weak var naamLabel: UILabel!
    
    var speler: Speler!
    
    override func viewDidLoad() {
        cardsButton.layer.cornerRadius = 10
        playerButton.layer.cornerRadius = 10
        goalButton.layer.cornerRadius = 10
        statisticsButton.layer.cornerRadius = 10
        naamLabel.text = "\(speler.naam), \(speler.voornaam)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "showInfoSpeler"?:
                let infoController = segue.destination as! SpelerInfoViewController
                infoController.speler = speler
            case "showKaarten"?:
                let kaartenController = segue.destination as! KaartenViewController
                kaartenController.kaarten = speler.kaarten
            default:
                fatalError("No segue found")
        }
    }
}
