const FollowToggle = require("./follow_toggle.js");
const UsersSearch = require("./users_search.js");

$(() => {
  const followToggleButton = $('.follow-toggle');
  followToggleButton.each( (idx, button) => {
    new FollowToggle(button);
  });

  const usersDisplay = $('.users-search');
  usersDisplay.each( (idx, ul) => {
    new UsersSearch(ul);
  });
});