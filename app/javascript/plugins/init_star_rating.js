import "jquery-bar-rating";
import $ from 'jquery';

const initStarRating = () => {
  $('#feedback_rating').barrating({
    theme: 'css-stars'
  });
  $('#feedback_vet_rating').barrating({
    theme:'css-stars'
  });
  $('#feedback_friend_rating').barrating({
    theme: 'css-stars'
  })
};

export { initStarRating };
