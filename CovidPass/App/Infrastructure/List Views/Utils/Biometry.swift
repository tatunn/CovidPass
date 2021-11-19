//
//  Biometry.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 06.03.21.
//

import LocalAuthentication

final public class Biometry {
    public typealias SuccessComplition = () -> Void
    public typealias ErrorComplition = (_ error: Error?) -> Void

    public static let shared = Biometry()
    private var context = LAContext()

    private init() { }

    @discardableResult
    public func release() -> Biometry {
        context = LAContext()
        return self
    }

    public var deviceSupportBiometry: Bool {
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {return true}

        guard let laError = error as? LAError else { return false }

        if #available(iOS 11.0, *) {
            return laError.code != .biometryNotAvailable
        } else {
            return laError.code != .touchIDNotAvailable
        }
    }

    public var isAvailable: Bool {
        var error: NSError?

        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }

    public var biometryType: Biometry.BiometryType {
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {return .none}

        if #available(iOS 11.0, *) {
            switch context.biometryType {
            case .faceID: return .faceId
            case .touchID: return .touchId
            case .none: return .none
            @unknown default:
                return .none
            }
        }

        return .touchId
    }

    public func authenticate(successComplition: @escaping SuccessComplition,
                             errorComplition: @escaping ErrorComplition) {
        var error: NSError?
        let reasonString = biometryType.reasonString ?? "please provide text"

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            errorComplition(error)
            return
        }

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: reasonString, reply: { (success, evalPolicyError) in
            DispatchQueue.main.async {
                if success {
                    successComplition()
                } else {
                    errorComplition(evalPolicyError)
                }
            }
        })
    }

    public func invalidate() {
        context.invalidate()
    }
}

extension Biometry {
    public enum BiometryType {
        case none, touchId, faceId

        @available(iOS 11.0, *)
        init(biometryType: LABiometryType) {
            switch biometryType {
            case .none: self = .none
            case .touchID: self = .touchId
            case .faceID: self = .faceId
            @unknown default: self = .none
            }
        }
    }
}

extension Biometry.BiometryType {
    var reasonString: String? {
        switch self {
        case .faceId:
            return R.string.localizable.appBiometryFaceId.localized
        case .touchId:
            return R.string.localizable.appBiometryTouchId.localized
        case .none:
            return R.string.localizable.appBiometryAll.localized
        }
    }
}
