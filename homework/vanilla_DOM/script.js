document.addEventListener('DOMContentLoaded', () => {
  // toggling restaurants

  const toggleLi = (e) => {
    const li = e.target;
    if (li.className === 'visited') {
      li.className = '';
    } else {
      li.className = 'visited';
    }
  };

  document.querySelectorAll('#restaurants li').forEach((li) => {
    li.addEventListener('click', toggleLi);
  });
  // adding SF places as list items

  // --- your code here!
  const addNewplace = (e) => {
    e.preventDefault();

    const formSubmit = document.querySelector('.favorite-input');
    const placeName = formSubmit.value;
    formSubmit.value = '';

    // get the ul of sf-places
    const ul = document.getElementById('sf-places');
    // create an li element
    const li = document.createElement('li');
    // set the text of the li to be the value inputted
    li.textContent = placeName;

    ul.appendChild(li);
  };

  const favoritePlaceInput = document.querySelector('.favorite-submit');
  favoritePlaceInput.addEventListener('click', addNewplace);
  // adding new photos

  // --- your code here!
  const togglePhotoButton = (e) => {
    e.preventDefault();
    const formWrapper = document.querySelector('.photo-form-container');
    if (formWrapper.className === 'photo-form-container') {
      formWrapper.className = 'photo-form-container hidden';
    } else {
      formWrapper.className = 'photo-form-container';
    }
  };

  const toggleButton = document.querySelector('.photo-show-button');
  toggleButton.addEventListener('click', togglePhotoButton);

  const photoSubmitHandler = (e) => {
    e.preventDefault();

    const photoURLInput = document.querySelector('.photo-url-input');
    const photoPath = photoURLInput.value;
    photoURLInput.value = '';

    const newImg = document.createElement('img');
    newImg.src = photoPath;

    const newPhotoLi = document.createElement('li');
    newPhotoLi.appendChild(newImg);

    const dogPhotosUl = document.querySelector('.dog-photos');
    dogPhotosUl.appendChild(newPhotoLi);
  };

  const photoButton = document.querySelector('.photo-url-submit');
  photoButton.addEventListener('click', photoSubmitHandler);
});
