@Entry
@Component
struct GridPage {
  @State currentBreakPoint: string = 'sm'

  build() {
    Column() {
      // GridRow 默认支持 4 个断点
      //  xs:(0vp<=width<320vp) 智能穿戴，比如手表
      //  sm:(320vp<=width<600vp) 手机
      //  md:(600vp<=width<840vp) 折叠屏
      //  lg:(840vp<=width) 平板
      GridRow({
        breakpoints: {
          value: ['320vp','600vp', '860vp', '1440vp', '1600vp']
        }
      }) {
        ForEach(Array.from({ length: 12 }), (item: string, index: number) => {
          GridCol() {
            Text(index.toString())
          }
          .height(100)
          .border({ width: 1, color: Color.Black })
        })
      }
      .width('90%')
      .height('90%')
      .border({ width: 1, color: Color.Orange })
      .onBreakpointChange((breakpoints)=> {
        this.currentBreakPoint = breakpoints
      })

      Text(`断点值: ${this.currentBreakPoint}`)
        .fontSize(30)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#dcdfe8')
    .expandSafeArea([SafeAreaType.SYSTEM])
  }
}