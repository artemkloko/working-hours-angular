define [
    'cs!./core.client.module'
], (moduleCore) ->

    moduleCore.service 'modal', [
        '$uibModal'
        ($uibModal) ->
            modal =
                instance: null
                params: null
            api =
                params: -> modal.params || {}
                open: (params) ->
                    modal.params = params
                    modal.instance = $uibModal.open { templateUrl: params.partial }
                    if params.rendered?
                        modal.instance.rendered.then params.rendered
                    modal.instance.result
                resolve: (response) -> modal.instance.close response
                reject: (error) -> modal.instance.dismiss error
            api
    ]