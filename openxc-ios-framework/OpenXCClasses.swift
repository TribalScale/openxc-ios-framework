//
//  OpenXCClasses.swift
//  openxc-ios-framework
//
//  Created by Tim Buick on 2016-08-10.
//  Copyright (c) 2016 Ford Motor Company Licensed under the BSD license.
//  Version 0.9.2
//

import Foundation


public struct OpenXCConstants {
  static let C5_VI_NAME_PREFIX = "OPENXC"
  static let C5_OPENXC_BLE_SERVICE_UUID = "6800D38B-423D-4BDB-BA05-C9276D8453E1"
  static let C5_OPENXC_BLE_CHARACTERISTIC_NOTIFY_UUID = "6800D38B-5262-11E5-885D-FEFF819CDCE3"
  static let C5_OPENXC_BLE_CHARACTERISTIC_WRITE_UUID = "6800D38B-5262-11E5-885D-FEFF819CDCE2"
}


public enum VehicleMessageType: NSString {
  case MeasurementResponse
  case CommandRequest
  case CommandResponse
  case DiagnosticRequest
  case DiagnosticResponse
  case CanResponse
  case CanRequest
}

public enum VehicleCommandType: NSString {
  case version
  case device_id
  case passthrough
  case af_bypass
  case payload_format
  case predefined_odb2
  case modem_configuration
  case sd_mount_status
  case rtc_configuration
}


open class VehicleBaseMessage {
  public init() {
    
  }
  public var timestamp: NSInteger = 0
  public var type: VehicleMessageType = .MeasurementResponse
  func traceOutput() -> NSString {
    return "{}"
  }
}


open class VehicleMeasurementResponse : VehicleBaseMessage {
  override init() {
    value = NSNull()
    event = NSNull()
    super.init()
    type = .MeasurementResponse
  }
  open var name : NSString = ""
  open var value : AnyObject
  open var isEvented : Bool = false
  open var event : AnyObject
  override func traceOutput() -> NSString {
    var out : String = ""
    if value is String {
      out = "{\"timestamp\":\(timestamp),\"name\":\"\(name)\",\"value\":\"\(value)\""
    } else {
      out = "{\"timestamp\":\(timestamp),\"name\":\"\(name)\",\"value\":\(value)"
    }
    if isEvented {
      if event is String {
        out.append(",\"event\":\"\(event)\"")
      } else {
        out.append(",\"event\":\(event)")
      }
    }
    out.append("}")
    return out as NSString
  }
  open func valueIsBool() -> Bool {
    if value is NSNumber {
      let nv = value as! NSNumber
      if nv.isEqual(to: NSNumber(value: true)) {
        return true
      } else if nv.isEqual(to: NSNumber(value: false)) {
        return true
      }
    }
    return false
  }
}


open class VehicleCommandRequest : VehicleBaseMessage {
  public override init() {
    super.init()
    type = .CommandResponse
  }
  open var command : VehicleCommandType = .version
  open var bus : NSInteger = 0
  open var enabled : Bool = false
  open var bypass : Bool = false
  open var format : NSString = ""
  open var server_host : NSString = ""
  open var server_port : NSInteger = 0
  open var unix_time : NSInteger = 0
}

open class VehicleCommandResponse : VehicleBaseMessage {
  public override init() {
    super.init()
    type = .CommandResponse
  }
  open var command_response : NSString = ""
  open var message : NSString = ""
  open var status : Bool = false
  override func traceOutput() -> NSString {
    return "{\"timestamp\":\(timestamp),\"command_response\":\"\(command_response)\",\"message\":\"\(message)\",\"status\":\(status)}" as NSString
  }
}



open class VehicleDiagnosticRequest : VehicleBaseMessage {
  public override init() {
    super.init()
    type = .DiagnosticRequest
  }
  open var bus : NSInteger = 0
  open var message_id : NSInteger = 0
  open var mode : NSInteger = 0
  open var pid : NSInteger?
  open var payload : NSString = ""
  open var name : NSString = ""
  open var multiple_responses : Bool = false
  open var frequency : NSInteger = 0
  open var decoded_type : NSString = ""
}



open class VehicleDiagnosticResponse : VehicleBaseMessage {
  public override init() {
    super.init()
    type = .DiagnosticResponse
  }
  open var bus : NSInteger = 0
  open var message_id : NSInteger = 0
  open var mode : NSInteger = 0
  open var pid : NSInteger?
  open var success : Bool = false
  open var negative_response_code : NSInteger = 0
  open var payload : NSString = ""
  open var value : NSInteger?
}


open class VehicleCanResponse : VehicleBaseMessage {
  public override init() {
    super.init()
    type = .CanResponse
  }
  open var bus : NSInteger = 0
  open var id : NSInteger = 0
  open var data : NSString = ""
  open var format : NSString = "standard"
}

open class VehicleCanRequest : VehicleBaseMessage {
  public override init() {
    super.init()
    type = .CanRequest
  }
  open var bus : NSInteger = 0
  open var id : NSInteger = 0
  open var data : NSString = ""
  open var format : NSString = ""
}


