//
//  ChangePWPost.swift
//  Sukbakji
//
//  Created by jaegu park on 8/11/24.
//

import Foundation
import Alamofire

class APIChangePWPost {
    static let instance = APIChangePWPost()
    
    func SendingPostAlarm(parameters: ChangePWModel, handler: @escaping (_ result: ChangePWResult)->(Void)) {
        let url = APIConstants.userURL + "/password"
        let headers:HTTPHeaders = [
            "content-type": "application/json",
            "Authorization": "Bearer"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                print(String(decoding: data!, as: UTF8.self))
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(ChangePWResult.self, from: data!)
                    handler(jsonresult)
                    print(jsonresult)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func judgeStatus<T:Codable> (by statusCode: Int, _ data: Data, _ type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(type.self, from: data)
        else { return .pathErr }
        
        switch statusCode {
        case 200 ..< 300: return .success(decodedData as Any)
        case 400 ..< 500: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}

