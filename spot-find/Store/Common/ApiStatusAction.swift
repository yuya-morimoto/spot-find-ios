//
//  ApiStatusAction.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/23.
//

enum ApiStatusAction<T>: Equatable where T: Equatable {
    case waiting
    case pending
    case success(T?)
    case failed(ErrorState)
}
