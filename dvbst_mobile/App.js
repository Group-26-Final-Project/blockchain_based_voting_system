import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, SafeAreaView } from 'react-native';
import MainContainer from './navigation/MainContainer';

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <MainContainer/>
      <StatusBar style='auto'/>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
  },
});