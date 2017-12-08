import UIKit

class KaartenViewController: UIViewController {
    @IBAction func unwindFromKaarten(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        default:
            fatalError("Unknown segue")
        }
    }
}
