jQuery ->
  $('#material_search').autocomplete(
    source: "/materials/autocomplete",
    minLength: 2
  )
