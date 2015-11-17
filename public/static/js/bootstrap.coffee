define [
    'require'
    'angular'
    'cs!app'
], (require, angular) ->

    require ['domReady!'], (document) ->
        angular.bootstrap document, ['app']