define [
    'cs!./core.client.module'
], (moduleCore) ->

    moduleCore.value 'format',
        date: 'D MMMM YYYY'
        time: 'HH:mm'
        dateEg: '17 November 1973'
        timeEg: '23:45'