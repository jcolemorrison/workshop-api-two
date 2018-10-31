'use strict'

const path = require('path')

const server = require(path.resolve(__dirname, '../../server.js'))
const { mysqlDb } = server.dataSources

const models = ['User', 'AccessToken', 'ACL', 'RoleMapping', 'Role', 'Client']

module.exports = function migrateBaseModels (app, next) {
  console.log('---\nBeginning Migration...')

  // are the models in sync with the DB?
  mysqlDb.isActual(models, (err, actual) => {
    if (err) throw err

    // log if they're in sync or not
    const syncStatus = actual ? 'in sync' : 'out of sync'

    console.log(`\nModels are ${syncStatus}`)

    if (actual) return next()

    console.log('Migrating Models...')

    // create hte tables and update them with any new/removed properties
    return mysqlDb.autoupdate(models, (err) => {
      if (err) throw err

      console.log('Models migration successful!\n')

      next()
    })
  })
}
