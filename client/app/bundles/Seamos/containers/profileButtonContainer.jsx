// Simple example of a React "smart" component
import React, { Component } from 'react';
import { withRouter } from 'react-router-dom';
import ProfileButton from '../components/profile/profileButton';

class ProfileButtonContainer extends Component {
    goToProfile() {
        this.props.history.push('/profile');
    }
    render() {
        return (<ProfileButton 
            action={this.goToProfile.bind(this)}
            className={'btn-profile'}
            name={'Perfíl'}
        />);
    }
}

export default withRouter(ProfileButtonContainer);
