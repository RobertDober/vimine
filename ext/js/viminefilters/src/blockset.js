
const { program } = require('commander')
const readStdin = require('./read_stdin.js')
const blockset = require('./setter.js')

async function run (args) {
  program.version('0.1.0')
  program
    .option('-w, --wrap', 'rearrange lines if necessary into lines')
    .option('-p, --prefix <RGX>', 'remove prefix, blockset and add prefx back again')
  const opts = program.parse(args).opts()

  const lines = await readStdin()
  const result = blockset(lines, opts)
  for (const line of result) { console.log(line) }
}

module.exports.run = run
