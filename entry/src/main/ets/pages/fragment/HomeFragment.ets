import { promptAction } from "@kit.ArkUI";
import MyData from "../../modle/MyData";
import { emitter } from "@kit.BasicServicesKit";

@Entry
@Component
export struct HomeFragment {
  @State message: string = 'Hello World';

  toast(s: string) {
    promptAction.showToast({
      message: s,
      duration: 1000,
      bottom: '360vp'
    })
  }

  build() {
    Column() {
      Blank().height(50)
      // 轮播图
      Swiper() {
        Image($r('app.media.banner1'))
        Image($r('app.media.banner2'))
        Image($r('app.media.banner3'))
      }
      .margin({ left: 16, right: 16 })
      .borderRadius(10)
      .formSwiperStyle()
      .aspectRatio(2) // 设置和图片一致的宽高比
      .loop(true) // 开启循环
      .autoPlay(true) // 自动播放
      .interval(3000) // 自动播放间隔时间
      .vertical(false) // 横向
      // 定制小圆点
      .indicator(
        Indicator.dot()
          .itemWidth(6)
          .itemHeight(6)
          .color(Color.White)
          .selectedItemWidth(12)
          .selectedItemHeight(6)
          .selectedColor($r('app.color.main'))
          .bottom(5)
      )

      Row() {
        Row() {
          Stack() {
            Stack().width(65).height(65)
              .borderRadius(32.5)
              .backgroundColor(Color.White)
            Image($r('app.media.meinv0'))
              .width(60)
              .width(60)
              .borderRadius(30)
          }.alignContent(Alignment.Center)

          Column({ space: 5 }) {
            Text('Hi,你好')
            Text('余额：2350')
            Text('积分：320')
          }
          .margin({ left: 20 }).alignItems(HorizontalAlign.Start)
        }
      }
      .borderRadius(10)
      .backgroundColor($r('app.color.tint_main'))
      .width('95%')
      .padding(15)
      //.position({ x: 8, y: 260 })
      .margin({ top: 30 })
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Column() {
          Image($r('app.media.tangshi'))
            .formLogoStyle()
          Text('堂食')
        }.onClick(() => {
          this.toast('已选择：堂食')
          emitter.emit(
            { eventId: 1, priority: emitter.EventPriority.IMMEDIATE },
            { data: { 'eatType': '堂食' } }
          );
        })

        Column() {
          Image($r('app.media.dabao'))
            .formLogoStyle()
          Text('外带')
        }
        .onClick(() => {
          this.toast('已选择：外带')
          emitter.emit(
            { eventId: 1, priority: emitter.EventPriority.IMMEDIATE },
            { data: { 'eatType': '外带' } }
          );
        })
      }
      .borderRadius(10)
      .height(100)
      .width('95%')
      .margin({ top: 10 })
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 60, right: 60 })
      .backgroundColor('#F5F5F5')

      Row() {
        Column() {
          Image($r('app.media.qianbao'))
            .formLogoStyle()
          Text('支付方式')
        }.onClick(() => {
          this.toast('支付方式')
        })

        Column() {
          Image($r('app.media.qiandaizi'))
            .formLogoStyle()
          Text('会员充值')
        }.onClick(() => {
          this.toast('会员充值')
        })

        Column() {
          Image($r('app.media.liwu'))
            .formLogoStyle()
          Text('天天福利')
        }.onClick(() => {
          this.toast('天天福利')
        })

        Column() {
          Image($r('app.media.kaquan'))
            .formLogoStyle()
          Text('我的卡券')
        }.onClick(() => {
          this.toast('我的卡券')
        })

      }
      .borderRadius(10)
      .height(100)
      .width('95%')
      .margin({ top: 10 })
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        left: 20,
        right: 20,
        top: 10,
        bottom: 10
      })
      .backgroundColor('#F5F5F5')

      Row({space:10}){
        Image($r('app.media.hanbao')).layoutWeight(1).borderRadius(10).height(110)
        Image($r('app.media.xican2')).layoutWeight(1).borderRadius(10).height(110)
      }.padding(15)

    }
    .height('100%')

  }
}

@Styles
function formSwiperStyle() {
  .height(300)
  .width('100%')
}

@Styles
function formLogoStyle() {
  .width(40)
  .height(30)
  .margin({ bottom: 10 })
}
