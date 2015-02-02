module.exports = function(grunt) {

  grunt.initConfig({
    // Compile coffee to js and concat
    coffee: {
      compile: {
        files: {
          'tests/compiled.js': ['tests/**/*.coffee'],
          'tests/app.js': ['app/assets/javascripts/**/*.coffee']
        }
      },
    },

    // Run qunit tests via phantomJS
    qunit: {
      all: {
        options: {
          urls: ['http://localhost:5001/tests/index.html'],
        }
      }
    },

    // Serve qunit html on port 5001 or next available port
    connect: {
      server: {
        options: {
          port: 5001,
          base: ['.', 'tests/'],
        }
      }
    },

    // Recompile & trigger livereload on file change
    watch: {
      scripts: {
        files: ['app/assets/javascripts/**/*.coffee', 'index.html', 'tests/**/*.coffee'],
        tasks: ['coffee'],
        options: {
          livereload: true,
        },
      },
    },
  });

  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-qunit');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');

  grunt.registerTask('default', ['coffee', 'connect', 'qunit']);
  grunt.registerTask('serve', ['coffee', 'connect', 'watch']);
};
