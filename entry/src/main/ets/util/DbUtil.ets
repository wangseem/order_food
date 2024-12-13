import { relationalStore, ValuesBucket } from '@kit.ArkData';
import { AsyncCallback, BusinessError } from '@kit.BasicServicesKit';
import Food from '../modle/Food';

class DbUtil {
  private STORE_CONFIG: relationalStore.StoreConfig = {
    name: "RdbTest.db",
    securityLevel: relationalStore.SecurityLevel.S1
  };
  private rdbStore?: relationalStore.RdbStore
  private TABLE_NAME = 'EMPLOYEE'
  private SQL_CREATE = `create table if not exists ${this.TABLE_NAME} (
        id integer primary key autoincrement,
        id_ text,
        name text,
        stock integer,
        price integer,
        des text,
        icon_id integer
      )`

  init(context: Context) {
    relationalStore.getRdbStore(context, this.STORE_CONFIG,
      (err: BusinessError, rdbStore: relationalStore.RdbStore) => {
        this.rdbStore = rdbStore
        rdbStore.executeSql(this.SQL_CREATE,
          (err) => {
            console.log(`zhu 创建数据库 err=${err}`)

          })
      })
  }

  // 新增单条
  async insert(value: Food) {
    const rowId = await this.rdbStore?.insert(this.TABLE_NAME, value)
    console.log('zhu 增 rowId=' + rowId)
    return (rowId && rowId > -1) ? Promise.resolve(rowId) : Promise.reject('insert error')
  }

  // 批量新增
  async batchInsert(values: Food[]) {
    const rowId = await this.rdbStore?.batchInsert(this.TABLE_NAME, values)
    console.log('zhu 批量增 rowId=' + rowId)
    return rowId ? Promise.resolve(rowId) : Promise.reject('batchInsert error')
  }

  // 更新
  async update(item: Food) {
    if (!item.id_) {
      return Promise.reject('id error')
    }
    const predicates = new relationalStore.RdbPredicates(this.TABLE_NAME)
    predicates.equalTo('id_', item.id_)
    const rowCount = await this.rdbStore?.update(item, predicates)
    console.log('zhu 改 rowCount=' + rowCount)
    return rowCount ? Promise.resolve(rowCount) : Promise.reject('update error')
  }

  // 删除
  async delete(id_: string) {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_NAME)
    predicates.equalTo('id_', id_)
    const rowCount = await this.rdbStore?.delete(predicates)
    console.log('zhu 删 rowCount=' + rowCount)
    return rowCount ? Promise.resolve(rowCount) : Promise.reject('delete error')
  }

  // 批量删除
  async batchDelete(ids: string[]) {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_NAME)
    predicates.in('id_', ids)
    const rowCount = await this.rdbStore?.delete(predicates)
    console.log('zhu 批量删 rowCount=' + rowCount)
    return rowCount ? Promise.resolve(rowCount) : Promise.reject('delete error')
  }

  // 查询
  async query(id_: string) {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_NAME)
    // 添加日期倒序排列
    predicates.orderByDesc('date_added')
    // 如果有 id
    if (id_) {
      predicates.equalTo('id_', id_)
    }
    const resultSet = await this.rdbStore?.query(predicates)
    const list: Food[] = []
    while (resultSet && resultSet.goToNextRow()) {
      // 获取数据
      const data: Food = {
        id_: resultSet.getString(resultSet.getColumnIndex('id_')),
        name: resultSet.getString(resultSet.getColumnIndex('name')),
        stock: resultSet.getLong(resultSet.getColumnIndex('stock')),
        price: resultSet.getLong(resultSet.getColumnIndex('price')),
        des: resultSet.getString(resultSet.getColumnIndex('des')),
        icon_id: resultSet.getLong(resultSet.getColumnIndex('icon_id')),

      }
      // 追加到数组中
      list.push(data)
    }
    console.log('zhu 查询单个id list.length=' + list.length)
    // 释放资源
    resultSet?.close()
    return list
  }

  // 查询
  async queryAll() {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_NAME)
    // 添加日期倒序排列
    //predicates.orderByDesc('date_added')
    // 如果有 id
    // if (id_) {
    //   predicates.equalTo('id_', id_)
    // }
    const resultSet = await this.rdbStore?.query(predicates)
    const list: Food[] = []
    while (resultSet && resultSet.goToNextRow()) {
      // 获取数据
      const data: Food = {
        id_: resultSet.getString(resultSet.getColumnIndex('id_')),
        name: resultSet.getString(resultSet.getColumnIndex('name')),
        stock: resultSet.getLong(resultSet.getColumnIndex('stock')),
        price: resultSet.getLong(resultSet.getColumnIndex('price')),
        des: resultSet.getString(resultSet.getColumnIndex('des')),
        icon_id: resultSet.getLong(resultSet.getColumnIndex('icon_id')),

      }
      // 追加到数组中
      list.push(data)
    }
    console.log('zhu 查询所有 list.length=' + list.length)
    // 释放资源
    resultSet?.close()
    return list
  }
}

let util2 = new DbUtil()

export default util2 as DbUtil