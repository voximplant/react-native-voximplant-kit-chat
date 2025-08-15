/*
 * Copyright (c) 2011 - 2025, Voximplant, Inc. All rights reserved.
 */

import { NativeModules, TurboModuleRegistry } from 'react-native';
import VoximplantKitChat from './NativeVoximplantKitChat';

const turboModule = TurboModuleRegistry ? VoximplantKitChat : null;
const VoximplantKitChatModule = turboModule ?? NativeModules.VoximplantKitChat;

export default VoximplantKitChatModule;
