//
//  NetworkMonitor.swift
//  Zeus
//
//  Created by Priyanshu Verma on 07/01/23.
//
import Network

protocol NetworkStatusHandler {
    func passNetworkStatus(status: NWPath.Status)
}

final class NetworkMonitor {
    var newtorkStatusHandlerDelegate: NetworkStatusHandler?
    static let shared = NetworkMonitor()

    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
            
            if path.status == .satisfied {
                print("We're connected!")
            } else {
                print("No connection.")
            }
            print(path.isExpensive)
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}

private typealias CheckNetwork = NetworkMonitor
extension CheckNetwork {
    func checkForNetworkConnectivity() -> Bool {
        if self.status == .satisfied {
            return true
        } else {
            return false
        }
    }
}
