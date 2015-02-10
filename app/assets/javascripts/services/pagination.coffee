angular.module('snookerLeague').service 'pagination', ($http) ->

  @allData = []
  @data
  @totalEntries = 0
  @totalPages = 0
  @perPage = 1
  @page = 1
  @pageClass = []
  @prevClass = 'disabled'
  @nextClass = 'disabled'


  @initData = (data, perPage) ->
    @allData = data
    @perPage = perPage
    @totalEntries = data.length
    @totalPages = Math.ceil(data.length/@perPage)
    @pageClass = []
    @pageClass[0] = 'active'
    @page = 1

    @updateClasses()

    @data = data.slice(0, @perPage);

  @changePage = (page) ->
    if page > 0 && page <= @totalPages
      @page = page
      start = (page-1)*@perPage
      end = (page)*@perPage
      @pageClass = []
      @pageClass[page-1] = 'active'

      @updateClasses()

      @data = @allData.slice(start, end);
    else
      @data

  @sort = (sortBy, reverse) ->
    if reverse
      sortBy = '-' + sortBy
    @allData.sort(@dynamicSort(sortBy))

  @findWithId = (id) ->
    find = -1
    for thing, index in @allData
      if thing.id == id
        find = index
    @allData[find]

  @deleteWithId = (id) ->
    find = -1
    for thing, index in @allData
      if thing.id == id
        find = index
    @allData.splice(find, 1)

  @addOne = (data) ->
    @allData.push(data)

  @updateClasses = ->
    if @page > 1
      @prevClass = ''
    else
      @prevClass = 'disabled'

    if @page >= @totalPages
      @nextClass = 'disabled'
    else
      @nextClass = ''

  @dynamicSort = (property) ->
    sortOrder = 1
    if property[0] is "-"
      sortOrder = -1
      property = property.substr(1)
    (a, b) ->
      result = (if (a[property] < b[property]) then -1 else (if (a[property] > b[property]) then 1 else 0))
      result * sortOrder





  return
