//
//  StandingsViewController.swift
//  F1TestingAPI
//
//  Created by Mac on 24.05.2021.
//

import UIKit

protocol UpdatesDelegate {
    func didFinishUpdates(finished: Bool)
}

class StandingsViewController: UITableViewController {
    
    var data: Welcome?
    
    let fetch = NetworkService.shared
    
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(with: url ?? "")
        NetworkService.shared.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.mrData.standingsTable.standingsLists.first?.driverStandings.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let standings = data?.mrData.standingsTable.standingsLists.first?.driverStandings[indexPath.row]
        
        cell.textLabel?.text = " Driver: \(standings?.driver.familyName ?? "")\n Points: \(standings?.points ?? "")\n Position in championship: \(standings?.position ?? "")"
        cell.textLabel?.numberOfLines = .zero

        return cell
    }
    
    private func fetchData(with url: String) {
        fetch.fetchData(expectedType: Welcome.self, url: url) { (result) in
            switch result {
            case .success(let standings):
                self.data = standings
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension StandingsViewController: UpdatesDelegate {
    func didFinishUpdates(finished: Bool) {
         finished ? tableView.reloadData() : nil
    }
}
