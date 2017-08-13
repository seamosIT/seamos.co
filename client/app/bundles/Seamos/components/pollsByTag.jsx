import PropTypes from 'prop-types';
import React from 'react';
// import { ShareButtons, generateShareIcon } from 'react-share';
import Polls from './polls';
// import { PRODUCTION_URL } from '../constants';

// const shareUrl = `${PRODUCTION_URL}/${window.location.hash}`;
// const { FacebookShareButton } = ShareButtons;
// const FacebookIcon = generateShareIcon('facebook');

const PollsByTag = (props) => {
const { image, icon, name, color } = props.tag;
// const imgUrl = image;
// const shareDescription = `Opina en las propuestas de ${name}`;
// const title = `propuestas de ${name}`;
  return (
    <section id='polls-component'>
      <div
        className='background-container'
        style={{ backgroundColor: color }}
      >
        <img src={`${image}`} alt={name} />
        <div className='icon-name-wrapper'>
          <div className='tag-icon-container' style={{ display: 'none' }}>
            <img className='tag-icon' alt='tag icon' src={icon} />
          </div>
          <div className='tag-name'>
            <h1> {name} </h1>
          </div>
        </div>
      </div>
      <div className='polls-box'>
        {props.polls.length !== 0 ?
          <Polls {...props} /> :
          <h3> En el momento no hay propuestas abiertas a votación para este tema </h3>
        }
      </div>
    </section>
  );
};

PollsByTag.propTypes = {
  polls: PropTypes.array.isRequired
};

export default PollsByTag;
