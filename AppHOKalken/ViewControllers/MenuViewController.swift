import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var cardsButton: UIButton!
    @IBOutlet weak var playerButton: UIButton!
    @IBOutlet weak var goalButton: UIButton!
    @IBOutlet weak var statisticsButton: UIButton!
    @IBOutlet weak var naamLabel: UILabel!
    
    var speler: Speler!
    var index: Int!
    
    override func viewDidLoad() {
        naamLabel.text = "\(speler.naam), \(speler.voornaam)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "showInfoSpeler"?:
                let infoController = segue.destination as! SpelerInfoViewController
                infoController.speler = self.speler
            case "showKaarten"?:
                let kaartenController = segue.destination as! KaartenViewController
                kaartenController.speler = self.speler
                kaartenController.index = self.index
            case "showGoals"?:
                let goalsController = segue.destination as! GoalsViewController
                goalsController.speler = self.speler
                goalsController.index = self.index
            case "showGraphs"?:
                let graphsController = segue.destination as! GrafiekenViewController
                graphsController.speler = self.speler
            default:
                fatalError("No segue found")
        }
    }
}
