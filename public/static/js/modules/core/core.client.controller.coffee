define [
    'cs!./core.client.module'
    'cs!./message.client.services'
    'cs!./flavored-message.client.services'
], (moduleCore) ->

    moduleCore.controller 'HomeController', [
        'message', 'flavoredMessage'
        (message, flavoredMessage) ->
            homeCtrl = this
            homeCtrl.message = message
            homeCtrl.flavoredMessage = flavoredMessage

            homeCtrl.greet = ->
                flavoredMessage.set 'greeting'

            undefined
    ]