const today = Date.now()
const tomorrow = today + 86400000  // 1 day in milliseconds
const nextWeek = today + 604800000 // 7 days in milliseconds
const yesterday = today - 86400000

const books = [
  { done: false, title: 'The Majesty Of Vuejs', due: tomorrow }
]
const movies = [
]
const daily = [
  { done: true,  title: 'clean laptop display', due: yesterday },
  { done: false, title: 'clean cat toilet', due: yesterday },
  { done: false, title: 'buy bananas', due: today },
  { done: false, title: 'make travel plans', due: nextWeek }
]

export const boards = [
  { name: 'daily', tasks: daily },
  { name: 'books', tasks: books },
  { name: 'movies', tasks: movies }
]
