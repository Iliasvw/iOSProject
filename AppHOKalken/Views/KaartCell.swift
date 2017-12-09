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
    
    /*override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         if !kaart.isInvalidated {
            if kaart.kaartType == .g {
                colorView.backgroundColor = UIColor.red
            } else {
                colorView.backgroundColor = UIColor.yellow
            }
         }
    }*/
}


