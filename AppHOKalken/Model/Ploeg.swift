import UIKit

class Ploeg {
    var naam: String
    var website: String
    var adres: String
    var email: String
    var spelers: [Speler]!
    
    init(naam: String, website: String, adres: String, email: String) {
        self.naam = naam
        self.website = website
        self.adres = adres
        self.email = email
    }
    
    static func toObject(dict: [String: Any]) -> Ploeg {
        let team = Ploeg(naam: dict["naam"] as! String, website: dict["website"] as! String, adres: dict["adres"] as! String, email: dict["email"] as! String)
        team.spelers = []
        if let _ = dict["spelers"] {
            for (value) in (dict["spelers"] as! NSArray) {
                let val = value as! [String : Any]
                let speler = Speler(naam: val["naam"] as! String, voornaam: val["voornaam"] as! String,
                                    nummer: val["nummer"] as! String, positie: Speler.Positie(rawValue: val["positie"] as! String)!)
                if let _ = val["kaarten"] {
                    for (_, kaart) in (val["kaarten"] as! [String : Any]) {
                        let krt = kaart as! [String : Any]
                        let k = Kaart(kaartType: Kaart.KaartType(rawValue: krt["kaartType"] as! String)!, datum: Date(), omschrijving: krt["omschrijving"] as! String)
                        speler.kaarten.append(k)
                    }
                }
                
                if let _ = val["goals"] {
                    for (_, goal) in (val["goals"] as! [String : Any]) {
                        let gl = goal as! [String : Any]
                        let g = Goal(datum: Date(), goalType: Goal.GoalType(rawValue: gl["goalType"] as! String)!,
                                     omschrijving: gl["omschrijving"] as! String)
                        speler.goals.append(g)
                    }
                }
                team.spelers.append(speler)
            }
        }
        
        return team
    }
    
    /* OMZETTEN NAAR JSON */
    func toDict() -> [String:Any] {
        var dic: [String: Any] = [:]
        dic["naam"] = self.naam
        dic["website"] = self.website
        dic["adres"] = self.adres
        dic["email"] = self.email
        
        var spelerDic: [String:Any] = [:]
        if let _ = spelers {
            for (i, element) in spelers.enumerated() {
                var spelerInfo: [String:Any] = [:]
                spelerInfo["naam"] = element.naam
                spelerInfo["voornaam"] = element.voornaam
                spelerInfo["nummer"] = element.nummer
                spelerInfo["positie"] = element.positie.rawValue
                
                var kaartenDic: [String: Any] = [:]
                for (index, element) in spelers[i].kaarten.enumerated() {
                    var kaart: [String: Any] = [:]
                    kaart["datum"] = element.datum
                    kaart["omschrijving"] = element.omschrijving
                    kaart["kaartType"] = element.kaartType.rawValue
                    kaartenDic[String(index)] = kaart
                }
                spelerInfo["kaarten"] = kaartenDic
                
                var goalsDic: [String: Any] = [:]
                for (index, element) in spelers[i].goals.enumerated() {
                    var goal: [String: Any] = [:]
                    goal["datum"] = element.datum
                    goal["omschrijving"] = element.omschrijving
                    goal["goalType"] = element.goalType.rawValue
                    goalsDic[String(index)] = goal
                }
                spelerInfo["goals"] = goalsDic
                spelerDic[String(i)] = spelerInfo
            }
        }
        dic["spelers"] = spelerDic
        return dic
    }
}

