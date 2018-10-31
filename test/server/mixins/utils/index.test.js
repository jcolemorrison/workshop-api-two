'use strict'

const { expect } = require('chai')

const utils = require('../../../../server/mixins/utils')

describe('Utility Functions', () => {
  describe('#updateTimestamps()', () => {
    it('should update `updatedAt` on an instance', () => {
      const context = {
        instance: {},
      }

      utils.updateTimestamps(context, () => {
        expect(context.instance.updatedAt).to.be.an.instanceof(Date)
      })
    })

    it('should update `updatedAt` on a batch updates', () => {
      const context = {
        data: {},
      }

      utils.updateTimestamps(context, () => {
        expect(context.data.updatedAt).to.be.an.instanceof(Date)
      })
    })
  })
})
