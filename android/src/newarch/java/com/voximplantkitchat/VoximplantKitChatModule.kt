/*
 * Copyright (c) 2011 - 2025, Voximplant, Inc. All rights reserved.
 */

package com.voximplantkitchat

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.module.annotations.ReactModule

@ReactModule(name = VoximplantKitChatModule.NAME)
class VoximplantKitChatModule(reactContext: ReactApplicationContext) : NativeVoximplantKitChatSpec(reactContext) {
    private var moduleImpl: VoximplantKitChatModuleImpl = VoximplantKitChatModuleImpl(reactContext)

    override fun getName(): String {
        return NAME
    }

    override fun initialize(
        region: String,
        channelUuid: String,
        token: String,
        clientId: String,
        promise: Promise
    ) {
        moduleImpl.initialize(region, channelUuid, token, clientId, promise)
    }

    override fun openChat(promise: Promise) {
        moduleImpl.openChat(promise)
    }

    override fun setClientData(clientData: ReadableMap, promise: Promise) {
        moduleImpl.setClientData(clientData, promise)
    }

    override fun registerPushToken(token: String, isDevelopment: Boolean, promise: Promise) {
        moduleImpl.registerPushToken(token, isDevelopment, promise)
    }

    override fun unregisterPushToken(token: String, isDevelopment: Boolean, promise: Promise) {
        moduleImpl.unregisterPushToken(token, isDevelopment, promise)
    }

    override fun customizeColors(colorScheme: ReadableMap) {
        moduleImpl.customizeColors(colorScheme)
    }

    override fun customizeStrings(customizableStrings: ReadableMap) {}
    override fun customizeIcons(customizableIcons: ReadableMap) {}

    companion object {
        const val NAME = "VoximplantKitChat"
    }
}
