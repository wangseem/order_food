import router from '@ohos.router';
import { Path_Login } from '../../pages/LoginPage';
import MyData from '../../modle/MyData';
import { ItemType } from '../../modle/types';
import { promptAction } from '@kit.ArkUI';

@Preview
@Entry
@Component
export struct MineFragment {
  build() {
    Column() {
      Column() {
        // 用户描述组件
        MineUser()
        // 用户列表组件
        MineList()
        // 退出登录
        Button('退出登录')
          .width('90%')
          .height('40vp')
          .fontSize('16fp')
          .backgroundColor('#e5e8ea')
          .fontColor(Color.Red)
          .margin({
            top: '30vp'
          })
          .onClick(() => {
            router.replaceUrl({
              url: Path_Login
            }).catch((error: Error) => {
              // 异常处理
            })
          })
      }
      .width('100%')
      .height('100%')
      .margin('10vp')
      .padding('10vp')
    }
    .backgroundColor('#f1f3f5')
  }
}

@Component
export struct MineUser {
  @State message: string = '用户描述';

  build() {
    Row() {
      Image($r('app.media.meinv0'))
        .width('50vp')
        .height('50vp')
        .borderRadius(7)
      Column() {
        Text('祖师爷')
          .fontSize('20fp')
        Text('zushiye1314@tt.com')
          .fontSize('14fp')
          .margin({ top: '5vp' })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: '15vp' })
    }
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .width('100%')
    .height('100vp')
    .margin({
      top: '30vp',
      bottom: '12vp'
    })
    .borderRadius('25vp')
    .padding({
      left: '20vp'
    })
  }
}

@Component
export struct MineList {
  @State message: string = '用户列表';

  build() {
    List() {
      ForEach(MyData.mineList, (item: ItemType, index: number) => {
        ListItem() {
          Row() {
            Row({ space: 10 }) {
              Image(item.img)
                .width('22vp')
                .height('22vp')
              Text(item.title)
                .fontSize('16fp')
            }

            // 开关组件
            Toggle({
              type: ToggleType.Switch, isOn: false
            }).onChange((isChange: boolean) => {
              // isChange打开或关闭状态
              let tip: string = isChange ? '系统选项打开' : '系统选项关闭'
              promptAction.showToast({
                message: tip,
                duration: 2000
              })
            }).visibility(item.title == '推送开关' ? Visibility.Visible : Visibility.Hidden)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding('12vp')
        }
        .height('50vp')
      })
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius('25vp')
    .divider({
      color: '#dddddd',
      strokeWidth: '1vp',
      startMargin: '46vp', // 分割线开始位置
      endMargin: '12vp' // 分割线结束位置
    })
    .padding({
      top: '5vp',
      bottom: '5vp'
    })
  }
}