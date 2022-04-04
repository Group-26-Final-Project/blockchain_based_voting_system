import React, { useState } from 'react';

import { useFonts } from 'expo-font';

import AppLoading from 'expo-app-loading';
import { StyleSheet, Text, View, Dimensions, TouchableHighlight } from 'react-native';
import Icon from 'react-native-vector-icons/AntDesign';

const customFonts = {
    poppinsRegular: require('../assets/fonts/Poppins-Regular.ttf'),
    poppinsBold: require('../assets/fonts/Poppins-Bold.ttf'),
    poppinsSemi: require('../assets/fonts/Poppins-SemiBold.ttf'),
}
const IdeaDetail = (props) => {
    const [isLoaded] = useFonts(customFonts);
    const [vote, setVote] = useState(0);
    const [voteCount, setVoteCount] = useState(0);

    const upvote = () => {
        setVote(vote === 1 ? 0 : 1)
        if (vote === 1){
            setVoteCount(voteCount - 1);
        } else if (vote === 2){
            setVoteCount(voteCount + 2);
        } else {
            setVoteCount(voteCount + 1);
        }
    }

    const downvote = () => {
        setVote(vote === 2 ? 0 : 2);
        if (vote === 2){
            setVoteCount(voteCount + 1);
        } else if (vote === 1){
            setVoteCount(voteCount - 2);
        } else {
            setVoteCount(voteCount - 1);
        }
    }

    if (!isLoaded) {
        return <AppLoading />;
    } else {
        return (
            <View style={styles.boxShadow}>
                <View style={styles.box}>
                    <View>
                        <Text style={styles.name}>User03729173</Text>
                    </View>
                    <View style={{ alignSelf: 'flex-start' }}>
                        <Text style={styles.title}>Lorem Ipsum Dolor</Text>
                        <View style={styles.line}></View>
                    </View>
                    <View style={styles.description}>
                        <Text style={{ fontSize: 14, fontFamily: 'poppinsRegular' }}>
                            {`Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore `}
                        </Text>
                    </View>
                    <View style={styles.voting}>
                        <TouchableHighlight
                            onPress={() => upvote()}>
                            <Icon name='caretup'
                                style={[styles.icons, vote === 1 && styles.selected]} />
                        </TouchableHighlight>
                        <Text style={{ fontSize: 16, fontFamily: 'poppinsRegular', color: 'rgba(35, 35, 35, 0.5)' }}>{voteCount}</Text>
                        <TouchableHighlight
                            onPress={() => downvote()}>
                            <Icon name='caretdown' style={[styles.icons, vote === 2 && styles.selected]} />
                        </TouchableHighlight>
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
        color: '#00d05a',
    }
});

export default IdeaDetail;