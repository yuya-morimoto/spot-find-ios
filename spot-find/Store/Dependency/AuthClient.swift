//
//  AuthClient.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/29.
//

import Dependencies
import FirebaseAuth

public struct AuthClient {
    public var createUser: (String, String) async throws -> AuthDataResult
    public var sendEmailVerification: () async throws -> Bool
    public var signIn: (String, String) async throws -> AuthDataResult
    public var signOut: () async throws -> Bool
    public var currentUser: () -> User?

    public init(
        createUser: @escaping (String, String) async throws -> AuthDataResult,
        sendEmailVerification: @escaping () async throws -> Bool,
        signIn: @escaping (String, String) async throws -> AuthDataResult,
        signOut: @escaping () async throws -> Bool,
        currentUser: @escaping () -> User?
    ) {
        self.createUser = createUser
        self.sendEmailVerification = sendEmailVerification
        self.signIn = signIn
        self.signOut = signOut
        self.currentUser = currentUser
    }
}

public extension AuthClient {
    static let live: Self = AuthClient(
        createUser: { email, password in
            try await Auth.auth().createUser(withEmail: email, password: password)
        },
        sendEmailVerification: {
            try await Auth.auth().currentUser?.sendEmailVerification()
            return true
        },
        signIn: { email, password in
            try await Auth.auth().signIn(withEmail: email, password: password)
        },
        signOut: {
            try Auth.auth().signOut()
            return true
        },
        currentUser: {
            Auth.auth().currentUser
        }
    )
}

public extension AuthClient {
    static var failing = Self(
        createUser: XCTUnimplemented("\(Self.self).createUser"),
        sendEmailVerification: XCTUnimplemented("\(Self.self).sendEmailVerification"),
        signIn: XCTUnimplemented("\(Self.self).signIn"),
        signOut: XCTUnimplemented("\(Self.self).signOut"),
        currentUser: XCTUnimplemented("\(Self.self).currentUsesr")
    )
}

private enum AuthClientKey: DependencyKey {
    public static let liveValue = AuthClient.live
    public static let testValue = AuthClient.failing
}

public extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClientKey.self] }
        set { self[AuthClientKey.self] = newValue }
    }
}
