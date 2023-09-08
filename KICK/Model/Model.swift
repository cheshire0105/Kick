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
    
    var userImage: String?
    var userName: String?
    var userContact: String?
    var userCredit: String?
    var userLicense: String?
    
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
    var uniqueID: String // UUID를 String으로 변경
    var isRented: Bool
    var batteryLevel: Int // 배터리 수준을 퍼센트로 표시 (0~100)

    // 초기화 메소드 추가
    init(uniqueID: String, isRented: Bool, batteryLevel: Int) {
        self.uniqueID = uniqueID
        self.isRented = isRented
        self.batteryLevel = batteryLevel
    }
}
