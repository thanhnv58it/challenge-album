//
//  Requests.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

struct Request {
    
    static func sendRequest<T: Decodable>(input: RequestInputBase, outputType: T.Type) -> Observable<T?> {
        return sendRequestBase(url: input.getURL, outputType: outputType)
    }
        
    private static func sendRequestBase<T: Decodable>(url: String, outputType: T.Type) -> Observable<T?> {
        return Observable.create { observer in
         
            AF.request(url, parameters: nil)
                .validate()
                .responseDecodable(of: T.self) { response in
                    
                    if let error = response.error {
                        print(error)
                        observer.onError(error)
                    } else {
                        observer.onNext(response.value)
                    }
                }
            return Disposables.create()
        }
    }

}
