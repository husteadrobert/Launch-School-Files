var $message = $('#message');
var $word = $('#spaces');
var $apples = $('#apples');
var $guess = $('#guesses');
var $replay = $('p + p');

var randomWord = function() {
  var wordList = ["dog", "cat", "javascript", "monkey"]
  return function() {
    if (wordList.length <= 0) {
    return undefined;
  }
  var word = wordList[Math.floor(Math.random() * wordList.length)];
  var index = wordList.indexOf(word);
  wordList.splice(index, 1);
  return word
  }
}();


function Game() {
  this.word = randomWord();
  if (this.word === undefined) {
    console.log('uh oh');
    $message.text("Sorry, I've run out of words!");
    return;
  }
  this.incorrectGuesses = 0;
  this.correctGuesses = 0;
  this.guessHistory = [];
  this.maxGuesses = 6;
  this.reset();
  this.createBlanks();
  this.bind();
};

Game.prototype = {
  createBlanks: function() {
    $word.find('span').remove();
    var size = this.word.length;
    for (var i = 0; i < size; i++) {
      var el = "<span></span>";
      $word.append(el);
    }
  },
  bind: function() {
    $(document).on('keypress', this.guessLetter.bind(this));
  },
  reset: function() {
    $('body').removeClass();
    $apples.removeClass();
    $guess.find('span').remove();
    $message.hide();
    $replay.hide();
  },
  guessLetter(e) {
    var letter = String.fromCharCode(e.which);
    if (!isLetter(e.which) || this.guessHistory.indexOf(letter) !== -1) {
      return;
    }
    this.updateHistory(letter);
    this.updateGuesses(letter);
    //Check the Guess
    if (this.correctGuess(letter)) {
      this.updateSpaces(letter);
    } else {
      this.incrementGuesses();
      this.updateApples();
    }
    //Check if Win or Lost

    if (this.incorrectGuesses === this.maxGuesses) {
      $(document).unbind('keypress');
      $('body').addClass('lose');
      $message.show().text("You've Lost");
      $replay.show();
    }
    if (this.wordFilled()) {
      $(document).unbind('keypress');
      $('body').addClass('win');
      $message.show().text("You've Won!");
      $replay.show();
    }
  },
  updateHistory(letter) {
    this.guessHistory.push(letter);
  },
  updateGuesses(letter) {
    var el = "<span>" + letter + "</span>";
    $guess.append(el);
  },
  updateApples() {
    $apples.removeClass();
    $apples.addClass('guess_' + this.incorrectGuesses);
  },
  wordFilled() {
    var allFilled = true;
    var $spans = $('#spaces span');
    $spans.each(function(span) {
      if ($(this).text() === "") {
        allFilled = false;
      }
    })
    return allFilled;
  },
  incrementGuesses(correct) {
    this.incorrectGuesses += 1;
  },
  correctGuess(letter) {
    return this.word.indexOf(letter) !== -1;
  },
  updateSpaces(letter) {
  var $spans = $('#spaces span');
    for (var i = 0; i < this.word.length; i++) {
      if (this.word[i] === letter) {
        $spans.eq(i).text(letter);
      }
    }
  },
};
Game.prototype.constructor = Game;

function isLetter(code) {
  if (code >= 97 && code <= 122) {
    return true;
  } else {
    return false;
  }
}

new Game();

$('#replay').on('click', function(e) {
  e.preventDefault();
  new Game();
});