import UIKit

class Speler {
    var naam: String
    var voornaam: String
    var nummer: String
    var positie: Positie
    
    enum Positie: String {
        case dm = "Doelman"
        case v = "Verdediger"
        case m = "Middenvelder"
        case a = "Aanvaller"
        
        static let values = [Positie.dm, .v, .m, .a]
    }
    
    init(naam: String, voornaam: String, nummer: String, positie: Positie) {
        self.naam = naam
        self.voornaam = voornaam
        self.nummer = nummer
        self.positie = positie
    }
}
