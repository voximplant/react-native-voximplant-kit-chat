/*
 * Copyright (c) 2011 - 2025, Voximplant, Inc. All rights reserved.
 */

package com.voximplantkitchat

import android.graphics.Color
import android.util.Log
import androidx.core.graphics.toColorInt
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.module.annotations.ReactModule
import com.voximplant.android.kit.chat.core.exceptions.KitConnectionRequiredException
import com.voximplant.android.kit.chat.core.exceptions.KitInternalException
import com.voximplant.android.kit.chat.core.exceptions.KitNetworkException
import com.voximplant.android.kit.chat.core.exceptions.KitTimeoutException
import com.voximplant.android.kit.chat.core.model.ClientData
import com.voximplant.android.kit.chat.ui.KitChatUi
import com.voximplant.android.kit.chat.ui.KitChatColorScheme
import kotlinx.coroutines.*
import kotlin.coroutines.CoroutineContext

class VoximplantKitChatModuleImpl(reactContext: ReactApplicationContext) {
    private var kitChatUI: KitChatUi? = null
    private val context: ReactApplicationContext = reactContext
    @OptIn(ExperimentalCoroutinesApi::class, DelicateCoroutinesApi::class)
    private val executor = newSingleThreadContext("KitChatModule")
    private val coroutineContext: CoroutineContext = Job() + Dispatchers.Default + executor
    private val kitModuleScope = CoroutineScope(coroutineContext)

    fun initialize(
        region: String,
        channelUuid: String,
        token: String,
        clientId: String,
        promise: Promise
    ) {
        Log.i(TAG, "VoximplantKitChatModule: initialize")
        val kitRegion = convertStringToRegion(region)
        if (kitRegion == null) {
            Log.e(TAG, "VoximplantKitChatModule: initialize: unknown region")
            promise.reject("invalidArgument", "KitRegion is invalid")
            return
        }
        kitChatUI = KitChatUi(context, kitRegion, channelUuid, token, clientId)
        promise.resolve(null);
    }

    fun openChat(promise: Promise) {
        Log.i(TAG, "VoximplantKitChatModule: openChat")
        val kitChat = kitChatUI
        if (kitChat == null) {
            Log.e(TAG, "VoximplantKitChatModule: openChat: KitChat is not initialized")
            promise.reject("notInitialized", "KitChat is not initialized")
            return
        }
        kitChat.startActivity()
        promise.resolve(null)
    }


    fun setClientData(clientData: ReadableMap, promise: Promise) {
        Log.i(TAG, "VoximplantKitChatModule: setClientData")
        kitModuleScope.launch {
            val kitChat = kitChatUI
            if (kitChat == null) {
                Log.e(TAG, "VoximplantKitChatModule: setClientData: KitChat is not initialized")
                promise.reject("notInitialized", "KitChat is not initialized")
                return@launch
            }
            val clientDataToNative = ClientData(
                clientData.getString("displayName"),
                clientData.getString("avatarUrl"),
                clientData.getString("email"),
                clientData.getString("phone"),
                clientData.getString("language")
            )
            kitChat.setClientData(clientDataToNative).let { result ->
                result.onSuccess {
                    promise.resolve(null)
                }.onFailure { exception: Throwable ->
                    when (exception) {
                        is IllegalArgumentException -> promise.reject("invalidArgument", exception.message ?: "Some argument(s) are invalid")
                        is KitConnectionRequiredException -> promise.reject("connectionRequired", exception.message ?: "The connection to Voximplant Kit has been closed while processing the operation")
                        is KitTimeoutException -> promise.reject("timeout", exception.message)
                        is KitInternalException -> promise.reject("internal", exception.message ?: "Something went wrong")
                        else -> promise.reject("unknown", exception.message ?: "Unknown error occurred")
                    }
                }
            }
        }
    }

    fun registerPushToken(token: String, isDevelopment: Boolean, promise: Promise) {
        Log.i(TAG, "VoximplantKitChatModule: registerPushToken")
        kitModuleScope.launch {
            val kitChat = kitChatUI
            if (kitChat == null) {
                Log.e(TAG, "VoximplantKitChatModule: registerPushToken: KitChat is not initialized")
                promise.reject("notInitialized", "KitChat is not initialized")
                return@launch
            }
            kitChat.registerPushToken(token).let { result ->
                result.onSuccess {
                    promise.resolve(null)
                }.onFailure { exception: Throwable ->
                    when (exception) {
                        is IllegalArgumentException -> promise.reject("invalidArgument", exception.message ?: "Some argument(s) are invalid")
                        is KitConnectionRequiredException -> promise.reject("connectionRequired", exception.message ?: "The connection to Voximplant Kit has been closed while processing the operation")
                        is KitTimeoutException -> promise.reject("timeout", exception.message)
                        is KitInternalException -> promise.reject("internal", exception.message)
                        else -> promise.reject("unknown", exception.message ?: "Unknown error occurred")
                    }
                }
            }
        }
    }

    fun unregisterPushToken(token: String, isDevelopment: Boolean, promise: Promise) {
        Log.i(TAG, "VoximplantKitChatModule: unregisterPushToken")
        kitModuleScope.launch {
            val kitChat = kitChatUI
            if (kitChat == null) {
                Log.e(TAG, "VoximplantKitChatModule: unregisterPushToken: KitChat is not initialized")
                promise.reject("notInitialized", "KitChat is not initialized")
                return@launch
            }
            kitChat.unregisterPushToken(token).let { result ->
                result.onSuccess {
                    promise.resolve(null)
                }.onFailure { exception: Throwable ->
                    when (exception) {
                        is IllegalArgumentException -> promise.reject("invalidArgument", exception.message ?: "Some argument(s) are invalid")
                        is KitConnectionRequiredException -> promise.reject("connectionRequired", exception.message ?: "The connection to Voximplant Kit has been closed while processing the operation")
                        is KitTimeoutException -> promise.reject("timeout", exception.message)
                        is KitInternalException -> promise.reject("internal", exception.message ?: "Something went wrong")
                        else -> promise.reject("unknown", exception.message ?: "Unknown error occurred")
                    }
                }
            }
        }
    }

    fun customizeColors(colorScheme: ReadableMap) {
        Log.i(TAG, "VoximplantKitChatModule: customizeColors")
        val brandColorString = colorScheme.getString("brand") ?: "0xFF662EFF"
        val brandContainerColorString = colorScheme.getString("brandContainer") ?: "0xFFF2EEFF"
        val negativeColorString = colorScheme.getString("negative") ?: "0xFFF74E57"
        val negativeContainerColorString = colorScheme.getString("negativeContainer") ?: "0xFFFFF1F1"
        val onBrandColorString = colorScheme.getString("onBrand") ?: "0xFFFFFFFF"
        val onBrandContainerColorString = colorScheme.getString("onBrandContainer") ?: "0xFF311678"
        val positiveColorString = colorScheme.getString("positive") ?: "0xFF5AD677"
        val positiveContainerColorString = colorScheme.getString("positiveContainer") ?: "0xFFEDFBF0"
        val avatarPlaceholderColorString = colorScheme.getString("avatarPlaceholder") ?: "0xFFABACC0"

        val avatarPlaceholderColor = if (avatarPlaceholderColorString == "transparent") Color.TRANSPARENT else hexToInt(avatarPlaceholderColorString)
        val brandColor = hexToInt(brandColorString)
        val brandContainerColor = hexToInt(brandContainerColorString)
        val negativeColor = hexToInt(negativeColorString)
        val negativeContainerColor = hexToInt(negativeContainerColorString)
        val onBrandColor = hexToInt(onBrandColorString)
        val onBrandContainerColor = hexToInt(onBrandContainerColorString)
        val positiveColor = hexToInt(positiveColorString)
        val positiveContainerColor = hexToInt(positiveContainerColorString)

        if (brandColor != null && brandContainerColor != null && negativeColor != null && negativeContainerColor != null &&
            onBrandColor != null && onBrandContainerColor != null && positiveColor != null && positiveContainerColor != null &&
            avatarPlaceholderColor != null) {
            val kitColorScheme = KitChatColorScheme(brand = brandColor, brandContainer = brandContainerColor,
                negative = negativeColor, negativeContainer = negativeContainerColor, onBrand = onBrandColor,
                onBrandContainer = onBrandContainerColor, positive = positiveColor, positiveContainer = positiveContainerColor,
                avatarPlaceholder = avatarPlaceholderColor)
            KitChatUi.colorScheme = kitColorScheme
        } else {
            Log.e(TAG, "VoximplantKitChatModule: customizeColors: failed to parse some color(s)")
        }
    }

    private fun convertStringToRegion(string: String): String? {
        when (string) {
            "RU" -> return "ru"
            "RU_2" -> return "ru2"
            "BR" -> return "br"
            "KZ" -> return "kz"
            "US" -> return "us"
            "EU" -> return "eu"
        }
        return null
    }

    private fun hexToInt(color: String): Int? {
        return try {
            color.toColorInt()
        } catch (exception: IllegalArgumentException) {
            null
        }
    }


    companion object {
        const val NAME = "VoximplantKitChat"
        const val TAG = "KitChatRN"
    }
}
