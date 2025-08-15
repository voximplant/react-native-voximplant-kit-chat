/*
 * Copyright (c) 2011 - 2025, Voximplant, Inc. All rights reserved.
 */

import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  initialize(
    region: string,
    channelUuid: string,
    token: string,
    clientId: string
  ): Promise<void>;

  openChat(): Promise<void>;
  setClientData(clientData: Object): Promise<void>;
  registerPushToken(token: string, isDevelopment: boolean): Promise<void>;
  unregisterPushToken(token: string, isDevelopment: boolean): Promise<void>;
  customizeColors(colorScheme: Object): void;
  customizeStrings(customizableStrings: Object): void;
  customizeIcons(customizableIcons: Object): void;
}

export default TurboModuleRegistry.get<Spec>('VoximplantKitChat');
