import React from 'react';
import { Button, StyleSheet, TextInput, View } from 'react-native';
import { KitChat, KitRegion } from '@voximplant/react-native-kit-chat';
import { Dropdown } from 'react-native-element-dropdown';

export default function App() {
  const [region, onChangeRegion] = React.useState(KitRegion.RU);
  const [channelUuid, onChangeChannelUuid] = React.useState('');
  const [token, onChangeToken] = React.useState('');
  const [clientId, onChangeClientId] = React.useState('');

  const kitChat: KitChat = new KitChat();

  const regionData = [
    { label: 'RU', value: KitRegion.RU },
    { label: 'RU 2', value: KitRegion.RU_2 },
    { label: 'US', value: KitRegion.US },
    { label: 'BR', value: KitRegion.BR },
    { label: 'EU', value: KitRegion.EU },
    { label: 'KZ', value: KitRegion.KZ },
  ];
  return (
    <View style={styles.container}>
      <Dropdown
        style={[styles.dropdown]}
        data={regionData}
        value={region}
        labelField="label"
        valueField="value"
        placeholder="Region"
        placeholderStyle={styles.dropdownPlaceholder}
        selectedTextStyle={styles.dropdownSelectedText}
        onChange={(item) => {
          onChangeRegion(item.value);
        }}
      />
      <TextInput
        style={styles.input}
        onChangeText={onChangeChannelUuid}
        value={channelUuid}
        placeholder="Channel UUID"
      />
      <TextInput
        style={styles.input}
        onChangeText={onChangeToken}
        value={token}
        placeholder="Token"
      />
      <TextInput
        style={styles.input}
        onChangeText={onChangeClientId}
        value={clientId}
        placeholder="Client ID"
      />
      <View style={styles.button}>
        <Button
          title="Open chat"
          onPress={async () => {
            await kitChat.initialize(region, channelUuid, token, clientId);
            await kitChat.openChat();
          }}
        />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    paddingTop: 40,
    flex: 1,
  },
  input: {
    height: 40,
    margin: 12,
    borderWidth: 1,
    padding: 10,
  },
  button: {
    padding: 10,
  },
  dropdown: {
    height: 50,
    margin: 12,
    borderWidth: 1,
    borderRadius: 4,
    paddingHorizontal: 8,
  },
  dropdownPlaceholder: {
    fontSize: 16,
  },
  dropdownSelectedText: {
    fontSize: 16,
  },
});
