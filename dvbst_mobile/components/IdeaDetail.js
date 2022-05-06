import React, { useState } from 'react';

import { useFonts } from 'expo-font';

import AppLoading from 'expo-app-loading';
import { StyleSheet, Text, View, Dimensions } from 'react-native';
import { AntDesign } from "@expo/vector-icons";
import { useDispatch } from 'react-redux';
import { voteIdea } from '../features/ideasSlice';


const customFonts = {
    poppinsRegular: require('../assets/fonts/Poppins-Regular.ttf'),
    poppinsBold: require('../assets/fonts/Poppins-Bold.ttf'),
    poppinsSemi: require('../assets/fonts/Poppins-SemiBold.ttf'),
}

const IdeaDetail = (props) => {
    const dispatch = useDispatch()
    const [isLoaded] = useFonts(customFonts);

    const clickHandler = () => {
        dispatch(voteIdea(props.id))
    }
    
    if (!isLoaded) {
        return <AppLoading />;
    } else {
        return (
            <View style={styles.boxShadow}>
                <View style={styles.box}>
                    <View>
                        {/* <Text style={styles.name}>User03729173</Text> */}
                        <Text style={styles.name}>{props.userName}</Text>
                    </View>
                    <View style={{ alignSelf: 'flex-start' }}>
                        <Text style={styles.title}>{props.title}</Text>
                        {/* <Text style={styles.title}>Lorem Ipsum Dolor</Text> */}
                        <View style={styles.line}></View>
                    </View>
                    <View style={styles.description}>
                        <Text style={{ fontSize: 14, fontFamily: 'poppinsRegular' }}>
                            {props.description}
                            {/* {`Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore `} */}
                        </Text>
                    </View>
                    <View style={styles.voting}>
                        {props.liked ? <AntDesign onPress={clickHandler} name='heart' style={styles.selected}/> : <AntDesign onPress={clickHandler} name='hearto' style={styles.icons}/>}
                        <Text style={{ fontSize: 16, fontFamily: 'poppinsRegular', color: 'rgba(35, 35, 35, 0.5)' }}>{props.voteCount}</Text>
                    </View>
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    boxShadow: {
        borderRadius: 8,
        // borderWidth: 0.3,
        backgroundColor: 'transparent',
        shadowColor: 'rgba(35, 35, 35, 0.2)',
        elevation: 6,
        marginHorizontal: 10,
        marginVertical: 8,
        paddingTop: 6
    },
    box: {
        borderRadius: 10,
        padding: 20,
    },
    name: {
        fontFamily: 'poppinsRegular',
        fontSize: 14,
        color: 'rgba(35, 35, 35, 0.5)'
    },
    title: {
        fontSize: 20,
        fontFamily: 'poppinsBold',
        justifyContent: 'flex-end',
        color: 'rgba(35, 35, 35, 0.9)'
    },
    line: {
        width: Dimensions.get('window').width * 0.3,
        height: Dimensions.get('window').height * 0.006,
        backgroundColor: '#00d05a',
        alignItems: 'flex-end',
        justifyContent: 'flex-start',
        alignSelf: 'flex-end',
    },
    description: {
        paddingHorizontal: 15,
        paddingVertical: 10
    },
    voting: {
        marginRight: 20,
        flexDirection: 'row',
        alignItems: 'center',
        alignSelf: 'flex-end',
        alignContent: 'stretch',
        padding: 5,
    },
    icons: {
        alignItems: 'center',
        marginHorizontal: 15,
        fontSize: 28,
        color: 'rgba(35, 35, 35, 0.5)',
    },
    selected: {
        alignItems: 'center',
        marginHorizontal: 15,
        fontSize: 28,
        color: 'red',
    }
});

export default IdeaDetail;