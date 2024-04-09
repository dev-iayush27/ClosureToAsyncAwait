//
//  ViewController.swift
//  ClosureToAsyncAwait
//
//  Created by Ayush Gupta on 09/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var tableview: UITableView!
    
    private var users: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        self.callUserDataAPI()
    }
    
    // MARK: API call Using closure (escaping closure)
    
    private func callUserDataAPI() {
        WebService.fetchUserData { [weak self] result, error in
            if let error {
                DispatchQueue.main.async {
                    self?.displayAlert(message: error.errorDescription ?? "Error Found")
                }
            } else {
                self?.users = result
                print(self?.users ?? [])
                
                DispatchQueue.main.async {
                    self?.tableview.reloadData()
                }
            }
        }
    }
    
    private func displayAlert(title: String = "Error!", message: String?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        
        cell.textLabel?.text = self.users[indexPath.row].login
        
        return cell
    }
}
