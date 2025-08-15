/*
 * Copyright (c) 2011 - 2025, Voximplant, Inc. All rights reserved.
 */

/**
 * Interface that represents the chat color scheme configuration.
 */
export interface KitColorScheme {
  /**
   * Brand or accent color. Default color is 0xFF662EFF.
   */
  brand?: string | null;
  /**
   * Brand or accent color that applies to containers. The default color is 0xFFF2EEFF.
   */
  brandContainer?: string | null;
  /**
   * Color to highlight errors. The default color is 0xFFF74E57.
   */
  negative?: string | null;
  /**
   * Color that applies to containers to highlight errors. The default color is 0xFFFFF1F1.
   */
  negativeContainer?: string | null;
  /**
   * Color that appears on top of a brand color. The default color is 0xFFFFFFFF.
   */
  onBrand?: string | null;
  /**
   * Color that appears on top of a brandContainer color. The default color is 0xFF311678.
   */
  onBrandContainer?: string | null;
  /**
   * Color to highlight success states. The default color is 0xFF5AD677.
   */
  positive?: string | null;
  /**
   * Color that applies to containers to highlight success states. The default color is 0xFFEDFBF0.
   */
  positiveContainer?: string | null;
}

/**
 * Interface that represents the localized string set for the attachment picker component.
 *
 * iOS only.
 */
export interface KitAttachmentPickerStringsIos {
  /**
   * Localized string for the action to take a photo.
   */
  camera?: string | null;
  /**
   * Localized string for the action to choose a file from the device.
   */
  file?: string | null;
  /**
   * Localized string for the action to select an image from the gallery.
   */
  gallery?: string | null;
}

/**
 * Interface that represents the localized string set for the chat connection state.
 *
 * iOS only.
 */
export interface KitConnectionStateStringsIos {
  /**
   * Localized string for the connecting state.
   */
  connecting?: string | null;
  /**
   * Localized string for the online state.
   */
  online?: string | null;
  /**
   * Localized string for the offline state.
   */
  offline?: string | null;
}

/**
 * Interface that represents the localized string set for context menu actions.
 *
 * iOS only.
 */
export interface KitContextMenuStringsIos {
  /**
   * Localized string for the action to copy text.
   */
  copyTextAction?: string | null;
  /**
   * Localized string for the action to resend a message.
   */
  resendMessageAction?: string | null;
  /**
   * Localized string for the action to save an image.
   */
  saveImageAction?: string | null;
}

/**
 * Interface that represents the localized string set for errors.
 *
 * iOS only.
 */
export interface KitErrorStringsIos {
  /**
   * Localized string for the error message that the attached file size exceeds the allowable limit.
   */
  fileSizeError?: string | null;
  /**
   * Localized string for the error message that the attached file’s MIME type is not supported.
   */
  fileTypeError?: string | null;
  /**
   * Localized string for the error message that the attached file is empty or corrupted.
   */
  invalidFileError?: string | null;
  /**
   * Localized string for the error message that some file attachments do not meet the requirements.
   */
  multipleInvalidFilesError?: string | null;
}

/**
 * Interface that represents the localized string set for a notice.
 *
 * iOS only.
 */
export interface KitNoticeStringsIos {
  /**
   * Localized string for the notice that a file cannot be accessed.
   */
  accessFileError?: string | null;
  /**
   * Localized string for the notice that text has been copied.
   */
  copyTextSuccess?: string | null;
  /**
   * Localized string for the notice that the file attachments limit for an outbound message has been exceeded.
   */
  fileLimitError?: string | null;
  /**
   * Localized string for the notice that an image cannot be opened.
   */
  openImageError?: string | null;
  /**
   * Localized string for the notice that an image has not been saved.
   */
  saveImageError?: string | null;
  /**
   * Localized string for the notice that an image has been saved.
   */
  saveImageSuccess?: string | null;
  /**
   * Localized string for the notice that an outbound message with invalid file attachments cannot be sent.
   */
  sendInvalidFilesError?: string | null;
}

/**
 * Interface that represents the localized string set for the camera access permission alert.
 *
 * iOS only.
 */
export interface KitPermissionAlertStringsIos {
  /**
   * Localized string for the action to close the alert.
   */
  closeAction?: string | null;
  /**
   * Localized string for the action to open system settings.
   */
  settingsAction?: string | null;
  /**
   * Localized string for the alert title.
   */
  title?: string | null;
}

/**
 * Interface that represents the localized string set for the sender’s default display name.
 *
 * iOS only.
 */
export interface KitSenderStringsIos {
  /**
   * Localized string for the agent’s default display name.
   */
  agentDisplayName?: string | null;
  /**
   * Localized string for the agent’s default display name.
   */
  botDisplayName?: string | null;
}

/**
 * Interface that represents localized strings for the user interface.
 *
 * iOS only.
 */
export interface KitCustomizableStringsIos {
  /**
   * Localized strings configuration for the attachment picker component.
   */
  attachmentPicker?: KitAttachmentPickerStringsIos | null;
  /**
   * Localized strings configuration for chat connection states.
   */
  connectionState?: KitConnectionStateStringsIos | null;
  /**
   * Localized strings configuration for context menu actions.
   */
  contextMenu?: KitContextMenuStringsIos | null;
  /**
   * Localized strings configuration for errors.
   */
  error?: KitErrorStringsIos | null;
  /**
   * Localized strings configuration for a notice.
   */
  notice?: KitNoticeStringsIos | null;
  /**
   * Localized string configuration for the camera access permission alert.
   */
  permission?: KitPermissionAlertStringsIos | null;
  /**
   * Localized strings configuration for the sender’s default display name.
   */
  sender?: KitSenderStringsIos | null;
  /**
   * Localized string that represents the chat title.
   */
  chatTitle?: string | null;
  /**
   * Localized string that represents placeholder text for an outbound message.
   */
  messagePlaceholder?: string | null;
}

/**
 * Interface that represents the icon set for actions a user can perform on the view controller.
 *
 * iOS only.
 */
export interface KitActionIconsIos {
  /**
   * Icon that represents the action to add attachments to an outbound message. The recommended icon size is 24x24.
   */
  add?: string | null;
  /**
   * Icon that represents the action to go back on the navigation bar. The recommended icon size is 24x24.
   */
  back?: string | null;
  /**
   * Icon that represents the action to choose a file from the device. The recommended icon size is 24x24.
   */
  chooseFile?: string | null;
  /**
   * Icon that represents the action to copy text. The recommended icon size is 24x24.
   */
  copy?: string | null;
  /**
   * Icon that represents the action to resend a failed message. The recommended icon size is 24x24.
   */
  resend?: string | null;
  /**
   * Icon that represents the action to save an image. The recommended icon size is 24x24.
   */
  save?: string | null;
  /**
   * Icon that represents the action to select an image from the gallery. The recommended icon size is 24x24.
   */
  selectFromGallery?: string | null;
  /**
   * Icon that represents the action to send a message. The recommended icon size is 24x24.
   */
  send?: string | null;
  /**
   * Icon that represents the action to share files. The recommended icon size is 24x24.
   */
  share?: string | null;
  /**
   * Icon that represents the action to take a photo. The recommended icon size is 24x24.
   */
  takePhoto?: string | null;
}

/**
 * Interface that represents the icon set for attachments visualization and attachments related actions.
 *
 * iOS only.
 */
export interface KitAttachmentIconsIos {
  /**
   * Icon that represents a document attachment in a message. The recommended icon size is 24x24.
   */
  document?: string | null;
  /**
   * Icon that represents the action to download an attachment. The recommended icon size is 24x24.
   */
  download?: string | null;
  /**
   * Icon that represents the attachment error state. The recommended icon size is 24x24.
   */
  error?: string | null;
}

/**
 * Interface that represents the icon set for senders.
 *
 * iOS only.
 */
export interface KitSenderIconsIos {
  /**
   * Icon that represents the agent’s default avatar. The recommended icon size is 20x20.
   */
  agent?: string | null;
  /**
   * Icon that represents the bot’s default avatar. The recommended icon size is 20x20.
   */
  bot?: string | null;
}

/**
 * Interface that represents the configuration of chat icons on iOS.
 *
 * iOS only.
 */
export interface KitCustomizableIconsIos {
  /**
   * Configuration of icons for actions a user can perform on the view controller.
   */
  actions?: KitActionIconsIos | null;
  /**
   * Icons configuration for attachments visualization and actions related to attachments.
   */
  attachments?: KitAttachmentIconsIos | null;
  /**
   * Icons configuration for senders.
   */
  senders?: KitSenderIconsIos | null;
  /**
   * Icon to highlight errors. The recommended icon size is 16x16.
   */
  error?: string | null;
  /**
   * Icon to highlight success states. The recommended icon size is 16x16.
   */
  success?: string | null;
}

export interface KitCustomization {
  /**
   * Chat screen color scheme configuration.
   */
  colorScheme?: KitColorScheme | null;
  /**
   * User interface strings configuration on iOS.
   *
   * iOS only.
   */
  customizableStringsIos?: KitCustomizableStringsIos | null;
  /**
   * User interface icons configuration on iOS.
   *
   * iOS only.
   */
  customizableIconsIos?: KitCustomizableIconsIos | null;
}
