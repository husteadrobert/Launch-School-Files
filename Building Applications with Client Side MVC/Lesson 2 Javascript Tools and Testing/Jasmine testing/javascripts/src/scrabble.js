function Scrabble(word) {
  if (word === null || word.length <= 0) {
    return 0;
  }
  var score = 0;
  var letters = word.split('');
  letters.forEach(function(letter) {
    if (letter.match(/[aeioulnrst]/gi)) {
      score += 1;
    } else if (letter.match(/[dg]/gi)) {
      score += 2;
    } else if (letter.match(/[bcmp]/gi)) {
      score += 3;
    } else if (letter.match(/[fhvwy]/gi)) {
      score += 4;
    } else if (letter.match(/k/gi)) {
      score += 5;
    } else if (letter.match(/[jx]/gi)) {
      score += 8;
    } else {
      score += 10;
    }
  });
  return score;
}

