/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports) {

	// Rethinkdb input binding
	var customShinyInputBinding = new Shiny.InputBinding();

	// An input binding must implement these methods
	$.extend(customShinyInputBinding, {
	  initialize: function(el) {
	    console.log("init", el.id);
	  },

	  find: function(scope) { // This returns a jQuery object with the DOM element
	    console.log("find",$(scope).find('.shiny-custom-input'));
	    return $(scope).find('.shiny-custom-input');
	  },
	  getId: function(el) { // return the ID of the DOM element
	    console.log(Shiny.InputBinding.prototype.getId.call(this, el));
	    console.log("getId");
	    return el.id;
	  },
	  getValue: function(el) { // Given the DOM element for the input, return the value
	    var value = $(el).val();
	    console.log('getvalue', value);
	    return JSON.stringify(value);
	  },
	  setValue: function(el, value) { // Given the DOM element for the input, set the value
	    console.log("setValue");
	    el.value = value;
	  },

	  // Set up the event listeners so that interactions with the
	  // input will result in data being sent to server.
	  // callback is a function that queues data to be sent to
	  // the server.
	  subscribe: function(el, callback) {
	    console.log('subscribe', el);
	    $(el).change(function () {
	      console.log("detected change");
	      callback(true);
	    })
	  },

	  // Remove the event listeners
	  unsubscribe: function(el) {
	    console.log("unsubscribe called");
	    $(el).off('.urlInputBinding');
	  },

	  // This returns a full description of the input's state.
	  // Note that some inputs may be too complex for a full description of the state to be feasible.
	  getState: function(el) {
	    console.log("getState called");
	    return {
	      value: el.value
	    };
	  },

	  // The input rate limiting policy
	  getRatePolicy: function() {
	    console.log("getRate called");
	    return {
	      // Can be 'debounce' or 'throttle'
	      policy: 'debounce',
	      delay: 500
	    };
	  }
	});

	Shiny.inputBindings.register(customShinyInputBinding, 'shiny.customShinyInput');



/***/ }
/******/ ]);