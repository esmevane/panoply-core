# Visitor browses services

A visitor discovers services by inputing a date, time, location and service type into a search prompt.  The matching results are displayed.  If there are no results, a new search prompt is displayed.

#### Some example code

```ruby
prompt = SearchPrompt.new date: Date.new, time: Time.new,
  location: '???', service: :massage

prompt.results
```

## Acceptance criteria

[ ] - If there are a dozen services and three results match, then results should only return those three results.
