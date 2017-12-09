import UIKit

class Goal {
    var datum: Date
    
    enum GoalType: String {
        case long = "Lange afstand"
        case short = "Korte afstand"
        case penalty = "Penalty"
        case freekick = "Vrije trap"
        
        static let values = [GoalType.long, .short, .penalty, .freekick]
    }
    
    var goalType: GoalType
    var omschrijving: String
    
    init(datum: Date, goalType: GoalType, omschrijving: String) {
        self.datum = datum
        self.goalType = goalType
        self.omschrijving = omschrijving
    }
}
