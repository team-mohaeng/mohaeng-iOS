//
//  CourseAPI.swift
//  Journey
//
//  Created by 초이 on 2021/07/11.
//

import Foundation
import Moya

public class CourseAPI {
    
    static let shared = CourseAPI()
    var courseProvider = MoyaProvider<CourseService>()
    
    enum ResponseData {
        case course
        case courses
    }
    
    public init() { }
    
    func getCourseLibrary(completion: @escaping (NetworkResult<Any>) -> Void) {
        courseProvider.request(.getCourseLibrary) { (result) in
            
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .course)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
    func getMedal(completion: @escaping (NetworkResult<Any>) -> Void) {
        courseProvider.request(.getMedal) { (result) in
            
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .courses)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            return isValidData(data: data, responseData: responseData)
        case 400..<500:
            return .pathErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func isValidData(data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        switch responseData {
        case .course:
            guard let decodedData = try? decoder.decode(CourseResponseData.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData.data)
        case .courses:
            guard let decodedData = try? decoder.decode(MedalResponseData.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData.data)
        }
    }
}
