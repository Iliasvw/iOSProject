import UIKit

class GrafiekenViewController: UIViewController {
    @IBOutlet weak var goalsButton: UIButton!
    @IBOutlet weak var kaartenButton: UIButton!
    
    var speler: Speler!
    
    override func viewDidLoad() {
        goalsButton.layer.cornerRadius = 8
        kaartenButton.layer.cornerRadius = 8
    }
}
