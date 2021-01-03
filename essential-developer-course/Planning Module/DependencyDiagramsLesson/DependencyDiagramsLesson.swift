//
//  DependencyDiagramsLesson.swift
//  essential-developer-course
//
//  Created by Livia Vasconcelos on 03/01/21.
//

import UIKit

/**
 Go to Playground to run it properly.
*/
protocol FeedLoader {
    func loadFeed(completion: @escaping (([String]) -> Void))
}

class FeedViewController: UIViewController {
    var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.loadFeed { loadedItems in
            print("update UI")
        }
    }
}

class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping (([String]) -> Void)) {
        print("Remotely loaded")
        completion([])
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping (([String]) -> Void)) {
        print("Locally loaded")
        completion([])
    }
}

struct Reachability {
    static let networkAvailable = true
}

class RemoteWithLocalFallbackFeedLoader: FeedLoader {
    let remote: RemoteFeedLoader
    let local: LocalFeedLoader
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }

    func loadFeed(completion: @escaping (([String]) -> Void)) {
        let load = Reachability.networkAvailable ?
            remote.loadFeed : local.loadFeed
            
        load(completion)
    }
}

/**
 Execution
*/
let vc = FeedViewController(loader: RemoteFeedLoader())
let vc2 = FeedViewController(loader: LocalFeedLoader())
let vc3 = FeedViewController(loader: RemoteWithLocalFallbackFeedLoader(remote: RemoteFeedLoader(), local: LocalFeedLoader()))

//vc3.viewDidLoad()

