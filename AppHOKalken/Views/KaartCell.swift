import UIKit

class KaartCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var datumLabel: UILabel!
    @IBOutlet weak var omschrijvingLabel: UILabel!
    
    var kaart: Kaart! {
        didSet {
            datumLabel.text = "\(kaart.datum)"
            omschrijvingLabel.text = kaart.omschrijving
            if kaart.kaartType == .g {
                colorView.backgroundColor = UIColor.red
            } else {
                colorView.backgroundColor = UIColor.yellow
            }
        }
    }
    
    /*override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         if !self.kaart.isInvalidated {//kijkt of project nog geldig is
            if kaart.kaartType == .g {
                colorView.backgroundColor = UIColor.red
            } else {
                colorView.backgroundColor = UIColor.yellow
            }
         }
    }*/
}


