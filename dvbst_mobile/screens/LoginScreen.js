import React from 'react'

import { StyleSheet, Text, View, TextInput, Dimensions, TouchableOpacity } from 'react-native';

const LoginScreen = (props) => {
    return (
        <View style={styles.container}>
            <View style={{alignItems: 'flex-end', marginBottom: 15}}>
                <Text style={{fontSize: 36}}>Login</Text>
                <View style={styles.line}></View>
            </View>
            <View>
                <View>
                    <Text style={styles.label}>ID</Text>
                    <TextInput style={styles.textinput}></TextInput>
                </View>
                <View>
                    <Text style={styles.label}>Password</Text>
                    <TextInput style={styles.textinput}></TextInput>
                </View>
            </View>
            <TouchableOpacity style={styles.button}>
                <Text style={{color: '#fff', fontSize: 20}}>Login</Text>
            </TouchableOpacity>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
      backgroundColor: '#fff',
      alignItems: 'flex-start',
      justifyContent: 'center',
    },
    line: {
      width: Dimensions.get('window').width * 0.14,
      height: Dimensions.get('window').height * 0.005,
      backgroundColor: '#00d05a',
      alignItems: 'flex-end',
      justifyContent: 'flex-end',
    },
    textinput: {
        marginBottom: 20,
        width: Dimensions.get('window').width * 0.84,
        height: Dimensions.get('window').height * 0.06,
        borderWidth: 0.5,
        borderColor: '#000',
        borderRadius: 10
    },
    label: {
        fontSize: 16,
        paddingBottom: 10,
    },
    button: {
        alignSelf: 'center',
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#00d05a',
        width: Dimensions.get('window').width * 0.6,
        height: Dimensions.get('window').height * 0.07,
        marginTop: 20,
        borderRadius: 10
    },
  });

export default LoginScreen;