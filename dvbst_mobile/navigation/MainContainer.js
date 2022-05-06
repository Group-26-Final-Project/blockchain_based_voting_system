import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createStackNavigator } from '@react-navigation/stack'
import Material from 'react-native-vector-icons/MaterialCommunityIcons';

// Screens
import HomeScreen from '../screens/HomeScreen';
import IdeasScreen from '../screens/IdeasScreen';
import SuggestionScreen from '../screens/SuggestIdeaScreen';
import VotingScreen from '../screens/VotingScreen';
import ResultScreen from '../screens/ResultScreen';
import CandidatesScreen from '../screens/CandidateScreen';

//Screen names
const homeName = "Home";
const ideaName = "Ideas";
const suggestName = "Suggestion";
const votingName = "Voting";
const resultName = "Results";
const candidateName = "Candidates";

const Tab = createBottomTabNavigator();
const Stack = createStackNavigator();

function VotingStack() {
  return (
    <Stack.Navigator
      initialRouteName={votingName}
      screenOptions={{
        headerTitle: "",
        headerTransparent: true
      }}
    >
      <Stack.Screen
        name={votingName}
        component={VotingScreen}
      />
      <Stack.Screen
        name={candidateName}
        component={CandidatesScreen}
      />
    </Stack.Navigator>
  )
}

function IdeaStack() {
  return (
    <Stack.Navigator
      initialRouteName={ideaName}
      screenOptions={{
        headerTitle: "",
        headerTransparent: true
      }}
    >
      <Stack.Screen
        name={ideaName}
        component={IdeasScreen}
      />
      <Stack.Screen
        name={suggestName}
        component={SuggestionScreen}
      />
    </Stack.Navigator>
  )
}


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
          tabBarStyle: { height: 70 },
          headerShown: false,
        })}>

        <Tab.Screen name={homeName} component={HomeScreen} />
        <Tab.Screen name={votingName} component={VotingStack} />
        <Tab.Screen name={ideaName} component={IdeaStack} />
        <Tab.Screen name={resultName} component={ResultScreen} />

      </Tab.Navigator>
    </NavigationContainer>
  );
}

export default MainContainer;