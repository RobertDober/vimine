const intersperse = (parts, needed, idx) => {
  const gaps = 2 * parts.length - 1
  const filler = [parts[0]]
  for (const part of parts.slice(1)) {
    filler.push(" ")
    filler.push(part)
  }
  for (let i=0; i < needed; i++) {
    filler[(2*idx + 2*i + 1) % gaps] = "  "
  }
  return filler.join('')
}
const filler = (acc, [line, parts, needed], idx) => {
  if (needed === 0) { 
    acc.result.push(line)
  } else if (needed >= parts.length) {
    acc.result.push(line)
  } else {
    acc.result.push(intersperse(parts, needed, idx))
  }
  return acc
}
function blockset (lines, opts) {
  const result = lines
  const maxLen = lines.reduce((max, line) => Math.max(max, line.length), 0)
  const parts = lines.map(line => [line, line.split(/\s+/), maxLen-line.length])

  return parts.reduce(filler, {result: [], opts: opts}).result
}

module.exports = blockset
