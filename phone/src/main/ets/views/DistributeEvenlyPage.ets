export interface NavItem {
  id: number
  icon: ResourceStr
  title: string
}

@Entry
@Component
struct DistributeEvenlyPage {
  readonly list: NavItem [] = [
    { id: 1, icon: $r('app.media.ic_nav_01'), title: '淘金币' },
    { id: 2, icon: $r('app.media.ic_nav_02'), title: '摇现金' },
    { id: 3, icon: $r('app.media.ic_nav_03'), title: '闲鱼' },
    { id: 4, icon: $r('app.media.ic_nav_04'), title: '中通快递' },
  ]
  @State rate: number = 600

  // 底部滑块，可以通过拖拽滑块改变容器尺寸
  @Builder
  sliderBuilder() {
    Slider({
      value: this.rate,
      min: 200,
      max: 600,
      style: SliderStyle.OutSet
    })
      .onChange((value: number) => {
        this.rate = value
      })
      .blockColor(Color.White)
      .width('60%')
      .position({ x: '20%', y: '80%' })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 标记现在的宽度
      Text('宽度:' + this.rate.toFixed(0))
        .zIndex(2)
        .translate({ x: 20, y: 20 })
        .fontColor(Color.Orange)

      Column() {
        Column() {
          // 布局能力 2：均分能力
          // 指容器组件尺寸发生变化时，增加或减小的空间均匀分配给容器组件内所有【空白区域】。
          // 常用于内容数量固定、均分显示的场景，比如工具栏、底部菜单栏、导航栏等

          // 涉及属性:
          // Row、Column、Flex 组件的 justifyContent 属性
          // justifyContent设置为 FlexAlign.SpaceEvenly即可
          Row() {
            ForEach(this.list, (item: NavItem) => {
              Column({ space: 8 }) {
                Image(item.icon)
                  .width(48)
                  .height(48)
                Text(item.title)
                  .fontSize(12)
              }
              .justifyContent(FlexAlign.Center)
              .width(80)
              .height(102)
              .backgroundColor('#8FBF9F')
              .borderRadius(10)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)

        }
        .width(this.rate) // 绑定滑块改变的尺寸
        .padding({ top: 10, bottom: 10 })
        .backgroundColor(Color.White)
        .borderRadius(16)

        this.sliderBuilder()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Pink)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
  }
}