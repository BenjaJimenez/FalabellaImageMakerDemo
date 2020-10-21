//
//  Pharmacy.swift
//  ImageMakerDemoTests
//
//  Created by Benjamin on 20-10-20.
//

import Foundation

public struct Pharmacy: Codable {
    var id: String?
    var name: String?
    var address: String?
    var city: String?
    
    private enum CodingKeys : String, CodingKey {
        case id = "local_id"
        case name = "local_nombre"
        case address = "local_direccion"
        case city = "localidad_nombre"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        city = try container.decodeIfPresent(String.self, forKey: .city)
    }
    
    init() {
        
    }
}

public struct SearchReponse: Codable {
    var result: SearchResult?
    
    private enum CodingKeys : String, CodingKey {case result}
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decodeIfPresent(SearchResult.self, forKey: .result)
    }
}

public struct SearchResult: Codable {
    var records : [Pharmacy]?
    
    private enum CodingKeys : String, CodingKey {case records}
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        records = try container.decodeIfPresent([Pharmacy].self, forKey: .records)
    }
}
