// Simple example of a React 'smart' component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import Polls from '../components/polls';
import { getPolls } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { polls } = state;
    return { polls };
};

const mapDispatchToProps = { getPolls };

class PollsContainer extends Component {
    componentWillMount() {
        this.props.getPolls();
    }

    changeOpc(val) {
        this.props.getPolls(val.target.value);
    }
    render() {
        return (
            <div id='poll-page'>
                <select name='' onChange={this.changeOpc.bind(this)}>
                    <option value='most-voted-first'> Más vistos</option>
                    <option value='less-voted-first'> Menos vistas</option>
                    <option value='newest-first'> Más nuevas</option>
                    <option value='oldest-first'> Más viejas</option>
                    <option value='nearest-closing-date'> Propuetas cercanas a cerrar</option>
                    <option value='farest-closing-date'> Propuestas más lejanas al cierre</option>
                </select>
                <Polls {...this.props} />
            </div>
        );
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux 'connected' version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(PollsContainer);
