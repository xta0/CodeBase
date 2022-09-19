import logo from './logo.svg';
import './App.css';
import {connect} from "react-redux"
import { Component } from 'react';
import Beers from './components/Beers';

class App extends Component {
  render() {
    console.log(this.props.name);
    return (
      <div className="App">
        <Beers />
      </div>
    );
  }
}




// select which piece of state we want to give to the app
export default connect(state => state.app)(App);
