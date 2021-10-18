//
//  MypageAPI.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/17.
//

import Foundation
import Moya

public class MyPageAPI {
    
    static let shared = MyPageAPI()
    var myPageProvider = MoyaProvider<MyPageService>()
    
    public init() { }
    
    func getMyPage(completion: @escaping (NetworkResult<Any>) -> Void) {
        myPageProvider.request(.getMyPage) { (result) in
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(GenericResponse<MyPage>.self, from: data)
            else {
                    return .pathErr
            }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
