
function sleepFor(ms) {
  return new Promise((resolve, _reject) =>
    setTimeout(() => resolve(), ms)
  )
}

function randomNumber(to) {
  return (Math.floor(Math.random() * 100) % to) + 1;
}

function range(n) {
  const result = [];

  for (let i = 0; i < n; i++) {
    result.push(i);
  }

  return result;
}

module.exports = {
  range,
  randomNumber,
  sleepFor,
}
