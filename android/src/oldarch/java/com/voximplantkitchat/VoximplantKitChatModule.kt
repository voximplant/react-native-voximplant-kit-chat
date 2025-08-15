/*
 * Copyright (c) 2011 - 2025, Voximplant, Inc. All rights reserved.
 */

package com.voximplantkitchat

import android.util.Log
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.module.annotations.ReactModule

@ReactModule(name = VoximplantKitChatModule.NAME)
class VoximplantKitChatModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    private var moduleImpl: VoximplantKitChatModuleImpl = VoximplantKitChatModuleImpl(reactContext)
    override fun getName(): String {
        return NAME
    }

    @ReactMethod
    fun initialize(
        region: String,
        channelUuid: String,
        token: String,
        clientId: String,
        promise: Promise
    ) {
        moduleImpl.initialize(region, channelUuid, token, clientId, promise)
    }

    @ReactMethod
    fun openChat(promise: Promise) {
        moduleImpl.openChat(promise)
    }

    @ReactMethod
    fun setClientData(clientData: ReadableMap, promise: Promise) {
        moduleImpl.setClientData(clientData, promise)
    }

    @ReactMethod
    fun registerPushToken(token: String, isDevelopment: Boolean, promise: Promise) {
        moduleImpl.registerPushToken(token, isDevelopment, promise)
    }

    @ReactMethod
    fun unregisterPushToken(token: String, isDevelopment: Boolean, promise: Promise) {
        moduleImpl.unregisterPushToken(token, isDevelopment, promise)
    }

    @ReactMethod
    fun customizeColors(colorScheme: ReadableMap) {
        moduleImpl.customizeColors(colorScheme)
    }

    @ReactMethod
    fun customizeStrings(customizableStrings: ReadableMap) {}
    @ReactMethod
    fun customizeIcons(customizableIcons: ReadableMap) {}

    companion object {
        const val NAME = "VoximplantKitChat"
    }
}
