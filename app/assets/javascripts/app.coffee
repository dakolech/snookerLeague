app = angular.module('snookerLeague',[
  'flash',
  'ngDialog'
])

app.config [
  "$httpProvider"
  ($httpProvider) ->
    $httpProvider.defaults.transformResponse.push (responseData) ->
      convertDateStringsToDates responseData
      responseData

]

convertDateStringsToDates = (input) ->

  # Ignore things that aren't objects.
  return input  if typeof input isnt "object"
  for key of input
    continue  unless input.hasOwnProperty(key)
    value = input[key]
    match = undefined

    # Check for string properties which look like dates.
    if typeof value is "string" and (match = value.match(regexIso8601))
      milliseconds = Date.parse(match[0])
      input[key] = new Date(milliseconds)  unless isNaN(milliseconds)

      # Recurse into object
    else convertDateStringsToDates value  if typeof value is "object"
  return
regexIso8601 = /^(\d{4}|\+\d{6})(?:-(\d{2})(?:-(\d{2})(?:T(\d{2}):(\d{2}):(\d{2})\.(\d{1,})(Z|([\-+])(\d{2}):(\d{2}))?)?)?)?$/

app.filter "unique", ->
  (items, filterOn) ->
    return items  if filterOn is false
    if (filterOn or angular.isUndefined(filterOn)) and angular.isArray(items)
      hashCheck = {}
      newItems = []
      extractValueToCompare = (item) ->
        if angular.isObject(item) and angular.isString(filterOn)
          item[filterOn]
        else
          item

      angular.forEach items, (item) ->
        valueToCheck = undefined
        isDuplicate = false
        i = 0

        while i < newItems.length
          if angular.equals(extractValueToCompare(newItems[i]), extractValueToCompare(item))
            isDuplicate = true
            break
          i++
        newItems.push item  unless isDuplicate
        return

      items = newItems
    items

app.filter "joinBy", ->
  (input, delimiter) ->
    (input or []).join delimiter or ","

