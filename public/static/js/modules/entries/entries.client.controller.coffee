define [
    'angular'
    'cs!./entries.client.module'
    'cs!./entries.client.services'
    'cs!modules/core/modal.client.services'
    'cs!modules/core/flavored-message.client.services'
    'cs!modules/core/eonasdan.client.directives'
], (ng, moduleEntries) ->

    moduleEntries.controller 'EntriesController', [
        '$scope', 'Entries', 'sumEntriesDurations', 'modal', 'flavoredMessage'
        ($scope, Entries, sumEntriesDurations, modal, flavoredMessage) ->
            entriesCtrl = this

            entriesCtrl.order =
                selected: '_date'
                reverse: true
                by: (entry) ->
                    entry[entriesCtrl.order.selected]
                set: (value) ->
                    if entriesCtrl.order.selected == value
                        entriesCtrl.order.reverse = not entriesCtrl.order.reverse
                    else
                        entriesCtrl.order.selected = value
                        entriesCtrl.order.reverse = true
                    undefined

            entriesCtrl.find = ->
                Entries.findAll().then (entries) ->
                    entriesCtrl.entries = entries
                    entriesCtrl.duration = sumEntriesDurations(entries)
                    undefined

            entriesCtrl.openModalCreate = () ->
                modal.open
                    partial: "static/partials/entries/modal-create-entry.client.partial.html"
                .then (response) ->
                    entriesCtrl.entries.push response
                    flavoredMessage.set 'success'
                , ->
                    flavoredMessage.set 'cancel'

            entriesCtrl.openModalUpdate = (entry) ->
                modal.open
                    entryId: entry.id
                    partial: "static/partials/entries/modal-update-entry.client.partial.html"
                .then (response) ->
                    # no need to update the entry in entriesCtrl.entries, because of the modal
                    flavoredMessage.set 'success'
                , ->
                    flavoredMessage.set 'cancel'

            entriesCtrl.openModalRemove = (entry) ->
                modal.open
                    entryId: entry.id
                    partial: "static/partials/entries/modal-remove-entry.client.partial.html"
                .then (response) ->
                    # no need to remove the entry from entriesCtrl.entries, because of the modal
                    flavoredMessage.set 'success'
                , ->
                    flavoredMessage.set 'cancel'

            undefined
    ]

    moduleEntries.controller 'ModalEntryController', [
        '$scope', 'Entries', 'modal'
        ($scope, Entries, modal) ->
            entryCtrl = this
            entryCtrl.modal = modal

            entryCtrl.create = ->
                values = entryCtrl.entry

                Entries
                .create values
                .then modal.resolve
                .catch (errorResponse) ->
                    entryCtrl.errors = errorResponse
                    undefined

            entryCtrl.instantiateOne = ->
                entryCtrl.entry = Entries.createInstance().setToNow()
                undefined

            entryCtrl.update = ->
                values = entryCtrl.entry

                Entries
                .update modal.params().entryId, values
                .then modal.resolve
                .catch (errorResponse) ->
                    entryCtrl.errors = errorResponse
                    undefined

            entryCtrl.findOne = ->
                entryCtrl.entry = ng.copy Entries.get modal.params().entryId
                undefined

            entryCtrl.remove = ->
                Entries
                .destroy modal.params().entryId
                .then modal.resolve
                .catch (errorResponse) ->
                    entryCtrl.errors = errorResponse
                    undefined

            undefined
    ]