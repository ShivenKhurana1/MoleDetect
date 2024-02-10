mport React, { useEffect, useState } from 'react';
import { View } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import Ionicons from 'react-native-vector-icons/Ionicons';
import * as eva from '@eva-design/eva';
import { ApplicationProvider } from '@ui-kitten/components';
import { ListCustomItemShowcase } from './pages/Home';
import CameraIcon from './pages/components/Camera';
import Details from './pages/Details';
import * as ImagePicker from 'expo-image-picker';
import { createStackNavigator } from '@react-navigation/stack';
import DiseaseDetails from './pages/DiseaseDetails';
import { AppRegistry, Platform } from "react-native";
import { registerRootComponent } from "expo";
import { name as appName } from "./app.json";
import { createNativeStackNavigator } from '@react-navigation/native-stack';

// registerRootComponent calls AppRegistry.registerComponent('main', () => App);
// It also ensures that whether you load the app in the Expo client or in a native build,
// the environment is set up appropriately
if (Platform.OS == "android") {
  registerRootComponent(App);
} else {
  AppRegistry.registerComponent('main', () => App);
}

const Tab = createBottomTabNavigator();
const Stack = createNativeStackNavigator();

function HomeScreen({ navigation }) {
  return (
    <View>
      <ListCustomItemShowcase navigation={navigation} />
    </View>
  );
}

function HomeContainer() {
  return (
    <Stack.Navigator>
      <Stack.Screen name='Home' component={HomeScreen} />
      <Stack.Screen name='Detail' component={DiseaseDetails} />
    </Stack.Navigator>
  );
}

export default function App() {
  const [image, setImage] = useState(null);

  useEffect(() => {
    if (image != null) {
      const formData = new FormData();
      formData.append('image', {
        uri: image,
        name: 'image.jpg',
        type: 'image/jpeg',
      });

      fetch('http://192.168.1.75:8000/classify', {
        method: 'POST',
        body: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      })
        .then((response) => response.json())
        .then((data) => {
          navigation.navigate('Detail', { disease: data });
        })
        .catch((error) => {
          console.error(error);
        });
    }
  }, [image]);

  const pickImage = async () => {
    let result = await ImagePicker.launchCameraAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: true,
      aspect: [4, 3],
      quality: 1,
    });

    if (!result.cancelled) {
      setImage(result.assets[0].uri);
    }
  };

  return (
    <ApplicationProvider {...eva} theme={eva.light}>
      <NavigationContainer>
        <Tab.Navigator
          screenOptions={({ route }) => ({
            tabBarIcon: ({ focused, color, size }) => {
              let iconName;

              if (route.name === 'Disease') {
                iconName = focused
                  ? 'ios-information-circle'
                  : 'ios-information-circle-outline';
              } else if (route.name === 'Founders') {
                iconName = focused ? 'ios-list' : 'ios-list-outline';
              }

              return <Ionicons name={iconName} size={size} color={color} />;
            },
            tabBarActiveTintColor: '#337cbd',
            tabBarInactiveTintColor: 'gray',
          })}
        >
          <Tab.Screen name="Disease" component={HomeContainer} options={{ headerShown: false }} />
          <Tab.Screen name="Founders" component={Details} />
        </Tab.Navigator>
        <CameraIcon onPress={pickImage} />
      </NavigationContainer>
    </ApplicationProvider>
  );
}
