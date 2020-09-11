// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: submission_payload.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

/// Explicit usage of proto2 because version 3 does not support custom default values
/// https://stackoverflow.com/questions/33222551/why-are-there-no-custom-default-values-in-proto3

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct SAP_SubmissionPayload {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var keys: [SAP_TemporaryExposureKey] = []

  var padding: Data {
    get {return _padding ?? SwiftProtobuf.Internal.emptyData}
    set {_padding = newValue}
  }
  /// Returns true if `padding` has been explicitly set.
  var hasPadding: Bool {return self._padding != nil}
  /// Clears the value of `padding`. Subsequent reads from it will return its default value.
  mutating func clearPadding() {self._padding = nil}

  var visitedCountries: [String] = []

  var origin: String {
    get {return _origin ?? String()}
    set {_origin = newValue}
  }
  /// Returns true if `origin` has been explicitly set.
  var hasOrigin: Bool {return self._origin != nil}
  /// Clears the value of `origin`. Subsequent reads from it will return its default value.
  mutating func clearOrigin() {self._origin = nil}

  var reportType: SAP_ReportType {
    get {return _reportType ?? .confirmedClinicalDiagnosis}
    set {_reportType = newValue}
  }
  /// Returns true if `reportType` has been explicitly set.
  var hasReportType: Bool {return self._reportType != nil}
  /// Clears the value of `reportType`. Subsequent reads from it will return its default value.
  mutating func clearReportType() {self._reportType = nil}

  var consentToFederation: Bool {
    get {return _consentToFederation ?? false}
    set {_consentToFederation = newValue}
  }
  /// Returns true if `consentToFederation` has been explicitly set.
  var hasConsentToFederation: Bool {return self._consentToFederation != nil}
  /// Clears the value of `consentToFederation`. Subsequent reads from it will return its default value.
  mutating func clearConsentToFederation() {self._consentToFederation = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _padding: Data? = nil
  fileprivate var _origin: String? = nil
  fileprivate var _reportType: SAP_ReportType? = nil
  fileprivate var _consentToFederation: Bool? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "SAP"

extension SAP_SubmissionPayload: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".SubmissionPayload"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "keys"),
    2: .same(proto: "padding"),
    3: .same(proto: "visitedCountries"),
    4: .same(proto: "origin"),
    5: .same(proto: "reportType"),
    6: .same(proto: "consentToFederation"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.keys)
      case 2: try decoder.decodeSingularBytesField(value: &self._padding)
      case 3: try decoder.decodeRepeatedStringField(value: &self.visitedCountries)
      case 4: try decoder.decodeSingularStringField(value: &self._origin)
      case 5: try decoder.decodeSingularEnumField(value: &self._reportType)
      case 6: try decoder.decodeSingularBoolField(value: &self._consentToFederation)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.keys.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.keys, fieldNumber: 1)
    }
    if let v = self._padding {
      try visitor.visitSingularBytesField(value: v, fieldNumber: 2)
    }
    if !self.visitedCountries.isEmpty {
      try visitor.visitRepeatedStringField(value: self.visitedCountries, fieldNumber: 3)
    }
    if let v = self._origin {
      try visitor.visitSingularStringField(value: v, fieldNumber: 4)
    }
    if let v = self._reportType {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 5)
    }
    if let v = self._consentToFederation {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: SAP_SubmissionPayload, rhs: SAP_SubmissionPayload) -> Bool {
    if lhs.keys != rhs.keys {return false}
    if lhs._padding != rhs._padding {return false}
    if lhs.visitedCountries != rhs.visitedCountries {return false}
    if lhs._origin != rhs._origin {return false}
    if lhs._reportType != rhs._reportType {return false}
    if lhs._consentToFederation != rhs._consentToFederation {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
