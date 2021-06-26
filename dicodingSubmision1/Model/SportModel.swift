//
//  SportModel.swift
//  dicodingSubmision1
//
//  Created by Maitri Vira on 28/05/21.
//

import Foundation

struct SportModel: Decodable{
    
    let sports: [Sport]
    
    private enum CodingKeys: String, CodingKey {
        case sports = "sports"
    }
    
}

struct Sport: Decodable{
    
    let id: String?
    let sport: String?
    let format: String?
    let sportThumb: String?
    let sportThumbGreen: String?
    let sportDescription: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "idSport"
        case sport = "strSport"
        case format = "strFormat"
        case sportThumb = "strSportThumb"
        case sportThumbGreen = "strSportThumbGreen"
        case sportDescription = "strSportDescription"
    }
    
}
