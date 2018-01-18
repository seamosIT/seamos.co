import React from 'react';
import { Link } from 'react-router-dom';
import FacebookLogin from '../containers/facebookLoginContainer';
import Tags from '../containers/tagsContainer';
import PollsPageContainer from '../containers/pollsPageContainer'

import Polls from '../containers/pollsFeatureContainer';
import Featured from '../containers/pollsPageContainer';
import InputContainer from '../containers/inputContainer';


const Home = ({ session, inputReducer, subscribeNewsletter, newsletterReducer }) => (
  <div id="homepage">
    <div className='background-container top'>
    </div>
    <div className="mid-container">
      <div className="left-col">
        <div className="title">
          <h1>Temas de Interés</h1>
        </div>
        <Tags />
      </div>
      <div className="right-col">
        <PollsPageContainer />
      </div>
    </div>
    <div className='background-container up-mid'>
      <div className='flex-container up-mid-text-container'>
        <div id='how-to-achieve'>
          ¿Cómo logramos <br />
          el cambio?
        </div>
      </div>
    </div>
    <div id="how-facts">
      <div className="how-fact">
        <span className="title"> Poder Ciudadano </span><br />
        Involucramos a los ciudadanos en procesos de decisión
        política para que hagan valer su voto en los espacios
        democráticos.
      </div>
      <div className="how-fact">
        <span className="title"> Compromiso Político </span><br />
        Vinculamos a los políticos para que se comprometan a
        acatar las decisiones de sus votantes.
      </div>
    </div>
    {/*<div className='newsletter-container'>
      <div className='newsletter'>
        <div className='title'>
          Suscríbete a nuestro newsletter
        </div>
        <InputContainer placeholder="correo" title="subscribe" name="newsletter"
          actionCreator={() => subscribeNewsletter(inputReducer.subscribe.newsletter)}
        />

      </div>
    </div>
    */}
  </div>
);

Home.propTypes = {
  // Home: PropTypes.array.isRequired
  // name: PropTypes.string.isRequired,
  // updateName: PropTypes.func.isRequired,
};

export default Home;
