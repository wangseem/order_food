import { Category } from './Food'
import { ItemType } from './types'

class MyData {
  imgIdList: number[] = [10, 11, 12, 13, 14, 15, 16, 20, 21, 22, 23,
    30,31,32,33,40,41,42,43,50,51,52,53]
  imgResList: Resource[] = [
    //10
    $r('app.media.xican'),
    $r('app.media.hanbao2'),
    $r('app.media.shala'),
    $r('app.media.pisa'),
    $r('app.media.yidalimian'),
    $r('app.media.xiangchang'),
    $r('app.media.regou'),
    //20
    $r('app.media.chaocai'),
    $r('app.media.shuizhuyu'),
    $r('app.media.malaxianguo'),
    $r('app.media.huiguorou'),
    //30
    $r('app.media.miantiao'),
    $r('app.media.banmian'),
    $r('app.media.daoxiaomian'),
    $r('app.media.xiaomian'),
    //40
    $r('app.media.gaifan'),
    $r('app.media.xihongshi'),
    $r('app.media.tudou'),
    $r('app.media.huiguorougaifan'),
    //50
    $r('app.media.yinliao'),
    $r('app.media.kele'),
    $r('app.media.chengzhi'),
    $r('app.media.lvcha'),
  ]

  getImgRes(imgId: number): Resource {
    let ind = this.imgIdList.indexOf(imgId)
    return this.imgResList[ind]
  }

  mineList: Array<ItemType> = [
    {
      title: '收藏管理',
      img: $r('app.media.ic_shoucang')
    },
    {
      title: '隐私协议',
      img: $r('app.media.ic_privacy')
    },
    {
      title: '热卖推荐',
      img: $r('app.media.ic_tongzhi')
    },
    {
      title: '推送开关',
      img: $r('app.media.ic_data')
    },
    {
      title: '关于我们',
      img: $r('app.media.ic_guanyuwomen')
    },
  ]

  categoryList: Category[] = [
    {
      name: '西餐',
      logo_id: 10,
      foodList: [
        {
          id_: '11',
          name: '德州祖师爷汉堡',
          stock: 998,
          price: 15,
          des: '汉堡是面包夹肉',
          icon_id: 11
        },
        {
          id_: '12',
          name: '加州水果沙拉',
          stock: 91,
          price: 13,
          des: 'xx',
          icon_id: 12
        },
        {
          id_: '13',
          name: '佛罗里达披萨',
          stock: 77,
          price: 8,
          des: '汉堡是面包夹肉',
          icon_id: 13
        },
        {
          id_: '14',
          name: '意大利面',
          stock: 59,
          price: 13,
          des: 'xx',
          icon_id: 14
        },
        {
          id_: '15',
          name: '法国香肠',
          stock: 91,
          price: 19,
          des: '汉堡是面包夹肉',
          icon_id: 15
        },
        {
          id_: '16',
          name: '德国热狗',
          stock: 99,
          price: 21,
          des: 'xx',
          icon_id: 16
        }
      ]
    },
    {
      name: '湘菜',
      logo_id: 20,
      foodList: [
        {
          id_: '21',
          name: '水煮鱼',
          stock: 99,
          price: 32,
          des: 'sdfs',
          icon_id: 21
        },
        {
          id_: '22',
          name: '麻辣香锅',
          stock: 76,
          price: 45,
          des: 'sdfs',
          icon_id: 22
        },
        {
          id_: '23',
          name: '回锅肉',
          stock: 73,
          price: 31,
          des: 'sdfs',
          icon_id: 23
        }
      ]
    },
    {
      name: '面食类',
      logo_id: 30,
      foodList: [
        {
          id_: '31',
          name: '正宗安徽版面加鸡蛋',
          stock: 9,
          price: 15,
          des: 'adgadfg',
          icon_id: 31
        },
        {
          id_: '32',
          name: '陕西刀削面',
          stock: 88,
          price: 18,
          des: 'adgadfg',
          icon_id: 32
        },
        {
          id_: '33',
          name: '正宗重庆小面',
          stock: 99,
          price: 19,
          des: 'adgadfg',
          icon_id: 33
        }
      ]
    },
    {
      name: '盖饭类',
      logo_id: 40,
      foodList: [
        {
          id_: '31',
          name: '西红柿鸡蛋盖饭',
          stock: 9,
          price: 15,
          des: 'adgadfg',
          icon_id: 41
        },
        {
          id_: '42',
          name: '土豆牛肉盖饭',
          stock: 88,
          price: 18,
          des: 'adgadfg',
          icon_id: 42
        },
        {
          id_: '43',
          name: '回锅肉盖饭',
          stock: 99,
          price: 19,
          des: 'adgadfg',
          icon_id: 43
        }
      ]
    },
    {
      name: '饮品类',
      logo_id: 50,
      foodList: [
        {
          id_: '51',
          name: '可乐',
          stock: 23,
          price: 5,
          des: 'adgadfg',
          icon_id: 51
        },
        {
          id_: '52',
          name: '汇源橙汁',
          stock: 11,
          price: 10,
          des: 'adgadfg',
          icon_id: 52
        },
        {
          id_: '53',
          name: '茉莉绿茶',
          stock: 44,
          price: 6,
          des: 'adgadfg',
          icon_id: 53
        }
      ]
    }
  ]

}

let mydata = new MyData()

export default mydata as MyData