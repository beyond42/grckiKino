//
//  Talon.swift
//  Grcki_Kino
//
//  Created by Ivana Todorovic on 20/10/2020.
//

import UIKit

class TalonViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var talonCV: UICollectionView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var chosenNumbers: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var drawIdLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var drawTimeLabel: UILabel!
    
    let formatter = DateFormatter()
    
    var numbers: [String] = []
    var selectedNumbers: [String] = []
    var countSelectedNumbers: Int = 0
    
    public var drawID: Int = 0
    public var drawTime: Int = 0
    var countdownTimer: CountdownTimer = CountdownTimer()
    
    private let itemsPerRow: CGFloat = 4
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillNumbers()
        talonCV?.delegate = self
        talonCV?.dataSource = self
        talonCV?.allowsMultipleSelection = true
        talonCV?.frame.size.width = UIScreen.main.bounds.width
        chosenNumbers?.frame.size.width = UIScreen.main.bounds.width
        drawIdLabel.text = String(drawID)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let timeLeft = Date(timeIntervalSince1970: Double(self.drawTime)/1000)
            self.countdownTimer.updateTime(date: timeLeft)
            self.timeLeftLabel.text = "\(self.countdownTimer.timeLeftString)"
        }
        
        let dateNum = Double(drawTime/1000)
        let date = Date(timeIntervalSince1970: dateNum)
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "HH:mm"
        let dateStr = formatter.string(from: date)
        drawTimeLabel.text = dateStr
        
        self.navigationController?.title = "Grčki Kino"
    }
    
    func fillNumbers() {
        for i in 1...80 {
            numbers.append(String(i))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "talonCelija", for: indexPath) as! CollectionViewCell
        
        cell.title.text = String(numbers[indexPath.row])
        
        if cell.isSelected {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.random().cgColor
        } else {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.clear.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        countSelectedNumbers += 1
        counterLabel.text = String(countSelectedNumbers)
        
        if countSelectedNumbers >= 15 {
            talonCV.allowsSelection = false
        }
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.random().cgColor
        cell?.layer.borderWidth = 2
        cell?.isSelected = true

        let strData = numbers[indexPath.row]
        selectedNumbers.append(strData)
        
        chosenNumbers.text = selectedNumbers.joined(separator: " ")
        }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        countSelectedNumbers -= 1
        counterLabel.text = String(countSelectedNumbers)
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        selectedNumbers = selectedNumbers.filter{$0 != numbers[indexPath.row]}
        
        chosenNumbers.text = selectedNumbers.joined(separator: " ")
        
        cell?.layer.borderColor = UIColor.clear.cgColor
        cell?.layer.borderWidth = 2
        cell?.isSelected = false
    }
    
}

extension TalonViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
      }
    
    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
    }

    
    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return sectionInsets.left
    }
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
