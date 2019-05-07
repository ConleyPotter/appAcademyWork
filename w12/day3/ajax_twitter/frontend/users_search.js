const APIUtil = require("./api_util.js");

class UsersSearch {
  constructor(el) {
    this.$el = $(el);
    this.inputTag = $(this.$el.children()[0]);
    this.ulTag = $(this.$el.children()[1]);
    this.handleInput();
  } 

  handleInput() {
    this.inputTag.on('input', (event) => {
      const queryString = this.inputTag.value;
      const users = APIUtil.searchUsers(queryString);
      // users is an ajax response
    });
  }

  renderResults(users) {
    this.ulTag.empty();
    debugger
  }
}

module.exports = UsersSearch;