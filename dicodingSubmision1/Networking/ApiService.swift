//
//  SportManager.swift
//  dicodingSubmision1
//
//  Created by Maitri Vira on 28/05/21.
//

import Foundation

class ApiService {
    
    private var sport: URLSessionDataTask?
    
    func getData(completion: @escaping (Result<SportModel, Error>) -> Void){
        
        let sportURL = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
        
        guard let url = URL(string: sportURL) else {return}
        
        sport = URLSession.shared.dataTask(with: url){ (data, response, error) in
            
            if let error = error{
                print("DataTask error : \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else{
                print("empty")
                return
            }
            
            print("status code: \(response.statusCode)")
            
            guard let data = data else{
                print("empty data")
                return
            }
            
            do{
                
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(SportModel.self, from: data)
                print("data apiservice", jsonData)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
                
            } catch let error{
                print("data error apiservice", error)
                completion(.failure(error))
                
            }
        }
        sport?.resume()
    }
    
}
