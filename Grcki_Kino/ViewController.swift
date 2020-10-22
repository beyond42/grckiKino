//
//  ViewController.swift
//  Grcki_Kino
//
//  Created by Ivana Todorovic on 19/10/2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var gameTable: UITableView!
    var games: [Game] = []
    var times: [String] = []
    var timerTimes: [String] = []
    var timer: Timer?
    var countdownTimer: CountdownTimer = CountdownTimer()
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTable.dataSource = self
        gameTable.delegate = self
        getGamesData()
        gameTable.frame.size.width = UIScreen.main.bounds.width
    }
    
    func getGamesData() {
        if let url = URL(string: "https://api.opap.gr/draws/v3.0/1100/upcoming/20") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                     let res = try JSONDecoder().decode([Game].self, from: data)
                    self.games = res
                    self.times = self.formatDates(games: self.games)
                    DispatchQueue.main.async {
                        self.gameTable.reloadData()
                    }
                  } catch let error {
                     print(error)
                  }
               }
           }.resume()
        }
    }
    
    func formatDates(games: [Game]) -> [String] {
        for game in games {
            let num = game.drawTime
            let dateNum = Double(num/1000)
            let date = Date(timeIntervalSince1970: dateNum)
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.dateFormat = "HH:mm"
            let dateStr = formatter.string(from: date)
            times.append(dateStr)
        }
        return times
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GamesField", for: indexPath)

        cell.textLabel?.text = "\(times[indexPath.row])"
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let timeLeft = Date(timeIntervalSince1970: Double(self.games[indexPath.row].drawTime)/1000)
            self.countdownTimer.updateTime(date: timeLeft)
            cell.detailTextLabel?.text = "\(self.countdownTimer.timeLeftString)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "talonViewController") as? TalonViewController
        vc?.drawID = games[indexPath.row].drawId
        vc?.drawTime = games[indexPath.row].drawTime
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

