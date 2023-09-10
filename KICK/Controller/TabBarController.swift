//
//  TabBarController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let downcastStrings = self.tabBarController?.tabBar.items
        {
            downcastStrings[0].title = "Map"
            downcastStrings[1].title = "MyPage"
        }
        
        // tab bar item image 설정
        self.tabBarController?.tabBar.items![0].image = UIImage(systemName: "map")
        self.tabBarController?.tabBar.items![1].image = UIImage(systemName: "person.circle")
        
        // tab bar color 설정
        self.tabBarController?.tabBar.backgroundColor = .white
    }

}
