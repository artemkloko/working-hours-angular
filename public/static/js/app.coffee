define [
    'angular'
    'angular-ui-bootstrap'
    'js-data-angular'

    'cs!modules/core/core.client.controller'
    'cs!modules/entries/entries.client.controller'
], (ng) ->
    ng.module 'app', [
        'ui.bootstrap'
        'js-data'

        'core'
        'entries'
    ]