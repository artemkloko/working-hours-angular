define [
    'moment'
    'validate'
    'js-data-localstorage'
    'cs!./entries.client.module'
    'cs!modules/core/format.client.services'
], (moment, validate, DSLocalStorageAdapter, moduleEntries) ->

    moduleEntries.run ['DS', (DS) ->
        DS.registerAdapter 'localstorage', DSLocalStorageAdapter, { default: true }
    ]

    moduleEntries.factory 'Entries', ['DS', 'format', (DS, format) ->

        validate.validators.isDate = (value, options, key, attributes) ->
            if moment(value, format.date).isValid() then null else "must match \"#{format.date}\" format (eg. #{format.dateEg})"

        validate.validators.isTime = (value, options, key, attributes) ->
            if moment(value, format.time).isValid() then null else "must match \"#{format.time}\" format (eg. #{format.timeEg})"

        entrySchema =
            date: { presence: true, isDate: true }
            from: { presence: true, isTime: true }
            to: { presence: true, isTime: true }

        Entries = DS.defineResource
            name: 'entry'
            validate: (Entries, entry, cb) ->
                err = validate entry, entrySchema
                cb err, entry
            computed:
                _date: get: -> moment this.date, format.date
                _from: get: -> moment this.from, format.time
                _to: get: -> moment this.to, format.time
                _duration: get: ->
                    to = this._to
                    to = to.add 1, 'days' if to < this._from
                    moment.duration to.diff this._from
                duration: get: ->
                    duration = this._duration
                    hours: if duration.hours() > 0 then duration.hours() + ' hours' else ''
                    minutes: if duration.minutes() > 0 then duration.minutes() + ' minutes' else ''
            methods:
                setToNow: ->
                    this.date = moment().format format.date
                    this.from = moment().subtract(8, 'hours').format format.time
                    this.to = moment().format format.time
                    this
        Entries
    ]

    moduleEntries.value 'sumEntriesDurations', (entries) ->
        durations = entries.map (entry) -> entry._duration
        sum = durations.reduce (pv, cv) -> pv.add cv
        hours = sum.days() * 24 + sum.hours()

        hours: if hours > 0 then hours + ' hours' else ''
        minutes: if sum.minutes() > 0 then sum.minutes() + ' minutes' else ''