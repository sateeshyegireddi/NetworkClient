//
//  InternetConnection.swift
//  NetworkClient
//
//  Created by Sateesh Yemireddi on 5/9/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

public class InternetConnection {
    public var isConnected = false
    public static let shared = InternetConnection()
    private var reachability: Reachability!
    public static let failedShared = InternetConnection("invalidHost")

    private init(_ hostName: String = "google.com") {
        reachability = try! Reachability(hostname: hostName)
    }
    
    public func configure() {
        startHost()
    }
    
    private func startHost() {
        stopNotifier()
        checkConnection()
        startNotifier()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.startHost()
        }
    }
    
    private func checkConnection() {
        reachability.whenReachable = { [weak self] reachability in
            guard let `self` = self else { return }
            if reachability.connection == .wifi || reachability.connection == .cellular {
                self.isConnected = true
            }
        }
        reachability.whenUnreachable = { [weak self] _ in
            guard let `self` = self else { return }
            self.isConnected = false
        }
    }
    
    private func startNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier: \(error.localizedDescription)")
        }
    }
    
    private func stopNotifier() {
        reachability.stopNotifier()
    }
}
