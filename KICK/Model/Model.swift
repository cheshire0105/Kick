//
//  Model.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import Foundation

// 데이터를 저장하는 데이터 모델
// 위치를 저장하는 모델은 아직 넣지 않았음

// 유저의 정보를 담은 구조체
struct User: Codable {
    var id: String?
    var password: String?
    var rentalDate: Date?
    var returnDate: Date?
    var usageFee: Int?
    var membershipLevel: MembershipLevel?
    
    // 유저가 얼마나 사용 했는지 나타내는 레벨 구조체
    enum MembershipLevel: Int, Codable {
        case high = 3
        case middle = 2
        case low = 1
        case newbie = 0
    }
    
    static func getLevel(hours: Int) -> MembershipLevel {
        switch hours {
        case 50...:
            return .high
        case 20..<50:
            return .middle
        default:
            return .low
        }
    }
}

// 킥보드 정보를 담은 구조체
struct Kickboard: Codable {
    var uniqueID: UUID
    var isRented: Bool
}

// 유저디폴트에 위의 정보들이 저장 되는 구조체
struct UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    private let userKey = "userKey"
    private let kickboardKey = "kickboardKey"
    
    // 유저의 정보를 저장 하는 로직
    func saveUser(user: User) {
        if let encodedData = try? JSONEncoder().encode(user) {
            userDefaults.set(encodedData, forKey: userKey)
        }
    }
    
    // 유저의 정보를 가져오는 로직
    func getUser() -> User? {
        if let data = userDefaults.data(forKey: userKey), let user = try? JSONDecoder().decode(User.self, from: data) {
            return user
        }
        return nil
    }
    
    // 킥보드의 정보를 저장 하는 로직
    func saveKickboard(kickboard: Kickboard) {
        if let encodedData = try? JSONEncoder().encode(kickboard) {
            userDefaults.set(encodedData, forKey: kickboardKey)
        }
    }
    
    // 키보드 정보를 가져오는 로직
    func getKickboard() -> Kickboard? {
        if let data = userDefaults.data(forKey: kickboardKey), let kickboard = try? JSONDecoder().decode(Kickboard.self, from: data) {
            return kickboard
        }
        return nil
    }
}
