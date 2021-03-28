const readline = require('readline')

function readStdin () {
  return new Promise((resolve, reject) => {
    const lines = []
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
      terminal: false
    })

    rl.on('line', line => { lines.push(line) })
    rl.on('close', _ => { resolve(lines) })
  })
}

module.exports = readStdin
