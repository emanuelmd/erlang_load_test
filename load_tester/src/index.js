const { performRandomAction } = require('./action');
const { sleepFor, range } = require('./utils');

const interval = 1;

async function main() {

  let iteration = 0;

  while (true) {
    console.log('Iteration', iteration);

    await performRandomAction();
    await sleepFor(interval);

    iteration++;
  }
}

main();
