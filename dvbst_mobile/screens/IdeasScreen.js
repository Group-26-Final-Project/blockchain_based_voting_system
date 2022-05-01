import React from 'react'

import { StyleSheet, SafeAreaView, ScrollView, View, Text, Button } from 'react-native';
import { FAB } from 'react-native-elements';
import IdeaDetail from '../components/IdeaDetail';
import SearchBar from '../components/searchbar';
import SearchFilter from '../components/searchFilter';
import { MaterialIcons } from "@expo/vector-icons";
import { useIdeasQuery } from '../services/ideasApi';
import { useNavigation } from '@react-navigation/native';

const IdeasScreen = (props) => {
    const navigation = useNavigation();
    const { data, error, isError, isLoading, isSuccess } = useIdeasQuery();
    console.log(data, error)
    return (
        <SafeAreaView style={{flex: 1}}>
            {isLoading && (
                <View style={{flex: 1, justifyContent:'center', alignItems: 'center'}}>
                 <Text style={styles.text}> Loading... </Text>
              </View>
            )}
            {isError && (
                <View style={{flex: 1, justifyContent:'center', alignItems: 'center'}}>
                 <Text style={styles.text}>Ooops something went wrong</Text>
                 <Button title="Refresh">Refresh</Button>
              </View>
            )}
            {isSuccess && (
                <View style={styles.container}>
                    <SearchBar />
                    <SearchFilter />
                    <ScrollView>
                        {data.map((idea) => (
                            <IdeaDetail
                                key={idea._id}
                                userName={idea.username}
                                title={idea.title}
                                description={idea.description}
                                voteCount={idea.voteCount}
                            />
                        ))}
                    </ScrollView>
                </View>
            )}
            <FAB onPress={() => navigation.navigate("Suggestion")} size='large' color='#00d05a' placement='right' icon={<MaterialIcons color='white' name='add' size={20} />} />
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        paddingHorizontal: 10,
        paddingTop: 40,
        backgroundColor: '#fff',
        flex: 1
    }
});
export default IdeasScreen;