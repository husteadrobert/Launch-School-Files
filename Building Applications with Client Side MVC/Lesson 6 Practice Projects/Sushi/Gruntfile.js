module.exports = function(grunt) {
  grunt.initConfig({
    uglify: {
      my_target: {
        files: {
          //Gotten from bower_concat, then overwrites
          "public/javascripts/vendor/all.js": ["public/javascripts/vendor/all.js"]
        }
      }
    },
    bower_concat: {
      all :{
        dest: "public/javascripts/vendor/all.js",
        dependencies: {
          "underscore": "jquery",
          "backbone": "underscore"
        }
      }
    },
    handlebars: {
      all: {
        files: {
          "public/javascripts/handlebarsTemplates.js": ["handlebars/**/*.hbs"]
        },
        options: {
          processContent: removeWhitespace,
          processName: extractFileName
        }
      }
    }
  });

  //Load NPM Tasks
  [
    "grunt-bower-concat",
    "grunt-contrib-uglify",
    "grunt-contrib-handlebars"
  ].forEach(function(task) {
    grunt.loadNpmTasks(task);
  });

  //Register Default task
  grunt.registerTask("default", ["bower_concat", "uglify"]);
};

//To Remove Leading and Trailing Whitespace from Templates
function removeWhitespace(template) {
  return template.replace(/ {Z,}/mg, "").replace(/\r|\n/mg, "");
}

//This finds file name from \filename.hbs, pops off the result, stores it in JST
function extractFileName(file) {
  return file.match(/\/(.+)\.hbs$/).pop();
}