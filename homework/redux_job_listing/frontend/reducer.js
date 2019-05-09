const initialState = {
  city: 'Please Select',
  jobs: [],
};

const reducer = (state = initialState, action) => {
  switch (action.type) {
    default:
      return state;
    case 'SWITCH_LOCATION':
      return {city: state.city, jobs: state.jobs};
  }
};

window.reducer = reducer;

export default reducer;

