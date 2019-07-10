const { sleepFor, randomNumber, range } = require('./utils');

const faker = require('faker')
const axios = require('axios');

const http = axios.create({
  baseURL: 'http://localhost:4000/api/v1',
  validateStatus: () => true
})

const listNames = range(10)
  .map(() => faker.name.firstName());

function getRandomListName() {
  return listNames[randomNumber(9)];
}

async function createEntity() {
  const payload = {
    title: faker.name.title(),
    date: faker.date.past()
  };

  const listName = getRandomListName();

  return http.post(`todo/${listName}`, payload);
}

async function fetchList() {
  return http.get(
    `todo/${getRandomListName()}`
  );
}

async function fetchSpecific() {
  return http.get(
    `todo/${getRandomListName()}/${randomNumber(100)}`
  );
}

async function performRandomAction() {
  try {
    switch (randomNumber(3)) {
      case 1:
        return createEntity();
      case 2:
        return fetchList();
      case 3:
        return fetchSpecific();
    }
  } catch (err) {
    console.error('Error: ', err);
  }
}

module.exports = {
  performRandomAction
}
