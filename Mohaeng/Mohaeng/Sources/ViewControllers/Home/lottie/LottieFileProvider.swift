//
//  LottieFileProvider.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/10/17.
//

import UIKit
import Lottie

protocol LottieFileProviding: AnyObject {
    func lottieAnimation(forKey: String) -> Animation?
    func setAnimationData(_ data: Data, forKey: String)
}

final class LottieFileProvider: LottieFileProviding {
    static var shared = LottieFileProvider()
    
    private let urlBuilder: LottieFileURLBuilding
    
    init(urlBuilder: LottieFileURLBuilding = LottieFileURLBuilder()) {
        self.urlBuilder = urlBuilder
    }
    
    /// 1
    func lottieAnimation(forKey: String) -> Animation? {
        do {
            let path = urlBuilder.buildPath(for: forKey)
            let data = try Data(contentsOf: path)
            return try JSONDecoder().decode(Animation.self, from: data)
        } catch {
            return nil
        }
    }
    
    /// 2
    func setAnimationData(_ data: Data, forKey: String) {
        do {
            let path = urlBuilder.buildPath(for: forKey)
            let directory = urlBuilder.directory
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// 3
    func clearCache() {
        do {
            let url = urlBuilder.directory
            try FileManager.default.removeItem(at: url)
        } catch {
            print(error.localizedDescription)
        }
    }
}

////// URL Builder
protocol LottieFileURLBuilding: AnyObject {
    var directory: URL { get }
    func buildPath(for key: String) -> URL
}

final class LottieFileURLBuilder: LottieFileURLBuilding {
    private enum Constant {
        static let lottieDirectory = "lottie-animations"
    }
    
    private var filesDirectory: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        } catch {
            print(error.localizedDescription)
        }
        
        return URL(fileURLWithPath: "files")
    }
    
    lazy var directory: URL = {
        var url = filesDirectory
        url.appendPathComponent(Constant.lottieDirectory)
        return url
    }()
    
    /// 4
    func buildPath(for key: String) -> URL {
        let url = URL(string: key)
        let fileExtension = url?.pathExtension ?? "json"
        let fileName = url?.deletingPathExtension().lastPathComponent ?? ""
        return directory.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
    }
}
