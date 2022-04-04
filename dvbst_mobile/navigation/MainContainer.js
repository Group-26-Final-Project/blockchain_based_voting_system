import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import Material from 'react-native-vector-icons/MaterialCommunityIcons';

// Screens
import HomeScreen from '../screens/HomeScreen';
import IdeasScreen from '../screens/IdeasScreen';
import VotingScreen from '../screens/VotingScreen';
import ResultScreen from '../screens/ResultScreen';

//Screen names
const homeName = "Home";
const ideaName = "Ideas";
const votingName = "Voting";
const resultName = "Results";

const Tab = createBottomTabNavigator();

function MainContainer() {
  return (
    <NavigationContainer>
      <Tab.Navigator
        initialRouteName={homeName}
        screenOptions={({ route }) => ({
          tabBarIcon: ({ focused, color, size }) => {
            let iconName;
            let rn = route.name;

            if (rn === homeName) {
              iconName = focused ? 'home' : 'home-outline';

            } else if (rn === resultName) {
              iconName = focused ? 'vote' : 'vote-outline';

            } else if (rn === votingName) {
              iconName = focused ? 'vote' : 'vote-outline';
            
            } else if (rn === ideaName) {
                iconName = focused ? 'lightbulb-on' : 'lightbulb-on-outline';
            }
            // You can return any component that you like here!
            return <Material name={iconName} size={size} color={color} />;
          },
          
          tabBarActiveBackgroundColor: '#242632', 
          tabBarInactiveBackgroundColor: '#242632', 
          tabBarActiveTintColor: '#fff',
          tabBarInactiveTintColor: '#ffffff87',
          tabBarLabelStyle: { paddingBottom: 10, fontSize: 10 },
          tabBarStyle: {height: 70},
          headerShown: false,
        })}>
            
        <Tab.Screen name={homeName} component={HomeScreen} />
        <Tab.Screen name={votingName} component={VotingScreen} />
        <Tab.Screen name={ideaName} component={IdeasScreen} />
        <Tab.Screen name={resultName} component={ResultScreen} />

      </Tab.Navigator>
    </NavigationContainer>
  );
}

export default MainContainer;