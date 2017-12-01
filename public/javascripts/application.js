
var placeSearch, autocomplete;

function initAutocomplete() {
  autocomplete = new google.maps.places.Autocomplete((document.getElementById('autocomplete')));
  autocomplete.addListener('place_changed', fillInAddress);
}

function fillInAddress() {
  // Get the place details from the autocomplete object.
  var place = autocomplete.getPlace();
  var lat = place.geometry.location.lat()
  var lng = place.geometry.location.lng()
  console.log(place)
  console.log(place.geometry.location.lat())
  console.log(place.geometry.location.lng())

}


function createMap(){
  // create a new map
  var myLatLng = {lat: -37.8, lng: 144.9};
  var mapOptions = {
      center: myLatLng,
      zoom: 15,
      mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var map = new google.maps.Map(document.querySelector("#map"), mapOptions);

  var marker = new google.maps.Marker({
    position: myLatLng,
    map: map,
    draggable: true
    // animation: google.maps.Animation.DROP 
  });
}