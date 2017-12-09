import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func unwindFromAddTeam(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didAddTeam"?:
            let addTeamController = segue.source as! AddTeamViewController
            let team = addTeamController.ploeg!
            print("\(team.naam), \(team.email), \(team.website), \(team.adres)")
        default:
            fatalError("Unkown segue")
        }
    }
}
