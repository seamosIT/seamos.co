import configureMockStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import axios from 'axios';
import moxios from 'moxios';

import * as actions from '../../app/bundles/Seamos/actions';
import { UPDATE_TAGS, URL } from '../../app/bundles/Seamos/constants';
import { tagsMock } from '../__mocks__/tags';

const middlewares = [thunk];
const mockStore = configureMockStore(middlewares);

describe('users actions, sync', () => {
  it('should update tags state', () => {
    const expectedAction = { type: UPDATE_TAGS };
    expect(actions.updateTags()).toEqual(expectedAction);
  });
});

describe('users actions, async', () => { 
  beforeEach(() => moxios.install()); 
  afterEach(() => moxios.uninstall());
  it('get tags from API', () => { 
    moxios.stubRequest(`${URL}/tags.json`, {
      status: 200, 
      response: { tags: tagsMock }
    });   
    const store = mockStore({ tags: [] }); 
    const expectedActions = [{ type: UPDATE_TAGS, tags: tagsMock }]; 
    return store.dispatch(actions.getTags())
      .then(() => {
        expect(store.getActions()).toEqual(expectedActions); 
      });  
  }); 
}); 
