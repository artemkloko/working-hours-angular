define [
    'cs!./core.client.module'
], (moduleCore) ->

    moduleCore.service 'message', [
        '$timeout'
        ($timeout) ->
            message =
                value: null
                isOpen: false
            api =
                isOpen: -> message.isOpen
                get: -> message.value || ''
                set: (value) ->
                    message.value = value
                    message.isOpen = true
                    undefined
            api
    ]