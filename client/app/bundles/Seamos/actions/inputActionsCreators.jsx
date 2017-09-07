import axios from 'axios';

import { UPDATE_INPUT, URL } from '../constants';

export const updateInput = (title, name, val) => ({
  type: UPDATE_INPUT,
  title,
  name,
  val
});

export const subscribeNewsletter = email => dispatch => {
  const subscription = {
    email
  };
  axios.post(`${URL}/suscriptions`, {
    subscription
  })
  .then(response => {
    console.log(response);
  })
  .catch(err => {
    console.log(err);
  });
};
