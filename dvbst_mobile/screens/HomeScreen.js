import React from 'react'

import { StyleSheet, Text, View, SafeAreaView, TextInput, Dimensions, TouchableOpacity } from 'react-native';
import CountdownComponent from '../components/countdown';
import Voting from '../assets/undraw_voting_nvu7 1 (1).svg';

const HomeScreen = (props) => {
    return (
        <SafeAreaView style={styles.container}>
            <Text style={styles.title}>Voting <Text style={{color: '#00D05A'}}>Opens</Text> In</Text>
            <Voting
                style={styles.svg}
                width={Dimensions.get('window').width * 0.78}
                height={Dimensions.get('window').height * 0.40}
            />
            <CountdownComponent />
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        paddingHorizontal: 10,
        paddingTop: 40,
        backgroundColor: '#fff',
        justifyContent: 'center'
    },
    title:{
        color: '#2F313D', 
        fontFamily: 'poppinsRegular', 
        fontSize: 35,
        alignSelf: 'center'
    },
    svg: {
        alignSelf: 'center',
        marginRight: 15,
        marginBottom: 30
        // borderColor: '#000',
        // borderWidth: 0.5
    }
});

export default HomeScreen;