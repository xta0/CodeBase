import logo from './logo.svg';
import './App.css';
import {connect} from "react-redux"
import { Component } from 'react';

class App extends Component {
  render() {
    console.log(this.props.name);
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <p>
            Edit <code>src/App.js</code> and save to reload.
          </p>
        </header>
      </div>
    );
  }
}




// select which piece of state we want to give to the app
export default connect(state => state.app)(App);
