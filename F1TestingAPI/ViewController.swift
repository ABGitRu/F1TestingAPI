//
//  ViewController.swift
//  F1TestingAPI
//
//  Created by Mac on 24.05.2021.
//

import UIKit



class ViewController: UIViewController {
    
    var delegate: UpdatesDelegate?
    
    let firstUrl = "https://ergast.com/api/f1/2010/driverStandings.json"
    
    let secondUrl = "https://ergast.com/api/f1/current/driverStandings.json"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let standingsVC = segue.destination as? StandingsViewController else { return }
        
        standingsVC.url = segue.identifier == "2010" ? firstUrl : secondUrl
    }
    
}

