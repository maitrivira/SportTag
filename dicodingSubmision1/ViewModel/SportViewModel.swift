//
//  SportViewModel.swift
//  dicodingSubmision1
//
//  Created by Maitri Vira on 28/05/21.
//

import Foundation

class SportViewModel{
    
    private var apiService = ApiService()
    private var sportData = [Sport]()
    
    func fetchData(completion: @escaping () -> Void){
        
        apiService.getData{ [weak self] (result) in
            switch result{
            case .success(let listOf):
                self?.sportData = listOf.sports
                completion()
            case .failure(let error):
                print("error: ", error)
            }
        }
        
    }
    
    func numberOfRowsInSection() -> Int{
        if sportData.count != 0{
            return sportData.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Sport{
        return sportData[indexPath.row]
    }
}
