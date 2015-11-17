define [
    'cs!./core.client.module'
    'cs!./format.client.services'
    'jquery'
    'bootstrap-datetimepicker'
], (moduleCore) ->

    moduleCore.directive 'eonasdan', [
        'format'
        (format) ->
            restrict: "A"
            require: 'ngModel'
            link: (scope, element, attrs, model) ->
                directiveFormat = if attrs.eonasdan is 'datepicker' then format.date else format.time
                $(element).datetimepicker
                    format: directiveFormat
                $(element).on 'dp.change', (e) ->
                    scope.$apply ->
                        model.$setViewValue e.date.format directiveFormat
    ]