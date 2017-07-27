(function() {
  var _ = function(element) {
    u = {
      first: function() {
        return element[0];
      },
      last: function() {
        return element[element.length - 1];
      },
      without: function() {
        var result = element;
        var args = Array.prototype.slice.call(arguments);
        args.forEach(function(argument) {
          var temp = result.filter(function(item) {
            return item !== argument;
          });
          result = temp;
        });
        return result;
      },
      lastIndexOf: function(argument) {
        return element.lastIndexOf(argument);
      },
      sample: function(argument) {
        if (argument === undefined) {
          return element[Math.floor(Math.random() * element.length)];
        }
        var result = [];
        var elementArray = element;
        for (var i = 0; i < argument; i++) {
          var number = elementArray[Math.floor(Math.random() * elementArray.length)];
          elementArray = elementArray.splice(element.indexOf(number), 1);
          result.push(number);
        }
        return result;
      },
      findWhere: function(argument) {
        var match;
        element.some(function(obj) {
          var allMatch = true;
          for (var property in argument) {
            if (!(property in obj) || obj[property] !== argument[property]) {
              allMatch = false;
            }
          }
          if (allMatch) {
            match = obj;
            return true;
          }
        });
        return match;
      },
      where: function(argument) {
        var match = [];
        element.forEach(function(obj, idx) {
          var allMatch = true;
          for (var property in argument) {
            if (!(property in obj) || obj[property] !== argument[property]) {
              allMatch = false;
            }
          }
          if (allMatch) {
            match.push(element[idx]);
          }
        });
        return match;
      },
      pluck: function(argument) {
        var values = [];
        element.forEach(function(obj) {
          if (argument in obj) {
            values.push(obj[argument]);
          }
        });
        return values;
      },
      keys: function() {
        //return Object.keys(element);
        var keys = [];
        for (property in element) {
          keys.push(property);
        }
        return keys;
      },
      values: function() {
        //return Object.values(element);
        var values = [];
        for (property in element) {
          values.push(element[property]);
        }
        return values;
      },
      pick: function() {
        var newObject = {};
        var args = [].slice.call(arguments);
        args.forEach(function(propertyName) {
          if (element[propertyName]) {
            newObject[propertyName] = element[propertyName];
          }
        });
        return newObject;
      },
      omit: function() {
        var newObject = {};
        var args = [].slice.call(arguments);
        for (propertyName in element) {
          if (args.indexOf(propertyName) === -1) {
            //propertyName is not in argument list, include it
            newObject[propertyName] = element[propertyName];
          }
        }
        return newObject;
      },
      has: function(property) {
        var keys = Object.keys(element);
        return keys.indexOf(property) !== -1
        // return {}.hasOwnProperty.call(element, property)
      },
      /*
      isElement: function() {
        return _.isElement.call(u, element);
      },
      */
    };

    (["isElement", "isArray", "isObject", "isFunction", "isBoolean", "isString", "isNumber"]).forEach(function(method) {
      u[method] = function() { _[method].call(u, element); };
    });

    return u;
  };

  _.range = function(finish, start) {
    start = start || 0;
    var fullRange = Math.abs(finish - start);
    var result = [];
    if (Array.prototype.slice.call(arguments).length === 2) {
      for (var i = finish; i < (fullRange + finish); i++) {
        result.push(i);
      }
    } else {
      for (var i = 0; i < fullRange; i++) {
        result.push(i);
      }
    }
    return result;
  };

  _.extend = function() {
    var args = [].slice.call(arguments);
    var oldObject = args.pop();
    var newObject = args[args.length - 1];

    for (var property in oldObject) {
      newObject[property] = oldObject[property];
    }

    return args.length === 1 ? newObject : _.extend.apply(_, args);
    //Apply because args takes an array, call requires individual arguments
  };

  _.isElement = function(object) {
    return object && object.nodeType === 1;
  };

  _.isArray = Array.isArray || function(object) {
    return toString.call(object) === "[object Array]";
  };

  _.isObject = function(object) {
    var type = typeof object;
    return type ===  'function' || type === 'object' && !!object;
  };

  _.isFunction = function(object) {
    var type = typeof object;
    return type === 'function' && !!object;
  };

  (["Boolean", "String", "Number"]).forEach(function(method) {
    _["is" + method] = function(object) {
      return toString.call(object) === "[object " + method + "]";
    }
  });

  window._ = _;
})();