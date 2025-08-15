/*
 * Copyright (c) 2011 - 2025, Voximplant, Inc. All rights reserved.
 */

import { NativeModules, TurboModuleRegistry } from 'react-native';
import VoximplantKitChat from './NativeVoximplantKitChat';

let turboModule = TurboModuleRegistry ? VoximplantKitChat : null;

let VoximplantKitChatModule = turboModule
  ? turboModule
  : NativeModules.VoximplantKitChat;

export default VoximplantKitChatModule;
