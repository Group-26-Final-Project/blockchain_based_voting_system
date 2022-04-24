import React, { useState } from 'react';

import { useFonts } from 'expo-font';

import AppLoading from 'expo-app-loading';
import { StyleSheet, Text, View, Dimensions, TouchableHighlight, Image } from 'react-native';
import Icon from 'react-native-vector-icons/AntDesign';

const customFonts = {
    poppinsRegular: require('../assets/fonts/Poppins-Regular.ttf'),
    poppinsLight: require('../assets/fonts/Poppins-Light.ttf'),
    poppinsBold: require('../assets/fonts/Poppins-Bold.ttf'),
    poppinsSemi: require('../assets/fonts/Poppins-SemiBold.ttf'),
}

export default CandidateBio = (props) => {
    const [isLoaded] = useFonts(customFonts);
    const img = props.image;

    if (!isLoaded) {
        return <AppLoading />;
    } else {
        return (
            <View style={styles.container}>
                <View style={styles.imgContainer}>
                    <Image style={styles.image} source={props.image} />
                </View>
                <View>
                    <Text style={styles.name}>Kaleb Mesfin</Text>
                </View>
                <View style={styles.bio}>
                    <Text style={styles.bio}>
                    {`Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent iaculis, mi non facilisis ullamcorper, neque risus convallis sapien, id lobortis ligula lorem imperdiet ex. Suspendisse malesuada, dolor sed sodales porta, mauris sapien placerat arcu`}
                    </Text>
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'column',
        borderRadius: 8,
        backgroundColor: '#F6FAFA',
        shadowColor: 'rgba(35, 35, 35, 0.2)',
        marginHorizontal: 10,
        marginVertical: 8,
        paddingTop: 6,
        alignItems: 'center',
    },
    imgContainer: {
        height: Dimensions.get('window').height * 0.125,
        width: Dimensions.get('window').height * 0.125,
        borderRadius: Dimensions.get('window').height * 0.125 / 2,
        marginRight: 15,
        marginTop: 35,
        marginBottom: 20
    },
    image: {
        flex: 1,
        borderRadius: Dimensions.get('window').height * 0.125 / 2,
        resizeMode: 'cover',
        height: undefined,
        width: undefined,
        paddingHorizontal: 10,
    },
    name: {
        fontFamily: 'poppinsSemi',
        fontSize: 28,
        color: '#2F313D',
        marginVertical: 10
    },
    bio: {
        fontFamily: 'poppinsLight',
        fontSize: 14,
        color: '#2F313D',
        textAlign: 'justify',
        marginBottom: 10,
        marginHorizontal: 10
    }
});