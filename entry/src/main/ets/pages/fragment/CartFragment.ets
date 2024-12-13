import { promptAction } from '@kit.ArkUI';
import Food from '../../modle/Food';
import MyData from '../../modle/MyData';
import DbUtil from '../../util/DbUtil';
import { emitter } from '@kit.BasicServicesKit';

@Entry
@Preview
@Component
export default struct CartFragment {
  @State sumPrice: number = 0
  @Prop @Watch('calculatePrice') cartList: Food[] = [];
  @State eatType: string = '堂食'

  aboutToAppear() {
    //this.cartList = MyData.categoryList[0].foodList
    emitter.on({ eventId: 1 }, (event) => {
      let eatType: string = event?.data?.['eatType'].toString();
      console.log('zhu emitter.on() eatType=' + eatType);
      this.eatType = eatType
    });
  }

  calculatePrice() {
    let tempPrice = 0
    this.cartList.map((item: Food) => {
      tempPrice += item.price
    })
    this.sumPrice = tempPrice
  }

  /**
   * 删除单个触发
   */
  deleteOne(item1: Food) {
    DbUtil.delete(item1.id_)

    const newArray = this.cartList.filter(item => item.id_ != item1.id_);
    this.cartList = newArray
    //this.calculatePrice()

    promptAction.showToast({
      message: '删除成功!',
      duration: 1000,
      bottom: '360vp'
    })
  }

  /**
   * 点击底部提交按钮
   */
  commitBtn() {
    if (this.sumPrice <= 0) {
      promptAction.showToast({
        message: '请选择商品!',
        duration: 1000,
        bottom: '360vp'
      })
      return
    }

    //处理数据库
    let selectArr: string[] = []
    this.cartList.map((item: Food) => {
      selectArr.push(item.id_)
    })
    DbUtil.batchDelete(selectArr)

    //处理本地数据
    this.cartList = []
    //this.calculatePrice()

    promptAction.showToast({
      message: '支付成功!',
      duration: 1000,
      bottom: '360vp'
    })
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {

      Scroll() {
        Column() {
          Blank().height(50)
          if (this.cartList.length > 0) {
            List({ space: '15vp' }) {
              ForEach(this.cartList, (item: Food, index?: number) => {
                ListItem() {
                  if (index !== undefined) {
                    this.CartItem(item, index)
                  }
                }
                .swipeAction({ end: this.DeleteBtn(item) })
              })
            }
          } else {
            Column() {
              //没有数据
              this.emptyView();
            }
            .width('100%')
            .height('50%')
          }
        }.height('100%')
      }
      .scrollBar(BarState.Off)
      .margin({
        left: 12,
        right: 12,
        top: 16
      })
      .height('100%')

      //if ((this.selectProducts).some(((item: Food) => item.is_selected === true))) {
      this.BottomView()
      //}
    }
    .width('100%')
    .backgroundColor('#f1f3f5')
  }

  @Builder
  BottomView() {
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.End }) {
        Text('总计：')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
        Text() {
          Span('￥')
            .fontSize(12)
            .fontColor('#e92f4f')
          Span(`${this.sumPrice}`)
            .fontSize(16)
            .fontColor('#e92f4f')
        }
        .margin({
          right: 8,
          left: 8
        })

        Button('余额支付', { type: ButtonType.Capsule, stateEffect: true })
          .backgroundColor((this.sumPrice == 0) ? '#ffe9792f' : '#e92f4f')
          .fontSize(12)
          .height(40)
          .width(100)
          .onClick(() => {
            this.commitBtn()
          })
      }
      .height('100%')
    }
    .padding({
      right: 12,
      left: 12
    })
    .backgroundColor(Color.White)
    .width('100%')
    .height(56)
  }

  @Builder
  CartItem(item: Food, index: number) {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {

      Row() {
        Text(this.eatType)
          .backgroundColor(Color.Red)
          .padding({
            left: 3,
            right: 3,
            top: 2,
            bottom: 2
          })
          .borderRadius(4)
          .fontSize(15)
          .fontColor(Color.White)

        Text($r('app.string.restaurant_name'))
          .padding(2)
          .margin({ left: 5 })
          .fontSize(17)
          .fontColor(Color.Black)
      }
      .margin({ top: 12 })
      .width('100%')

      Row() {
        Image(MyData.getImgRes(item.icon_id))
          .height('80vp')
          .width('80vp')
          .objectFit(ImageFit.Cover)
          .margin({ left: 12 })
          .borderRadius(10)
        Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceAround }) {
          Text(`${item.name}`)
            .fontSize(14)
            .margin({ bottom: 8 })
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(2)
            .width('100%')
          Text(`${item.des}`)
            .fontSize('12')
            .maxLines(1)
            .fontColor('#99000000')
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            Text() {
              Span('￥')
                .fontSize(12)
                .fontColor('#e92f4f')
              Span(`${item.price}`)
                .fontSize(16)
                .fontColor('#e92f4f')
            }.width(100)

          }
          .width('100%')
        }
        .margin({
          left: 12,
          top: 12,
          bottom: 12
        })
        .width('40%')
      }
      .margin({ top: 5 })
      .width('100%')
    }
    .padding({
      left: 12,
      right: 12
    })
    .borderRadius(16)
    .backgroundColor(Color.White)
    .width('100%')
    .height('135vp')
  }

  @Builder
  emptyView() {
    Flex({
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center,
      direction: FlexDirection.Column
    }) {
      Image($r('app.media.ic_empty'))
        .width(150)
        .height(150)
      /*Text('No data')
        .fontSize(10)
        .margin({ top: 10 })*/
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  DeleteBtn(item: Food) {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.End
    }) {
      Column() {
        Image($r('app.media.ic_trash'))
          .width(24)
          .height(24)
          .margin({ bottom: 10 })
        Text('删除')
          .fontSize(14)
          .fontColor(Color.White)
      }
      .padding({ right: 14 })
    }
    .onClick(() => {
      this.deleteOne(item)
    })
    .height(112)
    .width(80)
    .backgroundColor('#e92f4f')
    .borderRadius(16)
    .margin({ left: -24 })
  }
}