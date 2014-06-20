@DashboardController = ($scope, $routeParams, $location, $http,  User) ->
  $scope.init = ->
    @listsService = new User(serverErrorHandler)
    $scope.lists = @listsService.all()

  $scope.per_page = 2

  $scope.pageChanged = ->
    @listsService = new User(serverErrorHandler)
    current_page = $scope.lists.current_page
    $http.get("./user/query_page/#{current_page}.json").success((data) ->
      console.log('successfully')
    ).error( ->
      console.error('failed')
    )


  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again")

