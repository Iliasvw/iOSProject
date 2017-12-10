import UIKit
import Charts

class GrafiekenViewController: UIViewController {
    @IBOutlet weak var goalsButton: UIButton!
    @IBOutlet weak var kaartenButton: UIButton!
    @IBOutlet weak var barChart: BarChartView!
    
    var speler: Speler!
    
    override func viewDidLoad() {
        goalsButton.layer.cornerRadius = 8
        kaartenButton.layer.cornerRadius = 8
        self.fillGoalsBarChart()
    }
    
    func fillGoalsBarChart() {
        let goals: [Goal] = speler.goals
        let calendar = Calendar.current
        var dictionary: [Int:Int] = [0:0]
        
        for i in 1...12 {
            dictionary[i] = 0
        }
        
        for i in goals {
            let month = calendar.component(.month, from: i.datum)
            dictionary[month]! += 1
        }
        
        var dataset: [BarChartDataEntry] = []
        
        for i in dictionary {
            let entry = BarChartDataEntry(x: Double(i.key), y: Double(i.value))
            dataset.append(entry)
        }
        
        let dataSet = BarChartDataSet(values: dataset, label: "Aantal goals")
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        barChart.chartDescription?.text = "Goals van \(speler.naam) \(speler.voornaam)"
        barChart.notifyDataSetChanged()
    }
    
    func fillKaartenBarChart() {
        let kaarten: [Kaart] = speler.kaarten
        let calendar = Calendar.current
        var dictionary: [Int:Int] = [0:0]
        
        for i in 1...12 {
            dictionary[i] = 0
        }
        
        for i in kaarten {
            let month = calendar.component(.month, from: i.datum)
            dictionary[month]! += 1
        }
        
        var dataset: [BarChartDataEntry] = []
        
        for i in dictionary {
            let entry = BarChartDataEntry(x: Double(i.key), y: Double(i.value))
            dataset.append(entry)
        }
        
        let dataSet = BarChartDataSet(values: dataset, label: "Aantal kaarten")
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        barChart.chartDescription?.text = "Kaarten van \(speler.naam) \(speler.voornaam)"
        barChart.notifyDataSetChanged()
    }
    
    @IBAction func clickGoals() {
        self.fillGoalsBarChart()
    }
    
    @IBAction func clickKaarten() {
        self.fillKaartenBarChart()
    }
}
