//
//  UserManager.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    private let userDefaults = UserDefaults.standard
    private let userKey = "userKey"
    
    // 유저의 정보를 저장하는 로직 (Create & Update)
    func saveUser(user: User) {
        var users = getAllUsers() ?? []
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index] = user // Update existing user
        } else {
            users.append(user) // Create new user
        }
        saveAllUsers(users: users)
    }
    
    // 유저의 정보를 가져오는 로직 (Read)
    func getUser(id: String) -> User? {
        
        return getAllUsers()?.first { $0.id == id }
    }
    
    // 유저의 정보를 삭제하는 로직 (Delete)
    func deleteUser(id: String) {
        var users = getAllUsers() ?? []
        users.removeAll { $0.id == id }
        saveAllUsers(users: users)
    }
    
    // 모든 유저의 정보를 가져오는 로직
    private func getAllUsers() -> [User]? {
        if let data = userDefaults.data(forKey: userKey), let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        }
        return nil
    }
    
    // 모든 유저의 정보를 저장하는 로직
    private func saveAllUsers(users: [User]) {
        if let encodedData = try? JSONEncoder().encode(users) {
            userDefaults.set(encodedData, forKey: userKey)
        }
    }
}
