define [
    'angular'
    'angular-mocks'
], (ng) ->
    describe 'parent-module-name, module-name module-type', ->

        beforeEach (done) ->
            # this.initialData = { key: 'value' }
            ng.mock.module 'app'
            # ng.mock.inject (moduleName) ->
            #     # initial actions on the module
            #     done()

        afterEach (done) ->
            # ng.mock.inject (moduleName) ->
            #     # cleaning actions on the module
            #     done()

        it 'should be able to do something', (done) ->
            # ng.mock.inject (moduleName) ->
            #     # context
            #     # action
            #     # accertions
            #     done()