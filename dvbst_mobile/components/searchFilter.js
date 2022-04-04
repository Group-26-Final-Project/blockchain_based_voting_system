import React, { useState } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { Dropdown } from 'react-native-element-dropdown';
import { useFonts } from 'expo-font';
import AppLoading from 'expo-app-loading';

const customFonts = {
  poppinsRegular: require('../assets/fonts/Poppins-Regular.ttf'),
  poppinsBold: require('../assets/fonts/Poppins-Bold.ttf'),
  poppinsSemi: require('../assets/fonts/Poppins-SemiBold.ttf'),
}

const data = [
  { label: 'Popular', value: '1' },
  { label: 'Recent', value: '2' },
];

const SearchFilter = () => {
  const [value, setValue] = useState(null);
  const [isFocus, setIsFocus] = useState(false);
  const [isLoaded] = useFonts(customFonts);

  if (!isLoaded) {
    return <AppLoading />;
  } else {
    return (
    <View style={styles.container}>
      <Dropdown
        style={[styles.dropdown, isFocus && { borderColor: 'blue' }]}
        placeholderStyle={styles.placeholderStyle}
        selectedTextStyle={styles.selectedTextStyle}
        iconStyle={styles.iconStyle}
        data={data}
        maxHeight={300}
        labelField="label"
        valueField="value"
        placeholder={'All'}
        value={value}
        onFocus={() => setIsFocus(true)}
        onBlur={() => setIsFocus(false)}
        onChange={item => {
          setValue(item.value);
          setIsFocus(false);
        }}
        renderLeftIcon={() => (
          <Text style={styles.sortby}>Sort By: </Text>
        )}
      />
    </View>
  );
  }
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: 'white',
    paddingHorizontal: 12,
    paddingVertical: 16
  },
  dropdown: {
    width: 200,
    height: 50,
    borderRadius: 20,
    paddingHorizontal: 8,
    backgroundColor: '#d3e8e633',
  },
  icon: {
    marginRight: 5,
  },
  placeholderStyle: {
    justifyContent: 'center',
    fontSize: 16,
    color: 'rgba(0,0,0,0.8)'
  },
  selectedTextStyle: {
    fontSize: 16,
    color: 'rgba(0,0,0,0.8)'
  },
  iconStyle: {
    width: 35,
    height: 35,
  },
  sortby: {
    fontSize: 16,
    color: 'rgba(35, 35, 35, 0.5)',
    marginLeft: 5
  }
});

export default SearchFilter;