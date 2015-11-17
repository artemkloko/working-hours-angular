libPath = '../../lib/'

requirejs.config({

    // alias libraries paths
    paths: {
        'jquery':                   libPath + 'jquery/dist/jquery.min',
        'domReady':                 libPath + 'requirejs-domready/domReady',
        'angular':                  libPath + 'angular/angular.min',
        'angular-ui-bootstrap':     libPath + 'angular-bootstrap/ui-bootstrap-tpls.min',
        'js-data':                  libPath + 'js-data/dist/js-data.min',
        'js-data-angular':          libPath + 'js-data-angular/dist/js-data-angular.min',
        'js-data-localstorage':     libPath + 'js-data-localstorage/dist/js-data-localstorage.min',
        'validate':                 libPath + 'validate/validate.min',
        'moment':                   libPath + 'moment/min/moment.min',
        'bootstrap-datetimepicker': libPath + 'eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min'
    },
    packages: [{
        name: 'cs',
        location: libPath + 'require-cs',
        main: 'cs'
    }, {
        name: 'coffee-script',
        location: libPath + 'coffeescript',
        main: 'extras/coffee-script'
    }],

    shim: {
        'jquery': {
            exports: 'jquery'
        },
        'angular': {
            exports: 'angular'
        },
        'angular-flash-alert': ['angular'],
        'angular-ui-bootstrap': ['angular']
    },

    // kick start application
    deps: ['cs!bootstrap']
});