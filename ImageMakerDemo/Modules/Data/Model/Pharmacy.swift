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
    
    //Detail data
    var date: String?
    var municipality: String?
    var openTime: String?
    var closeTime: String?
    var phone: String?
    var latitude: String?
    var longitude: String?
    var workingDay: String?
    var regionId: String?
    var municipalityId: String?
    var localityId: String?
    
    //Search extras
    var count: String?
    var searchId: Int?
    var rank: Double?
    
    
    private enum CodingKeys : String, CodingKey {
        case id = "local_id"
        case name = "local_nombre"
        case address = "local_direccion"
        case city = "localidad_nombre"
        case date = "fecha"
        case municipality = "comuna_nombre"
        case openTime = "funcionamiento_hora_apertura"
        case closeTime = "funcionamiento_hora_cierre"
        case phone = "local_telefono"
        case latitude = "local_lat"
        case longitude = "local_lng"
        case workingDay = "funcionamiento_dia"
        case regionId = "fk_region"
        case municipalityId = "fk_comuna"
        case localityId = "fk_localidad"
        case count = "_full_count"
        case searchId = "_id"
        case rank = "rank"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        date = try container.decodeIfPresent(String.self, forKey: .date)
        municipality = try container.decodeIfPresent(String.self, forKey: .municipality)
        openTime = try container.decodeIfPresent(String.self, forKey: .openTime)
        closeTime = try container.decodeIfPresent(String.self, forKey: .closeTime)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
        workingDay = try container.decodeIfPresent(String.self, forKey: .workingDay)
        regionId = try container.decodeIfPresent(String.self, forKey: .regionId)
        municipalityId = try container.decodeIfPresent(String.self, forKey: .municipalityId)
        localityId = try container.decodeIfPresent(String.self, forKey: .localityId)
        count = try container.decodeIfPresent(String.self, forKey: .count)
        searchId = try container.decodeIfPresent(Int.self, forKey: .searchId)
        rank = try container.decodeIfPresent(Double.self, forKey: .rank)
    }
    
    init() {}
}

extension Pharmacy: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.address == rhs.address
            && lhs.city == rhs.city
        
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
