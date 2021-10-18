//
//  AnimationView+Extension.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/10/17.
//

import UIKit
import Lottie

extension AnimationView {
    func setAnimation(from url: URL?,
                      cacheProvider: LottieFileProviding = LottieFileProvider.shared,
                      completion: @escaping (AnimationView) -> Void) {
        guard let url = url else { return }
        
        /// 1. 해당 url로 받아온 lottie가 local file에 이미 존재할 경우 재호출 하지 않음.
        if let animation = cacheProvider.lottieAnimation(forKey: url.absoluteString) {
            self.animation = animation
            completion(self)
            return
        }
        
        /// 2. 변경된 url인 경우 로티를 새로 받아온다. (캐릭터 스타일이 바뀌었을 경우)
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self, error == nil, let jsonData = data else {
                return
            }
            do {
                let animation = try JSONDecoder().decode(Animation.self, from: jsonData)
                /// 3
                cacheProvider.setAnimationData(jsonData, forKey: url.absoluteString)
                DispatchQueue.main.async {
                    self.animation = animation
                    completion(self)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
