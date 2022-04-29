import React from 'react'
import { useFonts } from 'expo-font';
import AppLoading from 'expo-app-loading';
import { StyleSheet, Text, View } from 'react-native';

const customFonts = {
    poppinsLight: require('../assets/fonts/Poppins-Light.ttf'),
    poppinsSemi: require('../assets/fonts/Poppins-SemiBold.ttf'),
}

export default OTPHeader = (props) => {
    const [isLoaded] = useFonts(customFonts);

    if (!isLoaded) {
        return <AppLoading />;
    } else {
        return (
            <View style={styles.container}>
                <Text style={styles.title}>Verification Code</Text>
                <Text style={styles.description}>Please enter the verification code sent to <Text style={{fontFamily: 'poppinsSemi'}}>+251 921538060</Text></Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        paddingHorizontal: 10,
        paddingTop: 40,
        marginBottom: 30,
        backgroundColor: '#fff',
    },
    title: {
        fontSize: 28,
        fontFamily: 'poppinsSemi',
        textAlign: 'center',
        margin: 10,
        color: '#2F313D',
    },
    description: {
        fontSize: 16,
        fontFamily: 'poppinsLight',
        textAlign: 'center',
        color: '#2F313D',
    }
})