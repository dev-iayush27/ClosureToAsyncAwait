//
//  ViewController.swift
//  ClosureToAsyncAwait
//
//  Created by Ayush Gupta on 28/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var tableview: UITableView!
    
    private var users: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        getUserData()
    }
    
    // MARK: API call Using closure (escaping closure)
    
    //    private func getUserData() {
    //        WebService.fetchUserData { [weak self] result, error in
    //            if let error = error {
    //                print(error.errorDescription ?? "Error Found")
    //            } else {
    //                self?.users = result
    //                print(self?.users ?? [])
    //
    //                DispatchQueue.main.async {
    //                    self?.tableview.reloadData()
    //                }
    //            }
    //        }
    //    }
    
    // MARK: API call Using async/await
    
    private func getUserData() {
        Task {
            do {
                self.users = try await WebService.fetchUserData()
                print(self.users)
                
                await MainActor.run {
                    self.tableview.reloadData()
                }
            } catch(let error) {
                let userError = UserError.custom(error: error)
                print(userError.errorDescription ?? "Error Found")
            }
        }
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
