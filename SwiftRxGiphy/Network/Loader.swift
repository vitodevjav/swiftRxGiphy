//
//  Loader.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 4/25/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import RxSwift
import RxCocoa

class Loader {
    static let sharedInstance = Loader()

    private let session = URLSession(configuration: .ephemeral)
    private init() {

    }

    func loadData(with url: URL) -> Observable<Data> {
        return Observable<Data>.create { observer in
            let task = self.session.dataTask(with: url) { data, response, error in
                guard error == nil,
                    let responseData = data
                    else {
                        observer.onError(error!)
                        return
                }

                observer.onNext(responseData)
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
