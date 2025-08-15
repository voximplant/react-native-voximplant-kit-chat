module.exports = {
  dependency: {
    platforms: {
      android: {
        libraryName: 'VoximplantKitChatSpec',
        packageImportPath:
          'import com.voximplantkitchat.VoximplantKitChatPackage;',
        packageInstance: 'new VoximplantKitChatPackage()',
      },
      ios: {
        podspecPath: './react-native-voximplant-kit-chat.podspec',
      },
      macos: null,
      windows: null,
    },
  },
};
