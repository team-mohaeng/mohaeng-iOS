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
    
    public init() { }
    
    func getCourseLibrary(completion: @escaping (NetworkResult<Any>) -> Void) {
        courseProvider.request(.getCourseLibrary) { (result) in
            
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeGetCourseLibraryStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
    func putCourseProgress(completion: @escaping (NetworkResult<Any>) -> Void, courseId: Int) {
        courseProvider.request(.putCourseProgress(id: courseId)) { (result) in
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgePutCourseProgressStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    // MARK: - judging status functions
    
    private func judgeGetCourseLibraryStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<CourseLibraryData>.self, from: data) else {
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
    
    private func judgePutCourseProgressStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<CoursesData>.self, from: data) else {
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
