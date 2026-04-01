'use strict'

const { NativeModules, TurboModuleRegistry } = require('react-native')

import { Permissions } from './Constants/Permissions'
import { Units } from './Constants/Units'

const NativeAppleHealthKit =
  TurboModuleRegistry?.get?.('AppleHealthKit') || NativeModules.AppleHealthKit

const constants = {
  Permissions,
  Units,
}

const HealthKit = new Proxy(
  {},
  {
    get(_, prop) {
      if (prop === 'Constants') {
        return constants
      }
      return NativeAppleHealthKit?.[prop]
    },
    has(_, prop) {
      return prop === 'Constants' || prop in (NativeAppleHealthKit || {})
    },
    ownKeys() {
      const nativeKeys = NativeAppleHealthKit ? Reflect.ownKeys(NativeAppleHealthKit) : []
      return [...new Set([...nativeKeys, 'Constants'])]
    },
    getOwnPropertyDescriptor(_, prop) {
      if (prop === 'Constants') {
        return {
          configurable: true,
          enumerable: true,
          value: constants,
          writable: false,
        }
      }

      const value = NativeAppleHealthKit?.[prop]
      if (value === undefined) {
        return undefined
      }

      return {
        configurable: true,
        enumerable: true,
        value,
        writable: false,
      }
    },
  }
)

export default HealthKit
module.exports = HealthKit;
