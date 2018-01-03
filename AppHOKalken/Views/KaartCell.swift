import UIKit

class KaartCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var datumLabel: UILabel!
    @IBOutlet weak var omschrijvingLabel: UILabel!
    
    var kaart: Kaart! {
        didSet {
            colorView.layer.cornerRadius = 8
            datumLabel.text = "\(kaart.formatDate())"
            omschrijvingLabel.text = kaart.omschrijving
            if kaart.kaartType == .g {
                colorView.backgroundColor = UIColor.yellow
            } else {
                colorView.backgroundColor = UIColor.red
            }
        }
    }
}


