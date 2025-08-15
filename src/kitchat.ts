/*
 * Copyright (c) 2011 - 2025, Voximplant, Inc. All rights reserved.
 */

import type { KitCustomization } from './customization.ts';
import VoximplantKitChatModule from './VoximplantKitChatModule';
import { Platform } from 'react-native';

/**
 * Enum that defines account regions for a mobile channel.
 */
export enum KitRegion {
  BR = 'BR',
  EU = 'EU',
  KZ = 'KZ',
  RU = 'RU',
  RU_2 = 'RU_2',
  US = 'US',
}

/**
 * Interface that defines customer information that can be displayed in the agent’s workspace.
 */
export interface KitClientData {
  /**
   * Customer display name.
   */
  displayName?: string | null;
  /**
   * Customer avatar URL string.
   */
  avatarUrl?: string | null;
  /**
   * Customer email.
   */
  email?: string | null;
  /**
   * Customer phone number.
   */
  phone?: string | null;
  /**
   * Customer language.
   */
  language?: string | null;
}

/**
 * Base error for all SDK errors.
 */
export class KitError extends Error {
  constructor(message: string) {
    super(message);
  }
}

/**
 *
 */
export class KitNotInitializedError extends KitError {
  constructor(message: string) {
    super(message);
  }
}

/**
 *
 */
export class KitInvalidArgumentError extends KitError {
  constructor(message: string) {
    super(message);
  }
}

/**
 * Thrown to indicate that a method has been called when the connection to Voximplant Kit has not been established.
 */
export class KitConnectionRequiredError extends KitError {
  constructor(message: string) {
    super(message);
  }
}

/**
 * Thrown to indicate that an operation has failed due to network issues on the device.
 */
export class KitNetworkError extends KitError {
  constructor(message: string) {
    super(message);
  }
}

/**
 * Thrown to indicate that an operation has not been completed in time.
 */
export class KitTimeoutError extends KitError {
  constructor(message: string) {
    super(message);
  }
}

/**
 * Thrown to indicate that an internal error has occurred.
 */
export class KitInternalError extends KitError {
  constructor(message: string) {
    super(message);
  }
}

/**
 * Thrown to indicate that an unknown error has occurred.
 */
export class KitUnknownError extends KitError {
  constructor(message: string) {
    super(message);
  }
}

/**
 * Class that provides the functionality to configure, customize, and open a chat view controller.
 */
export class KitChat {
  constructor() {}

  /**
   * Initializes the instance with the specified parameters.
   *
   * Throws:
   * - [KitInvalidArgumentError] if the account region is unknown.
   * - [KitInternalError] if the native module cannot be initialized.
   * @param region Account region for a mobile channel.
   * @param channelUuid Mobile channel UUID.
   * @param token Mobile channel token.
   * @param clientId Customer unique identifier. The maximum number of symbols is 100. The following symbols and characters are allowed: [a-z, A-Z, 0-9, $, -, _, ., +, !, *, ’, (, ), ,, :, @, =].
   */
  public initialize(
    region: KitRegion,
    channelUuid: string,
    token: string,
    clientId: string
  ): Promise<void> {
    return VoximplantKitChatModule.initialize(
      region.toString(),
      channelUuid,
      token,
      clientId
    ).catch((error: any) => {
      console.log('KitChatRN: initialize error', error);
      this.parseAndThrowKitError(error);
    });
  }

  /**
   * Opens the chat screen.
   *
   * Throws [KitNotInitializedError] if:
   * - the [KitChat.initialize] API has not been called or has failed.
   * - rootViewController has not been set to the iOS native module in the AppDelegate.
   */
  public openChat(): Promise<void> {
    return VoximplantKitChatModule.openChat().catch((error: any) => {
      console.log('KitChatRN: openChat error', error);
      this.parseAndThrowKitError(error);
    });
  }

  /**
   * Sets customer information to the agent's workspace.
   *
   * Throws:
   * - [KitNotInitializedError] if the [KitChat.initialize] API has not been called or has failed.
   * - [KitInvalidArgumentError] if all [KitClientData] properties are null or empty strings.
   * - [KitConnectionRequiredError] on Android if the connection to Voximplant Kit has been closed while processing the operation.
   * - [KitNetworkError] if the connection to Voximplant Kit has been closed while processing customer information.
   * - [KitTimeoutError] if SDK has not received a timely confirmation that customer information is set.
   * - [KitInternalError] if something went wrong.
   * - [KitUnknownError] if an unknown error occurred.
   * @param clientData Customer information.
   */
  public setClientData(clientData: KitClientData): Promise<void> {
    return VoximplantKitChatModule.setClientData(clientData).catch(
      (error: any) => {
        console.log('KitChatRN: setClientData error', error);
        this.parseAndThrowKitError(error);
      }
    );
  }

  /**
   * Registers a token to receive push notifications for new inbound messages on the current device.
   *
   * To receive push notifications, it is also required to upload a Firebase (android) and APNs (iOS) certificate.
   *
   * For iOS platform.
   *
   * If the token is generated for an application built in debug mode (using Xcode), set the isDevelopment parameter to true.
   *
   * If the token is generated for an application published to App Store or TestFlight, set the isDevelopment parameter to false.
   *
   * Throws:
   * - [KitNotInitializedError] if the [KitChat.initialize] API has not been called or has failed.
   * - [KitInvalidArgumentError] if the token is an empty string.
   * - [KitConnectionRequiredError] on Android if the connection to Voximplant Kit has been closed while processing the operation.
   * - [KitNetworkError] if the connection to Voximplant Kit has been closed while processing customer information.
   * - [KitTimeoutError] if the operation has not completed in time.
   * - [KitInternalError] if something went wrong.
   * - [KitUnknownError] if an unknown error occurred.
   * @param token Firebase/APNs token to register.
   * @param isDevelopment Boolean that indicates if the push token is generated in the iOS development environment.
   */
  public registerPushToken(
    token: string,
    isDevelopment: boolean = false
  ): Promise<void> {
    return VoximplantKitChatModule.registerPushToken(
      token,
      isDevelopment
    ).catch((error: any) => {
      console.log('KitChatRN: registerPushToken error', error);
      this.parseAndThrowKitError(error);
    });
  }

  /**
   * Unregisters a token to stop receiving push notifications on the current device.
   *
   * For iOS platform.
   *
   * If the token is generated for an application built in debug mode (using Xcode), set the isDevelopment parameter to true.
   *
   * If the token is generated for an application published to App Store or TestFlight, set the isDevelopment parameter to false.
   *
   * Throws:
   * - [KitNotInitializedError] if the [KitChat.initialize] API has not been called or has failed.
   * - [KitInvalidArgumentError] if the token is an empty string.
   * - [KitConnectionRequiredError] on Android if the connection to Voximplant Kit has been closed while processing the operation.
   * - [KitNetworkError] if the connection to Voximplant Kit has been closed while processing customer information.
   * - [KitTimeoutError] if the operation has not completed in time.
   * - [KitInternalError] if something went wrong.
   * - [KitUnknownError] if an unknown error occurred.
   * @param token Firebase/APNs token to register.
   * @param isDevelopment Boolean that indicates if the push token is generated in the iOS development environment.
   */
  public unregisterPushToken(
    token: string,
    isDevelopment: boolean = false
  ): Promise<void> {
    return VoximplantKitChatModule.unregisterPushToken(
      token,
      isDevelopment
    ).catch((error: any) => {
      console.log('KitChatRN: unregisterPushToken error', error);
      this.parseAndThrowKitError(error);
    });
  }

  /**
   * Customizes the chat screen with colors, icons, and strings.
   * @param customization User interface customization parameters.
   */
  public applyCustomization(customization: KitCustomization): void {
    if (customization.colorScheme) {
      VoximplantKitChatModule.customizeColors(customization.colorScheme);
    }
    if (Platform.OS === 'ios' && customization.customizableStringsIos) {
      VoximplantKitChatModule.customizeStrings(
        customization.customizableStringsIos
      );
    }
    if (Platform.OS === 'ios' && customization.customizableIconsIos) {
      VoximplantKitChatModule.customizeIcons(
        customization.customizableIconsIos
      );
    }
  }

  private parseAndThrowKitError(error: any) {
    if (error.hasOwnProperty('code') && error.hasOwnProperty('message')) {
      let code = error.code;
      let message = error.message;
      if (code === 'notInitialized') {
        throw new KitNotInitializedError(message);
      }
      if (code === 'invalidArgument') {
        throw new KitInvalidArgumentError(message);
      }
      if (code === 'timeout') {
        throw new KitTimeoutError(message);
      }
      if (code === 'internal') {
        throw new KitInternalError(message);
      }
      if (code === 'connectionRequired') {
        throw new KitConnectionRequiredError(message);
      }
      if (code === 'networkIssues') {
        throw new KitNetworkError(message);
      }
      if (code === 'unknown') {
        throw new KitUnknownError(message);
      }
    } else {
      throw new KitUnknownError('Unknown error');
    }
  }
}
