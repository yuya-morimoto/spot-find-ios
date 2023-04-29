//
//  AuthEnvironment.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/29.
//

public struct AuthEnvironment {
    var authClient: AuthClient

    public init(
        authClient: AuthClient
    ) {
        self.authClient = authClient
    }
}
