//
//  ViewController.swift
//  DataBinding
//
//  Created by Chun-Li Cheng on 2021/12/7.
//

import UIKit

// Model
struct User: Codable {
    let name: String
}

//// ViewModel
//struct UserListViewModel {
//    var users: Observable<[UserTableViewCellViewModel]> = Observable([])
//}
//
//struct UserTableViewCellViewModel {
//    let name: String
//}
//
//// Controller
//class ViewController: UIViewController {
//    private var viewModel = UserListViewModel()
//    private let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self,
//                       forCellReuseIdentifier: "cell")
//        return table
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(tableView)
//        tableView.frame = view.bounds
//        tableView.dataSource = self
//        viewModel.users.bind { _ in
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.reloadData()
//            }
//        }
//        
//        fetchData()
//    }
//    
//    func fetchData() {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            
//            if error == nil {
//                do {
//                    let data = try Data(contentsOf: url)
//                    let userModels = try JSONDecoder().decode([User].self, from: data)
//                    self.viewModel.users.value = userModels.compactMap({
//                        UserTableViewCellViewModel(name: $0.name)
//                    })
//                }
//                catch {
//                    
//                }
//            }
//            
//        }.resume()
//        
//        
//    }
//
//}
//
//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.users.value?.count ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = viewModel.users.value?[indexPath.row].name
//        return cell
//    }
//    
//    
//}
//
