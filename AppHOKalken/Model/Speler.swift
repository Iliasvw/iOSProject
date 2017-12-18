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
        case t = "Trainer"
        
        static let values = [Positie.dm, .v, .m, .a, .t]
    }
    
    var kaarten: [Kaart] = []
    var goals: [Goal] = []
    
    init(naam: String, voornaam: String, nummer: String, positie: Positie) {
        self.naam = naam
        self.voornaam = voornaam
        self.nummer = nummer
        self.positie = positie
    }
    
    func addKaart(kaart: Kaart) {
        self.kaarten.append(kaart)
    }
    
    func addGoal(goal: Goal) {
        self.goals.append(goal)
    }
    
    func geleKaarten() -> [Kaart] {
        return kaarten.filter { $0.kaartType == Kaart.KaartType.g }.sorted { $0.datum < $1.datum }
    }
    
    func rodeKaarten() -> [Kaart] {
        return kaarten.filter { $0.kaartType == Kaart.KaartType.r }.sorted { $0.datum < $1.datum }
    }
}
