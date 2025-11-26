/*
 * Copyright (c) 2011 - 2025, Voximplant, Inc. All rights reserved.
 */

import Foundation
import VoximplantKitChatUI

@objcMembers public class RNVIKitChatImpl : NSObject {
  private var kitChatUI: VIKitChatUI?
  public static var rootViewController: UIViewController?
  private var kitChatCustomization = VIKitChatUICustomization()

  public func initialize(region: String, channelUuid: String, token: String, clientId: String, completion: (String?, String?) -> Void) {
    guard let kitRegion = convertStringToRegion(region: region) else {
      completion("invalidArgument", "KitRegion is invalid")
      return
    }
    kitChatUI = VIKitChatUI(accountRegion: kitRegion, channelUuid: channelUuid, token: token, clientId: clientId)
    guard kitChatUI != nil else {
      completion("internal", "KitChat is not initialized")
      return
    }
    completion(nil, nil)
  }

  public func openChat(completion: @escaping (String?, String?) -> Void) {
    guard let kitChatUI = self.kitChatUI else {
      completion("notInitialized", "KitChat is not initialized")
      return
    }

    guard let rootVC = RNVIKitChatImpl.rootViewController else {
      completion("notInitialized", "rootViewController is not set");
      return
    }

    DispatchQueue.main.async { [weak self] in
      guard let self = self else {
        completion("notInitialized", "Native module is not initialized")
        return
      }

      guard let kitChatViewController = VIKitChatViewController(id: kitChatUI.id, customization: self.kitChatCustomization) else {
        completion("notInitialized", "KitChatViewController is not initialized")
        return
      }

      if let navigationController = rootVC.navigationController {
        navigationController.pushViewController(kitChatViewController, animated: false)
      } else {
        rootVC.present(kitChatViewController, animated: false)
      }
      completion(nil, nil)
    }
  }

  public func registerPushToken(token: String, isDevelopment: Bool, completion: @escaping (String?, String?) -> Void) {
    guard let kitChatUI else {
      completion("notInitialized", "KitChat is not initialized")
      return
    }
    guard let tokenData = convertStringToData(str: token) else {
      completion("invalidArgument", "token is invalid")
      return
    }

    kitChatUI.registerPushToken(tokenData, isDevelopment: isDevelopment) { error in
      guard let error else {
        completion(nil, nil)
        return
      }
      switch error {
      case .emptyPushToken:
        completion("invalidArgument", error.description)
      case .networkIssues:
        completion("networkIssues", error.description)
      case .timeout:
        completion("timeout", error.description)
      case .internalError:
        completion("internal", error.description)
      default:
        completion("unknown", error.description)
      }
    }
  }

  public func unregisterPushToken(token: String, isDevelopment: Bool, completion: @escaping (String?, String?) -> Void) {
    guard let kitChatUI else {
      completion("notInitialized", "KitChat is not initialized")
      return
    }
    guard let tokenData = convertStringToData(str: token) else {
      completion("invalidArgument", "token is invalid")
      return
    }
    kitChatUI.unregisterPushToken(tokenData, isDevelopment: isDevelopment) { error in
      guard let error else {
        completion(nil, nil)
        return
      }
      switch error {
      case .emptyPushToken:
        completion("invalidArgument", error.description);
      case .networkIssues:
        completion("networkIssues", error.description)
      case .timeout:
        completion("timeout", error.description)
      case .internalError:
        completion("internal", error.description)
      default:
        completion("unknown", error.description)
      }
    }
  }

  public func setClientData(_ clientData: Dictionary<String, Any>, completion: @escaping (String?, String?) -> Void) {
    guard let kitChatUI else {
      completion("notInitialized", "KitChat is not initialized")
      return
    }

    var clientDataToNative: VIClientData = VIClientData()
    if clientData["avatarUrl"] != nil {
      if let avatarUrlValue = clientData["avatarUrl"] as? String {
        clientDataToNative.avatarUrl = avatarUrlValue
      } else {
        completion("invalidArgument", "avatarUrl is of incorrect type")
        return
      }
    }

    if clientData["displayName"] != nil {
      if let displayNameValue = clientData["displayName"] as? String {
        clientDataToNative.displayName = displayNameValue
      } else {
        completion("invalidArgument", "displayName is of incorrect type")
        return
      }
    }

    if clientData["email"] != nil {
      if let emailValue = clientData["email"] as? String {
        clientDataToNative.email = emailValue
      } else {
        completion("invalidArgument", "email is of incorrect type")
        return
      }
    }

    if clientData["phone"] != nil {
      if let phoneValue = clientData["phone"] as? String {
        clientDataToNative.phone = phoneValue
      } else {
        completion("invalidArgument", "phone is of incorrect type")
        return
      }
    }

    if clientData["language"] != nil {
      if let languageValue = clientData["language"] as? String {
        clientDataToNative.language = languageValue
      } else {
        completion("invalidArgument", "language is of incorrect type")
        return
      }
    }

    kitChatUI.setClientData(clientDataToNative) { error in
      guard let error else {
        completion(nil, nil)
        return
      }
      switch (error) {
      case .invalidEmail:
        completion("invalidArgument", error.description)
      case .emptyData:
        completion("invalidArgument", error.description)
      case .networkIssues:
        completion("networkIssues", error.description)
      case .timeout:
        completion("timeout", error.description)
      case .internalError:
        completion("internal", error.description)
      @unknown default:
        completion("unknown", error.description)
      }
    }
  }

  public func customizeColors(colorScheme: Dictionary<String, Any>) {
    var customizableColors = VIKitChatCustomizableColors()

    if let brandColorString = colorScheme["brand"] as? String,
       let brandColor = convertStringToColor(hex: brandColorString) {
      customizableColors.brand = brandColor
    }
    if let brandContainerColorString = colorScheme["brandContainer"] as? String,
       let brandContainerColor = convertStringToColor(hex: brandContainerColorString) {
      customizableColors.brandContainer = brandContainerColor
    }
    if let negativeColorString = colorScheme["negative"] as? String,
       let negativeColor = convertStringToColor(hex: negativeColorString) {
      customizableColors.negative = negativeColor
    }
    if let negativeContainerColorString = colorScheme["negativeContainer"] as? String,
       let negativeContainerColor = convertStringToColor(hex: negativeContainerColorString) {
      customizableColors.negativeContainer = negativeContainerColor
    }
    if let onBrandColorString = colorScheme["onBrand"] as? String,
       let onBrandColor = convertStringToColor(hex: onBrandColorString) {
      customizableColors.onBrand = onBrandColor
    }
    if let onBrandContainerColorString = colorScheme["onBrandContainer"] as? String,
       let onBrandContainerColor = convertStringToColor(hex: onBrandContainerColorString) {
      customizableColors.onBrandContainer = onBrandContainerColor
    }
    if let positiveColorString = colorScheme["positive"] as? String,
       let positiveColor = convertStringToColor(hex: positiveColorString) {
      customizableColors.positive = positiveColor
    }
    if let positiveContainerColorString = colorScheme["positiveContainer"] as? String,
       let positiveContainerColor = convertStringToColor(hex: positiveContainerColorString) {
      customizableColors.positiveContainer = positiveContainerColor
    }
    if let avatarPlaceholderColorString = colorScheme["avatarPlaceholder"] as? String {
      if (avatarPlaceholderColorString == "transparent") {
        customizableColors.avatarPlaceholder = UIColor.clear
      } else if let avatarPlaceholderColor = convertStringToColor(hex: avatarPlaceholderColorString) {
        customizableColors.avatarPlaceholder = avatarPlaceholderColor
      }
    }
    kitChatCustomization.colorScheme = customizableColors
  }

  public func customizeStrings(_ strings: Dictionary<String, Any>) {
    var customizableStrings = VIKitChatCustomizableStrings()

    if let chatTitle = strings["chatTitle"] as? String {
      customizableStrings.chatTitle = chatTitle
    }

    if let messagePlaceHolder = strings["messagePlaceholder"] as? String {
      customizableStrings.messagePlaceholder = messagePlaceHolder
    }

    if let attachmentPickerStrings = strings["attachmentPicker"] as? Dictionary<String, Any> {
      if let camera = attachmentPickerStrings["camera"] as? String {
        customizableStrings.attachmentPicker.camera = camera
      }
      if let file = attachmentPickerStrings["file"] as? String {
        customizableStrings.attachmentPicker.file = file
      }
      if let gallery = attachmentPickerStrings["gallery"] as? String {
        customizableStrings.attachmentPicker.gallery = gallery
      }
    }

    if let connectionStateStrings = strings["connectionState"] as? Dictionary<String, Any> {
      if let connecting = connectionStateStrings["connecting"] as? String {
        customizableStrings.connectionState.connecting = connecting
      }
      if let online = connectionStateStrings["online"] as? String {
        customizableStrings.connectionState.online = online
      }
      if let offline = connectionStateStrings["offline"] as? String {
        customizableStrings.connectionState.offline = offline
      }
    }

    if let contextMenuStrings = strings["contextMenu"] as? Dictionary<String, Any> {
      if let copyTextAction = contextMenuStrings["copyTextAction"] as? String {
        customizableStrings.contextMenu.copyTextAction = copyTextAction
      }
      if let resendMessageAction = contextMenuStrings["resendMessageAction"] as? String {
        customizableStrings.contextMenu.resendMessageAction = resendMessageAction
      }
      if let saveImageAction = contextMenuStrings["saveImageAction"] as? String {
        customizableStrings.contextMenu.saveImageAction = saveImageAction
      }
    }

    if let errorStrings = strings["error"] as? Dictionary<String, Any> {
      if let fileSizeError = errorStrings["fileSizeError"] as? String {
        customizableStrings.errors.fileSizeError = fileSizeError
      }
      if let fileTypeError = errorStrings["fileTypeError"] as? String {
        customizableStrings.errors.fileTypeError = fileTypeError
      }
      if let invalidFileError = errorStrings["invalidFileError"] as? String {
        customizableStrings.errors.invalidFileError = invalidFileError
      }
      if let multipleInvalidFilesError = errorStrings["multipleInvalidFilesError"] as? String {
        customizableStrings.errors.multipleInvalidFilesError = multipleInvalidFilesError
      }
    }
    if let noticeStrings = strings["notice"] as? Dictionary<String, Any> {
      if let accessFileError = noticeStrings["accessFileError"] as? String {
        customizableStrings.notice.accessFileError = accessFileError
      }
      if let copyTextSuccess = noticeStrings["copyTextSuccess"] as? String {
        customizableStrings.notice.copyTextSuccess = copyTextSuccess
      }
      if let fileLimitError = noticeStrings["fileLimitError"] as? String {
        customizableStrings.notice.fileLimitError = fileLimitError
      }
      if let openImageError = noticeStrings["openImageError"] as? String {
        customizableStrings.notice.openImageError = openImageError
      }
      if let saveImageError = noticeStrings["saveImageError"] as? String {
        customizableStrings.notice.saveImageError = saveImageError
      }
      if let saveImageSuccess = noticeStrings["saveImageSuccess"] as? String {
        customizableStrings.notice.saveImageSuccess = saveImageSuccess
      }
      if let sendInvalidFilesError = noticeStrings["sendInvalidFilesError"] as? String {
        customizableStrings.notice.sendInvalidFilesError = sendInvalidFilesError
      }
    }
    if let permissionStrings = strings["permission"] as? Dictionary<String, Any> {
      if let closeAction = permissionStrings["closeAction"] as? String {
        customizableStrings.permissionAlert.closeAction = closeAction
      }
      if let settingsAction = permissionStrings["settingsAction"] as? String {
        customizableStrings.permissionAlert.settingsAction = settingsAction
      }
      if let title = permissionStrings["title"] as? String {
        customizableStrings.permissionAlert.title = title
      }
    }
    if let senderStrings = strings["sender"] as? Dictionary<String, Any> {
      if let agentDisplayName = senderStrings["agentDisplayName"] as? String {
        customizableStrings.senders.agentDisplayName = agentDisplayName
      }
      if let botDisplayName = senderStrings["botDisplayName"] as? String {
        customizableStrings.senders.botDisplayName = botDisplayName
      }
    }
    kitChatCustomization.strings = customizableStrings
  }

  public func customizeIcons(_ icons: Dictionary<String, Any>) {
    var customizableIcons = VIKitChatCustomizableIcons()

    if let errorIcon = icons["error"] as? String,
       let errorIconImage = UIImage(named: errorIcon, in: Bundle.main, with: nil) {
      customizableIcons.error = errorIconImage
    }

    if let successIcon = icons["success"] as? String,
       let successIconImage = UIImage(named: successIcon, in: Bundle.main, with: nil) {
      customizableIcons.success = successIconImage
    }

    if let actionIcons = icons["actions"] as? Dictionary<String, Any> {
      if let add = actionIcons["add"] as? String,
         let addImage = UIImage(named: add, in: Bundle.main, with: nil) {
        customizableIcons.actions.add = addImage
      }
      if let back = actionIcons["back"] as? String,
         let backImage = UIImage(named: back, in: Bundle.main, with: nil) {
        customizableIcons.actions.back = backImage
      }
      if let chooseFile = actionIcons["chooseFile"] as? String,
         let chooseFileImage = UIImage(named: chooseFile, in: Bundle.main, with: nil) {
        customizableIcons.actions.chooseFile = chooseFileImage
      }
      if let copy = actionIcons["copy"] as? String,
         let copyImage = UIImage(named: copy, in: Bundle.main, with: nil) {
        customizableIcons.actions.copy = copyImage
      }
      if let resend = actionIcons["resend"] as? String,
         let resendImage = UIImage(named: resend, in: Bundle.main, with: nil) {
        customizableIcons.actions.resend = resendImage
      }
      if let save = actionIcons["save"] as? String,
         let saveImage = UIImage(named: save, in: Bundle.main, with: nil) {
        customizableIcons.actions.save = saveImage
      }
      if let selectFromGallery = actionIcons["selectFromGallery"] as? String,
         let selectFromGalleryImage = UIImage(named: selectFromGallery, in: Bundle.main, with: nil) {
        customizableIcons.actions.selectFromGallery = selectFromGalleryImage
      }
      if let send = actionIcons["send"] as? String,
         let sendImage = UIImage(named: send, in: Bundle.main, with: nil) {
        customizableIcons.actions.send = sendImage
      }
      if let share = actionIcons["share"] as? String,
         let shareImage = UIImage(named: share, in: Bundle.main, with: nil) {
        customizableIcons.actions.share = shareImage
      }
      if let takePhoto = actionIcons["takePhoto"] as? String,
         let takePhotoImage = UIImage(named: takePhoto, in: Bundle.main, with: nil) {
        customizableIcons.actions.takePhoto = takePhotoImage
      }
    }

    if let attachmentIcons = icons["attachments"] as? Dictionary<String, Any> {
      if let document = attachmentIcons["document"] as? String,
         let documentImage = UIImage(named: document, in: Bundle.main, with: nil) {
        customizableIcons.attachments.document = documentImage
      }
      if let download = attachmentIcons["download"] as? String,
         let downloadImage = UIImage(named: download, in: Bundle.main, with: nil) {
        customizableIcons.attachments.download = downloadImage
      }
      if let error = attachmentIcons["error"] as? String,
         let errorImage = UIImage(named: error, in: Bundle.main, with: nil) {
        customizableIcons.attachments.error = errorImage
      }
    }

    if let senderIcons = icons["senders"] as? Dictionary<String, Any> {
      if let agent = senderIcons["agent"] as? String,
         let agentImage = UIImage(named: agent, in: Bundle.main, with: nil) {
        customizableIcons.senders.agent = agentImage
      }
      if let bot = senderIcons["bot"] as? String,
         let botImage = UIImage(named: bot, in: Bundle.main, with: nil) {
        customizableIcons.senders.bot = botImage
      }
    }
    kitChatCustomization.icons = customizableIcons
  }


  private func convertStringToRegion(region: String) -> VIRegion? {
    switch region {
    case "BR":
      return VIRegion.br
    case "EU":
      return VIRegion.eu
    case "KZ":
      return VIRegion.kz
    case "RU":
      return VIRegion.ru
    case "RU_2":
      return VIRegion.ru2
    case "US":
      return VIRegion.us
    default:
      return nil
    }
  }

  private func convertStringToData(str: String) -> Data? {
    let values = str.compactMap { $0.hexDigitValue } // map char to value of 0-15 or nil
    if values.count == str.count && values.count % 2 == 0 {
      var data = Data()
      for x in stride(from: 0, to: values.count, by: 2) {
        let byte = (values[x] << 4) + values[x+1] // concat high and low bits
        data.append(UInt8(byte))
      }
      return data
    }
    return nil
  }

  private func convertStringToColor(hex: String) -> UIColor? {
    var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if hexString.hasPrefix("#") {
      hexString.removeFirst()
    }
    let scanner = Scanner(string: hexString)

    var rgbValue: UInt64 = 0
    guard scanner.scanHexInt64(&rgbValue) else {
      return nil
    }

    var red, green, blue, alpha: CGFloat
    switch hexString.count {
    case 6:
      red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
      green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
      blue = CGFloat(rgbValue & 0x0000FF) / 255.0
      alpha = 1.0
    case 8:
      red = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
      green = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
      blue = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
      alpha = CGFloat(rgbValue & 0x000000FF) / 255.0
    default:
      return nil
    }

    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }
}
