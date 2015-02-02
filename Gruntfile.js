module.exports = function(grunt) {

  grunt.initConfig({
    qunit: {
      all: ['tests/*.html']
    },
    connect: {
      server: {
        options: {
          port: 5001,
          base: ['.', 'tests/'],
        }
      }
    },
    watch: {
      scripts: {
        files: 'tests/*.js',
        options: {
          livereload: true,
        },
      },
    },
  });


  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-qunit');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('default', ['qunit']);
  grunt.registerTask('serve', ['connect', 'watch']);
};
