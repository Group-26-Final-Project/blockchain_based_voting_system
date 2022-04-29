import React from 'react'

import { StyleSheet, SafeAreaView } from 'react-native';
import OtpHeader from '../components/otpHeader';
import OtpBody from '../components/otpBody';

const OTPScreen = (props) => {
    return (
        <SafeAreaView style={styles.container}>
            <OtpHeader/>
            <OtpBody/>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        paddingHorizontal: 10,
        paddingTop: 40,
        backgroundColor: '#fff',
        flex: 1,
        justifyContent: 'center'
    },
})

export default OTPScreen;