var allTestFiles = [];
var TEST_REGEXP = /(spec|test)\.coffee$/i;

// Get a list of all the test files to include
Object.keys(window.__karma__.files).forEach(function(file) {
     if (TEST_REGEXP.test(file)) {
          // Normalize paths to RequireJS module names.
          // If you require sub-dependencies of test files to be loaded as-is (requiring file extension)
          // then do not normalize the paths
          // var normalizedTestModule = file.replace(/^\/base\/|\.coffee$/g, '');
          var normalizedTestModule = 'cs!' + file.replace(/\.coffee$/g, '');
          allTestFiles.push(normalizedTestModule);
     }
});

libPath = '/base/public/lib/'

require.config({
     // Karma serves files under /base, which is the basePath from your config file
     baseUrl: '/base/public/static/js',

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
          'bootstrap-datetimepicker': libPath + 'eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min',
          'angular-mocks':            libPath + 'angular-mocks/angular-mocks'
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

     // angular does not support AMD out of the box, put it in a shim
     shim: {
          'jquery': {
               exports: 'jquery'
          },
          'angular': {
               exports: 'angular'
          },
          'angular-flash-alert': ['angular'],
          'angular-ui-bootstrap': ['angular'],
          'angular-mocks': ['angular']
     },

     // kick start application
     deps: ['cs!bootstrap'].concat(allTestFiles),

     // we have to kickoff jasmine, as it is asynchronous
     callback: window.__karma__.start
});
