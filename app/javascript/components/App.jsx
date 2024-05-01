import React, { useState, useEffect } from "react";
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, CartesianGrid, ResponsiveContainer } from 'recharts';
import 'bulma/css/bulma.css';


const App = () => {
  const [rounds, setRounds] = useState([]);
  const [selectedYear, setSelectedYear] = useState(new Date().getFullYear());
  const [selectedName, setSelectedName] = useState("");

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

  
  const filterDataByYearAndName = (year, name) => {
    setSelectedYear(year);
    setSelectedName(name);
  }

  // Filtered data based on selected year and name
  //const filteredData = selectedYear ? rounds.filter(item => new Date(item.draw_at).getFullYear() === selectedYear) : rounds;

  const filteredData = rounds.filter(item => {  
    return !selectedYear || new Date(item.draw_at).getFullYear() === selectedYear 
  }).filter(item => {  
    return !selectedName || item.name.startsWith(selectedName);  
  });

  //a function to display the message when there is no data
  const renderNoDataMessage = () => {
    if(!filteredData.length && selectedYear !== null && selectedName !== null){
      return <p className="has-background-danger-85 has-text-white p-3 box is-rounded">No data available for the selected year and name.</p>
    }
    return null;
  }

  // fetch the data after this component is mounted
  useEffect(() => {
    fetchRounds();
  }, []);

  return (
      <div className="mt-3 container is-fluid">
      <div className="column">
      <h3 className="has-text-weight-semibold is-size-4 mb-3 block">Rounds Number: {rounds.length}</h3>
      {/*<button class="button is-success" onClick={fetchRounds}>Fetch</button>*/}

      {/* dropdown menu to select year */}
      <div className="mb-2 select is-small block mr-3">
      <select value={selectedYear} onChange={(event) => filterDataByYearAndName(parseInt(event.target.value), selectedName)}>
        <option value="">All Years</option>
        {/* Extract unique years from data */}
        {Array.from(new Set(rounds.map(item => new Date(item.draw_at).getFullYear()))).map(year => (<option key={year} value={year}>{year}</option>))}
      </select>
      </div>
      {/* dropdown menu to select name */}
      <div className="mb-4 select is-small block">
      <select value={selectedName} onChange={(event) => filterDataByYearAndName(selectedYear, event.target.value)}>
        <option value="">All Names</option>
        {/* Extract unique names from data */}
        {Array.from(new Set(rounds.map(item => item.name.replace(/\([^)]*\)/g, '')))).map(name => (
          <option key={name} value={name}>{name}</option>
        ))}
      </select>
      </div>
      
      {renderNoDataMessage()}
      </div>
      {/* show time and size in bar chart */}
      <ResponsiveContainer width="95%" height={500}>
      <BarChart data={filteredData} /*margin={{ top: 50, right: 30, left: 50, bottom: 50 }}*/>
      <CartesianGrid vertical={false} stroke="#ccc" fill="#A7E9F5" fillOpacity={0.3} />
      <XAxis dataKey="draw_at" stroke="#8884d8" style={{ fill: '#4D4D4D' }} tickFormatter={(value) => new Date(value).toISOString().split('T')[0]} />{/*Format date to show only date part*/}
      <YAxis />
      <Tooltip labelStyle={{ color: '#4D4D4D' }} itemStyle={{ color: '#4D4D4D' }}  wrapperStyle={{ width: "auto", backgroundColor: '#ccc'}} cursor={{fill: '#FFD0CC'}} labelFormatter={(value) => new Date(value).toISOString().split('T')[0]} 
      formatter={(value, name, props) => [`Number of People: ${value}`]}/>
      
      
      {/* <Legend width={100} wrapperStyle={{ top: 40, right: 20, backgroundColor: '#f5f5f5', border: '1px solid #d5d5d5', borderRadius: 3, lineHeight: '40px' }} /> */}
      {/* <CartesianGrid stroke="#ccc" strokeDasharray="5 5" /> */}
      <Bar dataKey="size" fill="#2EBFEA" barSize={25} activeBar={{fill: '#7AE9FF'}} />
      </BarChart>
      </ResponsiveContainer>
      </div>
      
  );
};

export default App;