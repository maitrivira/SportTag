//
//  ViewController.swift
//  dicodingSubmision1
//
//  Created by Maitri Vira on 27/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sportTableView: UITableView!
    
    private let viewModel = SportViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSportData()
        
        sportTableView.dataSource = self
        sportTableView.delegate = self
        sportTableView.register(UINib(nibName: "SportTableViewCell", bundle: nil), forCellReuseIdentifier: "SportCell")
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadSportData()
    }
    
    private func loadSportData(){
        viewModel.fetchData { [weak self] in
            self?.sportTableView.dataSource = self
            self?.sportTableView.reloadData()
        }
    }
    
    @IBAction func profileAction(_ sender: UIBarButtonItem) {
        let profile = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(profile, animated: true)
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detail = DetailViewController(nibName: "DetailViewController", bundle: nil)
        let sport = viewModel.cellForRowAt(indexPath: indexPath)
        detail.sport = sport
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = viewModel.numberOfRowsInSection()
        
        if row == 0{
            print("tidak ada data")
            tableView.separatorStyle  = .none
            let loader = self.loader()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
                noDataLabel.text          = "No Data"
                noDataLabel.textColor     = UIColor.init(named: "bgColor")
                noDataLabel.textAlignment = .center
                tableView.backgroundView  = noDataLabel
                self.stopLoader(loader)
            }
            
        }else{
            print("ada data")
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
            
        }
        
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.numberOfRowsInSection()
        let cell = tableView.dequeueReusableCell(withIdentifier: "SportCell", for: indexPath) as? SportTableViewCell
        
        if row != 0{
            
            cell?.stopLoading()
            let sport = viewModel.cellForRowAt(indexPath: indexPath)
            cell?.setCellWithValuesOf(sport)
            
        }
        
        return cell!
    }
}
