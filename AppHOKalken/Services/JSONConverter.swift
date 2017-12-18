import UIKit

class JSONConverter {
    
    static func toPloegObject(dict: [String: Any]) -> Ploeg {
        let team = Ploeg(naam: dict["naam"] as! String, website: dict["website"] as! String, adres: dict["adres"] as! String, email: dict["email"] as! String)
        team.spelers = []
        if let _ = dict["spelers"] {
            for (value) in (dict["spelers"] as! NSArray) {
                let val = value as! [String : Any]
                let speler = Speler(naam: val["naam"] as! String, voornaam: val["voornaam"] as! String,
                                    nummer: val["nummer"] as! String, positie: Speler.Positie(rawValue: val["positie"] as! String)!)
                if let _ = val["kaarten"] {
                    for (kaart) in (val["kaarten"] as! NSArray) {
                        let krt = kaart as! [String : Any]
                        let k = Kaart(kaartType: Kaart.KaartType(rawValue: krt["kaartType"] as! String)!, datum: (krt["datum"] as! String).toDate(dateFormat: "dd/MMM/yyyy HH:mm:ss"), omschrijving: krt["omschrijving"] as! String)
                        speler.kaarten.append(k)
                    }
                }
                
                if let _ = val["goals"] {
                    for (goal) in (val["goals"] as! NSArray) {
                        let gl = goal as! [String : Any]
                        let g = Goal(datum: (gl["datum"] as! String).toDate(dateFormat: "dd/MMM/yyyy HH:mm:ss"), goalType: Goal.GoalType(rawValue: gl["goalType"] as! String)!,
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
    static func toPloegDict(ploeg: Ploeg) -> [String:Any] {
        var dic: [String: Any] = [:]
        dic["naam"] = ploeg.naam
        dic["website"] = ploeg.website
        dic["adres"] = ploeg.adres
        dic["email"] = ploeg.email
        
        dic["spelers"] = JSONConverter.spelersToDict(spelers: ploeg.spelers)
        return dic
    }
    
    static func spelersToDict(spelers: [Speler]) -> [String:Any] {
        var spelerDic: [String:Any] = [:]
        for (i, element) in spelers.enumerated() {
            spelerDic[String(i)] = JSONConverter.spelerToDict(speler: element)
        }
        return spelerDic
    }
    
    static func spelerToDict(speler: Speler) -> [String:Any] {
        var spelerInfo: [String:Any] = [:]
        let element = speler;
        spelerInfo["naam"] = element.naam
        spelerInfo["voornaam"] = element.voornaam
        spelerInfo["nummer"] = element.nummer
        spelerInfo["positie"] = element.positie.rawValue
        
        var kaartenDic: [String: Any] = [:]
        for (index, element) in speler.kaarten.enumerated() {
            var kaart: [String: Any] = [:]
            kaart["datum"] = element.datum.toString(dateFormat: "dd/MMM/yyyy HH:mm:ss")
            kaart["omschrijving"] = element.omschrijving
            kaart["kaartType"] = element.kaartType.rawValue
            kaartenDic[String(index)] = kaart
        }
        spelerInfo["kaarten"] = kaartenDic
        
        var goalsDic: [String: Any] = [:]
        for (index, element) in speler.goals.enumerated() {
            var goal: [String: Any] = [:]
            goal["datum"] = element.datum.toString(dateFormat: "dd/MMM/yyyy HH:mm:ss")
            goal["omschrijving"] = element.omschrijving
            goal["goalType"] = element.goalType.rawValue
            goalsDic[String(index)] = goal
        }
        spelerInfo["goals"] = goalsDic
        return spelerInfo
    }
}

/*
 CONVERTING DATE TO STRING
 CONVERTING STRING TO DATE
 SOURCE: https://iosrevisited.blogspot.be/2017/10/convert-date-string-swift4.html
 */

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String
{
    func toDate( dateFormat format  : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        return (dateFormatter.date(from: self))!
    }
    
}
