import React, { useState } from 'react'
import { useFonts } from 'expo-font';
import AppLoading from 'expo-app-loading';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import OtpInputs from 'react-native-otp-inputs';

const customFonts = {
    poppinsRegular: require('../assets/fonts/Poppins-Regular.ttf'),
    poppinsThin: require('../assets/fonts/Poppins-Thin.ttf'),
    poppinsSemi: require('../assets/fonts/Poppins-SemiBold.ttf'),
}

export default OTPBody = (props) => {
    const [isLoaded] = useFonts(customFonts);
    const [otp, setOtp] = useState('')

    const handleChange = (text) => {
        setOtp(text)
    }

    const handleSubmit = () => {
        console.log(otp)        
    }

    if (!isLoaded) {
        return <AppLoading />;
    } else {
        return (
            <View>
                <Text>{otp}</Text>
                <View style={styles.container}>
                    <OtpInputs
                        autofillFromClipboard={false}
                        numberOfInputs={6}
                        blurOnSubmit={true}
                        keyboardType={'ascii-capable'}
                        style={styles.otp}
                        inputStyles={styles.inputOtp}
                        handleChange={handleChange}
                    />
                </View>
                <View style={styles.container}>
                    <View>
                        <Text style={styles.quest}>Didn't receive an OTP?</Text>
                        <Text style={styles.resend}>Resend OTP</Text>
                    </View>
                    <View>
                        <TouchableOpacity style={styles.button}>
                            <Text style={styles.buttonText} onPress={handleSubmit}>Submit</Text>
                        </TouchableOpacity>
                    </View>
                </View>
            </View>

        );
    }
}

const styles = StyleSheet.create({
    container: {
        paddingHorizontal: 10,
        paddingTop: 40,
        backgroundColor: '#fff',
    },
    otp: {
        flexDirection: 'row',
        backgroundColor: "#fff",
        justifyContent: 'center',
    },
    inputOtp: {
        borderRadius: 10,
        padding: 12,
        margin: 6,
        color: "#000",
        fontSize: 24,
        textAlign: 'center',
        backgroundColor: '#00D05A20'
    },
    quest: {
        fontFamily: 'poppinsThin',
        fontSize: 16,
        textAlign: 'center',
        marginBottom: 15,
        color: '#2F313D',
    },
    resend: {
        color: '#2F313D',
        fontFamily: 'poppinsSemi',
        fontSize: 16,
        textAlign: 'center',
        marginBottom: 50,
        textDecorationLine: 'underline'
    },
    button: {
        width: '100%',
        padding: 15,
        borderRadius: 15,
        backgroundColor: '#00d05a',
        alignItems: 'center',
    },
    buttonText: {
        color: 'white', 
        fontSize: 18, 
        letterSpacing: 1, 
        fontFamily: 'poppinsRegular'
    }
})