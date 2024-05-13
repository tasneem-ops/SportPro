//
//  RemoteDataSource.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

import Foundation
import Alamofire

protocol IRemoteDataSource<T>{
    associatedtype T
    mutating func fetchData(url: String ,complitionHandler: @escaping (T?) -> Void)
}

class RemoteDataSource<Result : Decodable>: IRemoteDataSource {
    
    typealias T = Result
    
    func fetchData(url: String, complitionHandler: @escaping (Result?) -> Void) {
        AF.request(url).responseJSON{
            response in
            if let data = response.data{
                do{
                    let json = try JSONDecoder().decode(Result.self, from: data)
                    complitionHandler(json)
                }catch let error{
                    print("Error in remote data source")
                    print(error)
                    complitionHandler(nil)
                }
            }
            else{
                print("No Data")
                complitionHandler(nil)
            }
            
        }
    }
}
