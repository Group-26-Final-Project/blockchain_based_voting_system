import React, { useState } from 'react';

import { useFonts } from 'expo-font';

import AppLoading from 'expo-app-loading';

import { StyleSheet, Text, TextInput, View, Keyboard, TouchableOpacity } from "react-native";
import { Feather, Entypo } from "@expo/vector-icons";

const customFonts = {
  poppinsRegular: require('../assets/fonts/Poppins-Regular.ttf'),
  poppinsBold: require('../assets/fonts/Poppins-Bold.ttf'),
  poppinsSemi: require('../assets/fonts/Poppins-SemiBold.ttf'),
}

// const SearchBar = ({clicked, searchPhrase, setSearchPhrase, setClicked}) => {
const SearchBar = (props) => {
  const [clicked, setClicked] = useState(false);
  const [searchPhrase, setSearchPhrase] = useState('');

  const [isLoaded] = useFonts(customFonts);

  if (!isLoaded) {
    return <AppLoading />;
  } else {
    return (
      <View style={styles.container}>
        <View
          style={
            clicked
              ? styles.searchBar__clicked
              : styles.searchBar__unclicked
          }
        >
          {/* search Icon */}
          <Feather
            name="search"
            size={20}
            color='rgba(35, 35, 35, 0.5)'
            style={{ marginLeft: 1 }}
          />
          {/* Input field */}
          <TextInput
            style={styles.input}
            placeholder="Search"
            value={searchPhrase}
            onChangeText={setSearchPhrase}
            onFocus={() => {
              setClicked(true)
            }}
          />
          {/* cross Icon, depending on whether the search bar is clicked or not */}
          {clicked && (
            <Entypo name="cross" size={20} color='rgba(35, 35, 35, 0.5)' style={{ padding: 1 }} onPress={() => {
              setSearchPhrase("")
            }} />
          )}
        </View>
        {clicked && (
          <View>
            <TouchableOpacity
              style={styles.button}
              onPress={() => {
                Keyboard.dismiss();
                setClicked(false);
              }}
            >
              <Text style={{ color: '#00d05a', fontSize: 16, margin: 5 }}>Cancel</Text>
            </TouchableOpacity>
          </View>
        )}
      </View>
    );
  }
};
export default SearchBar;

// styles
const styles = StyleSheet.create({
  container: {
    justifyContent: "center",
    alignSelf: 'center',
    alignItems: "center",
    flexDirection: "row",
    width: "95%",

  },
  searchBar__unclicked: {
    padding: 10,
    flexDirection: "row",
    width: "100%",
    backgroundColor: "#D3E8E633",
    borderRadius: 15,
    alignItems: "center",
  },
  searchBar__clicked: {
    padding: 10,
    flexDirection: "row",
    width: "85%",
    backgroundColor: "#D3E8E633",
    borderRadius: 15,
    alignItems: "center",
    justifyContent: "center",
  },
  input: {
    color: 'rgba(35, 35, 35, 0.5)',
    fontSize: 18,
    marginLeft: 10,
    width: "80%",
  },

});