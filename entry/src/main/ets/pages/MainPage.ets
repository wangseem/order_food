import { HomeFragment } from './fragment/HomeFragment';
import { MineFragment } from './fragment/MineFragment';
import { FoodListFragment } from './fragment/FoodListFragment';
import CartFragment from './fragment/CartFragment';
import DbUtil from '../util/DbUtil';
import Food from '../modle/Food';

export const Path_Main = 'pages/MainPage'

@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World';
  @State selectedIndex: number = 0
  @State pruducts: Food[] = [];

  @Builder
  myBuilder(itemIndex: number, title: string, icon1: ResourceStr, icon2: ResourceStr) {
    Column() {
      Image(itemIndex == this.selectedIndex ? icon2 : icon1)
        .width(25)
      Text(title)
        .fontColor(itemIndex == this.selectedIndex ? Color.Red : Color.Black)
        .margin({top:8})
    }
  }

  build() {
    Column() {
      Tabs({
        // 导航位置
        barPosition: BarPosition.End
      }) {
        TabContent() {
          HomeFragment()
        }
        .tabBar(this.myBuilder(0, '首页', $r('app.media.home_black'), $r('app.media.home_red')));

        TabContent() {
          FoodListFragment()
        }
        .tabBar(this.myBuilder(1, '点餐', $r('app.media.diancan_black'), $r("app.media.diancan_red")))

        TabContent() {
          CartFragment({cartList:this.pruducts})
        }
        .tabBar(this.myBuilder(2, '下单', $r('app.media.shop'), $r('app.media.shop_active')))

        TabContent() {
          MineFragment()
        }
        .tabBar(this.myBuilder(3, '我的', $r('app.media.mine_black'), $r('app.media.mine_red')))

      }
      .barPosition(BarPosition.End)
      .padding({bottom:30})
      .onChange(async (index) => {
        this.selectedIndex = index
        if(index == 2){
          this.pruducts = await DbUtil.queryAll()
        }
      })

    }
    .height('100%')
    .width('100%')
  }
}