/* eslint no-undef: "off" */
const assert = require('assert')
const blockset = require('../../src/setter.js')

const bs = (lines) => blockset(lines, {})

describe('blockset', function () {
  describe('idempotent', function () {
    it('its for empty', function () {
      assert.deepEqual(bs([]), [])
    })
    it('is also for already blockset content', function () {
      input = [
        'a nice line and',
        'an even nicer 1'
      ]
      assert.deepEqual(bs(input), input)
    })
  })

  describe('blockset with defaults', function () {
    it('will add one space if necessary', function () {
      input = [
        'a nice line and',
        'another one that'
      ]
      expected = [
        'a  nice line and',
        'another one that'
      ]
      assert.deepEqual(bs(input), expected)
    })
  })
})
