import React from 'react';
import { createRoot } from 'react-dom/client';
import TrendsApp from '../components/TrendsApp';

// Render your React component instead
const root = createRoot(document.getElementById('app'));
if (root) {
  root.render(<TrendsApp />);
}