import React from "react";
import Clock from "./frontend/clock";
import Tabs from "./frontend/tabs";
import Weather from "./frontend/weather";
import Autocomplete from "./frontend/autocomplete";

const App = () => {
  return (
    <div>
      <Clock />
      <Tabs />
      <Weather />
      <Autocomplete names={
        ['Conley', 'Gordy', 'Rich', 'Lisa', 'Jasmine', 'JM', 'Oliver', 'Bryce', 'David']
      }/>
    </div>
  )
}

export default App;