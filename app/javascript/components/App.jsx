import React, { useState, useEffect } from "react";
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, CartesianGrid } from 'recharts';

const App = () => {
  const [rounds, setRounds] = useState([]);
  const [selectedYear, setSelectedYear] = useState(null);
  const [selectedName, setSelectedName] = useState(null);

  const fetchRounds = async () => {
    try {
      const response = await fetch('/trends.json');
      if (!response.ok) {
        throw new Error('Network response was not ok.');
      }
      const data = await response.json();
      console.log(data);
      setRounds(data);
    } catch (error) {
      console.log('An error occurred while fetching the data.');
    }
  }

  // Filter data based on selected year and name
  const filterDataByYearAndName = (year, name) => {
    setSelectedYear(year);
    setSelectedName(name);
  }

  // Filtered data based on selected year and name
  //const filteredData = selectedYear ? rounds.filter(item => new Date(item.draw_at).getFullYear() === selectedYear) : rounds;
  const filteredData = rounds.filter(
    item => {
      const yearMatch = !selectedYear || new Date(item.draw_at).getFullYear() === selectedYear;
      const nameMatch = !selectedName || item.name === selectedName;
      return yearMatch && nameMatch;
    }
  );

  //a function to display the message when there is no data
  const renderNoDataMessage = () => {
    if(!filteredData.length && selectedYear !== null && selectedName !== null){
      return <p>No data available for the selected year and name.</p>
    }
    return null;
  }

  // fetch the data after this component is mounted
  // useEffect(() => {
  //   fetchRounds();
  // }, []);

  return (
      <div>
      <h3>Rounds Number: {rounds.length}</h3>
      <button class="button is-success" onClick={fetchRounds}>Fetch</button>

      {/* dropdown menu to select year */}
      <select onChange={(event) => filterDataByYearAndName(parseInt(event.target.value), selectedName)}>
        <option value="">All Years</option>
        {/* Extract unique years from data */}
        {Array.from(new Set(rounds.map(item => new Date(item.draw_at).getFullYear()))).map(year => (<option key={year} value={year}>{year}</option>))}
      </select>

      {/* dropdown menu to select name */}
      <select onChange={(event) => filterDataByYearAndName(selectedYear, event.target.value)}>
        <option value="">All Names</option>
        {/* Extract unique names from data */}
        {Array.from(new Set(rounds.map(item => item.name))).map(name => (
          <option key={name} value={name}>{name}</option>
        ))}
      </select>

      {renderNoDataMessage()}

      {/* show time and size in bar chart */}
      <BarChart width={1000} height={300} data={filteredData}>
      <XAxis dataKey="draw_at" stroke="#8884d8" tickFormatter={(value) => new Date(value).toISOString().split('T')[0]} />{/*Format date to show only date part*/}
      <YAxis />
      <Tooltip wrapperStyle={{ width: 100, backgroundColor: '#ccc' }} labelFormatter={(value) => new Date(value).toISOString().split('T')[0]} 
      formatter={(value, name, props) => [`Number of People: ${value}`]}/>

      {/* <Legend width={100} wrapperStyle={{ top: 40, right: 20, backgroundColor: '#f5f5f5', border: '1px solid #d5d5d5', borderRadius: 3, lineHeight: '40px' }} /> */}
      <CartesianGrid stroke="#ccc" strokeDasharray="3 3" />
      <Bar dataKey="size" fill="#8884d8" barSize={25}/>
      </BarChart>

      </div>
      
  );
};

export default App;