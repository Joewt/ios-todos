//
//  AppDelegate.swift
//  Todos
//
//  Created by 乔酱 on 2021/7/25.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("启动app")
        do {
            let localRealm = try Realm()
            
            // Add some tasks
            let task = LocalOnlyQsTask(name: "Do laundry")
            try localRealm.write {
                localRealm.add(task)
            }
            
            print(Realm.Configuration.defaultConfiguration.fileURL!)

        }catch{
            print(error)
        }
        
        
       
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("激活")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("完全退出")
    }


}

