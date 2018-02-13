$ ->
  $(".js-form input:visible[type=text], .js-form input:visible[type=email], .js-form textarea")
    .each (_, elm) ->
      elm = $(elm)
      if !elm.val()
        elm.addClass("empty")

  initAutocomplete = ->
    input = document.getElementById('job_company_location')

    return if !input || input.length == 0
    
    searchBox = new (google.maps.places.SearchBox)(input)
    searchBox.addListener 'places_changed', ->
      places = searchBox.getPlaces()
      
      return if places.length == 0

  initAutocomplete()
