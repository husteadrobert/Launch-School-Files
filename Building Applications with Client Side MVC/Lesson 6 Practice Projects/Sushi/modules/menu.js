var path = require('path');
var fs = require('fs');
var file_path = path.resolve(path.dirname(__dirname), "data/menu.json");


module.exports = {
  __readFile: function() {
    return JSON.parse(fs.readFileSync(file_path, "utf8"));
  },

  get: function() {
    return this.__readFile();
  }
};
