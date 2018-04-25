import React, { Component } from 'react';
import { connect } from 'react-redux';
import FacebookLogin from 'react-facebook-login';
import { APP_ID } from '../constants';

import { validateUserSession, validateSession } from '../actions';


const mapDispatchToProps = { validateUserSession, validateSession };

class FacebookLoginContainer extends Component {
  constructor(props) {
    super(props);
    this.responseFacebook = this.responseFacebook.bind(this);
  }

  responseFacebook(fbUser) {
    if (fbUser.status !== 'unknown') {
      this.props.validateUserSession(fbUser)
      .then(() => {
        this.props.validateSession();  
      });
    }
  }

  render() {
    return (
      <FacebookLogin
        textButton={this.props.fbText || 'Login'}
        appId={APP_ID}
        autoLoad={false}
        scope='user_location, email'
        fields="id,location,first_name,last_name, email,picture.width(100)"
        callback={(fbUser) => this.responseFacebook(fbUser)}
        cssClass={this.props.fbclassName || 'my-facebook-button-class'}
        disableMobileRedirect
      />
    );
  }
}

export default connect(null, mapDispatchToProps)(FacebookLoginContainer);
