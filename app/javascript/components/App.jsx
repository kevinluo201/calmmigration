



import React, { useState, useEffect } from "react";


const App = () => {
  const [rounds, setRounds] = useState([]);

  const fetchRounds = async () => {
    try {
      const response = await fetch('/trends.json');
      if (!response.ok) {
        throw new Error('Network response was not ok.');
      }
      const data = await response.json();
      setRounds(data);
    } catch (error) {
      console.log('An error occurred while fetching the data.');
    }
  }

  // fetch the data after this component is mounted
  // useEffect(() => {
  //   fetchRounds();
  // }, []);

  return (
    <div>
      <h3>Rounds Number: {rounds.length}</h3>
      <button class="button is-success" onClick={fetchRounds}>Fetch</button>
    </div>
  );
};

export default App;