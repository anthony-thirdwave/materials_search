PgSearch.multisearch_options = {
  using: {
    tsearch:    {dictionary: 'english'},
    trigram:    {threshold: 0.1}, # lower threshold gives more results for incorrect grammar
    dmetaphone: {}
  }
}
