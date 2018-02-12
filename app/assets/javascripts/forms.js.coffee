$ ->
  $(".js-form input:visible[type=text], .js-form input:visible[type=email], .js-form textarea")
    .each (_, elm) ->
      elm = $(elm)
      if !elm.val()
        elm.addClass("empty")

