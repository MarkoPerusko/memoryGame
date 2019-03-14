//
//  ViewController.swift
//  memoryGame
//
//  Created by Mac on 3/12/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var table: UIView!
    @IBOutlet weak var congratulations: UILabel!
    
    
    
    var cards: [UIImage?] = [UIImage(named: "1.png"), UIImage(named: "2.png"), UIImage(named: "3.png"), UIImage(named: "4.png"), UIImage(named: "5.png"), UIImage(named: "6.png"), UIImage(named: "7.png"), UIImage(named: "8.png"), UIImage(named: "9.png"), UIImage(named: "10.png"), UIImage(named: "11.png"), UIImage(named: "12.png"), UIImage(named: "13.png"), UIImage(named: "14.png"), UIImage(named: "15.png"), UIImage(named: "16.png"), UIImage(named: "17.png"), UIImage(named: "18.png"), UIImage(named: "1.png"), UIImage(named: "2.png"), UIImage(named: "3.png"), UIImage(named: "4.png"), UIImage(named: "5.png"), UIImage(named: "6.png"), UIImage(named: "7.png"), UIImage(named: "8.png"), UIImage(named: "9.png"), UIImage(named: "10.png"), UIImage(named: "11.png"), UIImage(named: "12.png"), UIImage(named: "13.png"), UIImage(named: "14.png"), UIImage(named: "15.png"), UIImage(named: "16.png"), UIImage(named: "17.png"), UIImage(named: "18.png")]
    
    var listOfCards = [UIImageView]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableSize()
        createFields()
        
        hideCongratulations()
    }
    
    
    
    func tableSize() {
        table.frame.size = CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 20)
        table.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    }
    
    func createFields() {
        cards.shuffle()
        
        for i in 0...35 {
            let field = UIButton(frame: CGRect(x: CGFloat(i % 6) * table.frame.width / 6, y: CGFloat(i / 6) * table.frame.height / 6, width: table.frame.width / 6, height: table.frame.height / 6))
            let card = UIImageView(frame: CGRect(x: CGFloat(i % 6) * table.frame.width / 6, y: CGFloat(i / 6) * table.frame.height / 6, width: table.frame.width / 6, height: table.frame.height / 6))
            
            table.addSubview(field)
            table.addSubview(card)
            
            field.tag = i
            card.tag = i
            
            field.backgroundColor = .yellow
            field.layer.borderWidth = 3
            field.layer.borderColor = UIColor.gray.cgColor
            
            card.layer.borderWidth = 3
            card.layer.borderColor = UIColor.gray.cgColor
            card.image = cards[i]
            card.isHidden = true
            listOfCards.append(card)
            
            field.addTarget(self, action: #selector(selectCard(_:)), for: .touchUpInside)
        }
    }
    
    func hideCongratulations() {
        congratulations.frame.size = CGSize(width: table.frame.width, height: congratulations.frame.height)
        congratulations.frame.origin = CGPoint(x: table.frame.origin.x, y: table.frame.origin.y + table.frame.size.height)
        congratulations.isHidden = true
    }
    
    
    
    
    var counter = 0
    var numberOfPairedCards = 0
    var firstField: UIButton!
    var secondField: UIButton!
    var firstCard: UIImageView!
    var secondCard: UIImageView!
}



extension ViewController {
    @objc func selectCard(_ field: UIButton) {
        
        // Opening first card
        if counter == 0 {
            if firstCard != nil, secondCard != nil {
                firstCard.isHidden = true
                secondCard.isHidden = true
            }
            
            firstField = field
            
            for f in listOfCards {
                if f.tag == field.tag {
                    firstCard = f
                    firstCard.isHidden = false
                }
            }
            
            counter = 1
            
            // Opening second card
        } else if counter == 1 {
            
            // Same card selected
            if field.tag == firstField.tag {
                firstCard.isHidden = true
                
                // Different card selected
            } else {
                secondField = field
                
                for f in listOfCards {
                    if f.tag == field.tag {
                        secondCard = f
                        secondCard.isHidden = false
                    }
                }
                
                // First and second card are the same
                if firstCard.image == secondCard.image {
                    
                    numberOfPairedCards += 2
                    
                    UIView.animate(withDuration: 0.7) {
                        self.firstField.alpha = 0
                        self.secondField.alpha = 0
                        self.firstField.isEnabled = false
                        self.secondField.isEnabled = false
                        self.firstCard.alpha = 0
                        self.secondCard.alpha = 0
                        
                    }
                }
            }
            
            if numberOfPairedCards == 36 {
                congratulations.isHidden = false
            }
            
            counter = 0
        }
    }
}

