/* eslint-disable no-unused-vars */
/* eslint-disable require-jsdoc */
export const fetchSearchGlyphys = function(searchTerm) {
  $.ajax({
    url: `http://api.giphy.com/v1/gifs/search?q=${searchTerm}&api_key=bIbJ1vRqV79Ggqq934nK4GlxMGzsDDSP
&limit=2`,
  }).then( (res) => {
    console.log(res);
  });
};


