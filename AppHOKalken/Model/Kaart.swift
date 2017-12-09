import UIKit

class Kaart {
    enum KaartType: String {
        case r = "Rood"
        case g = "Geel"
        
        static let values = [KaartType.g, .r]
    }
    
    var datum: Date
    var kaartType: KaartType
    var omschrijving: String
    
    init(kaartType: KaartType, datum: Date, omschrijving: String) {
        self.kaartType = kaartType
        self.datum = datum
        self.omschrijving = omschrijving
    }
}