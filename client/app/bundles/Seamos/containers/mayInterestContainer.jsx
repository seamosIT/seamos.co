// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import MayInterest from '../components/mayInterest';
import { getMayInterestPolls } from '../actions';

const mapStateToProps = (state) => {
    const { mayInterestReducer } = state;
    return { mayInterestReducer };
};

const mapDispatchToProps = { getMayInterestPolls };

class MayInterestContainer extends Component {
    componentWillMount() {
      this.props.getMayInterestPolls();
    }

    render() {
      return(
        <div>
          <div className='row interest-banner one-mod'>
            Tambien te puede interesar
          </div>
          <MayInterest {...this.props} />
        </div>
      )
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(MayInterestContainer);