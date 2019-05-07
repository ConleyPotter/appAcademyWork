const APIUtil = require("./api_util.js");

class FollowToggle {
  constructor(el) {
    this.$el = $(el);
    const data = this.$el.data();
    this.userId = data.userId;
    this.followState = data.initialFollowState;
    this.render();
    this.handleClick();
  }

  render() {
    if (this.followState === 'unfollowed') {
      this.$el.text('Follow!');
      this.$el.prop("disabled", false);
    } else if (this.followState === 'followed'){
      this.$el.text('Unfollow!');
      this.$el.prop("disabled", false);
    } else if (this.followState === 'following') {
      this.$el.prop("disabled", true);
      this.$el.text("Following...")
    } else if (this.followState === 'unfollowing') {
      this.$el.prop("disabled", true);
      this.$el.text("Unfollowing...");
    }
  }

  handleClick() {                                         
    this.$el.click( (event) => {
      event.preventDefault();                      
      
      if (this.followState === 'unfollowed') {
        this.followState = 'following';
        this.render();
        APIUtil.followUser(this.userId).then(
          () => {
            this.followState = 'followed';
            this.render();
          },
          (error_message) => {
            console.log(error_message);
          });
      } else if (this.followState == 'followed') {
        this.followState = 'unfollowing';
        this.render();
        APIUtil.unfollowUser(this.userId).then(
          () => {
            this.followState = 'unfollowed';
            this.render();
          },
          (error_message) => {
            console.log(error_message);
          });
      }
    });
  }
}

module.exports = FollowToggle;